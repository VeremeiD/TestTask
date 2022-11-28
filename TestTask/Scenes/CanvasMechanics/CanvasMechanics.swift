//
//  CanvasMechanics.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation
import SpriteKit

final class CanvasMechanics: CanvasMechanicsProtocol {
    private var vectorMovingModule: VectorMoving
    private var alignmentModule: VectorAlignment
    private var intersectionModule: VectorIntersectionModule
    private var cameraMovingModule: CameraMoving
    private var canvasManager: CanvasManagerProtocol
    
    private var selectedVector: VectorProtocol?
    private var selectedPoint: VectorPointOption = .none
    
    private(set) var cameraLocation: Dynamic<CGPoint> = Dynamic(CGPoint.zero)
    private(set) var vectorForAdd: Dynamic<VectorProtocol> = Dynamic(Vector.empty())
    private(set) var deleteVector: Dynamic<String>
    private(set) var highlightVector: Dynamic<String>
    
    private var vectors: [VectorModel] = []
    
    private var touchStarted: Bool = false
    private var touchStartTime: TimeInterval = 0
    private var isLongPress: Bool = false
    
    init(
        alignmentModule: VectorAlignment,
        intersectionModule: VectorIntersectionModule,
        cameraMovingModule: CameraMoving,
        vectorMovingModule: VectorMoving,
        canvasManager: CanvasManagerProtocol
    ) {
        self.alignmentModule = alignmentModule
        self.intersectionModule = intersectionModule
        self.cameraMovingModule = cameraMovingModule
        self.vectorMovingModule = vectorMovingModule
        self.canvasManager = canvasManager
        deleteVector = canvasManager.vectorDeleted
        highlightVector = canvasManager.vectorSelected
    }
    
    // MARK: Did move
    func handleDidMove() {
        handleBindings()
    }
    
    func handleBindings() {
        canvasManager.vectorAdded.bind { [unowned self] model in
            let vector = Vector(
                from: model.startPoint,
                to: model.endPoint,
                name: model.identifier,
                color: model.vectorColor
            )
            self.vectorForAdd.value = vector
            self.vectors.append(model)
        }
        
        canvasManager.getModels { [unowned self] models in
            self.vectors = models
            setupVectors()
        }
    }
    
    func setupVectors() {
        for model in vectors {
            let vector = Vector(
                from: model.startPoint,
                to: model.endPoint,
                name: model.identifier,
                color: model.vectorColor
            )
            vectorForAdd.value = vector
        }
    }

    // MARK: Touches began
    func handleTouchesBeganTouch(
        at time: TimeInterval,
        to location: CGPoint,
        node: SKNode?
    ) {
        setupSelected(node: node, in: location)
        touchStarted = true
        touchStartTime = time
    }
    
    private func setupSelected(node: SKNode?, in location: CGPoint) {
        guard let node = node else {
            selectedVector = nil
            selectedPoint = .none
            return
        }
        
        switch node.name {
        case "start":
            selectedVector = node.parent as? VectorProtocol
            selectedPoint = .start
            break
        case "end":
            selectedVector = node.parent as? VectorProtocol
            selectedPoint = .end
            break
        default:
            guard checkTouchOn(node: node, in: location) else { return }
            selectedVector = node as? VectorProtocol
            selectedPoint = .node
            return
        }
    }
    
    // MARK: Touches moved
    func handleTouchesMoved(
        from previous: CGPoint,
        to location: CGPoint
    ) {
        handleMoving(
            to: location,
            previous: previous
        )
    }
    
    private func handleMoving(to location: CGPoint, previous: CGPoint) {
        switch selectedPoint {
        case .start:
            guard let selectedVector,
                  isLongPress else { return }
            let finalPoint = chainOfChecks(to: location)
            vectorMovingModule.move(
                vector: selectedVector,
                withSelected: selectedPoint,
                to: finalPoint
            )
            break
        case .end:
            guard let selectedVector,
                  isLongPress else { return }
            let finalPoint = chainOfChecks(to: location)
            vectorMovingModule.move(
                vector: selectedVector,
                withSelected: selectedPoint,
                to: finalPoint
            )
            break
        case .node:
            guard let selectedVector,
                  isLongPress else { return }
            vectorMovingModule.move(
                vector: selectedVector,
                to: location,
                previousLocation: previous
            )
            break
        case .none:
            let position = cameraMovingModule.moveCameraFrom(
                location: cameraLocation.value,
                toLocation: location,
                previousLocation: previous
            )
            cameraLocation.value = position
            break
        }
    }
    
    private func chainOfChecks(to point: CGPoint) -> CGPoint {
        let distanceStickingCheck = distanceStickingCheck(to: point)
        let intersectionCheck = intersectionCheck(with: point)

        if let intersectionCheck {
            return intersectionCheck
        } else if let distanceStickingCheck {
            return distanceStickingCheck
        } else {
            return point
        }
    }
    
    private func intersectionCheck(with location: CGPoint) -> CGPoint? {
        for vector in vectors {
            let result = intersectionModule.checkIntersectionBetween(
                staticVectorStart: vector.startPoint,
                staticVectorEnd: vector.endPoint,
                touchLocation: location,
                selectedPoint: selectedPoint
            )
            guard result != .noIntersection else { break }
            return result.intersectionPoint
        }
        return nil
    }
    
    private func distanceStickingCheck(to point: CGPoint) -> CGPoint? {
        guard let selectedVector else { return nil }
        switch selectedPoint {
        case .start:
            return alignmentModule.manageStickingByDistance(
                staticPoint: selectedVector.endPoint.position,
                movingPoint: point
            )
        case .end:
            return alignmentModule.manageStickingByDistance(
                staticPoint: selectedVector.startPoint.position,
                movingPoint: point
            )
        default:
            return nil
        }
    }
    
    // MARK: Touches ended
    func handleTouchesEnded() {
        if let selectedVector,
           let index = vectors.firstIndex(where: { $0.identifier == selectedVector.identifier })
        {
            let old = vectors.remove(at: index)
            let model = VectorModel(
                identifier: old.identifier,
                startPoint: selectedVector.startPoint.position,
                endPoint: selectedVector.endPoint.position,
                vectorColor: selectedVector.color,
                length: selectedVector.length
            )
            
            canvasManager.update(vector: model) { [unowned self] flag in
                guard flag else { return }
                self.vectors.append(model)
                self.selectedPoint = .none
                self.selectedVector = nil
            }
        } else {
            selectedPoint = .none
            selectedVector = nil
        }
        
        touchStarted = true
        touchStartTime = 0
        isLongPress = false
    }
    
    // MARK: Update
    func handleUpdateAt(time: TimeInterval) {
        guard touchStarted else { return }
        let longPress = (0.6...0.8).contains(time - touchStartTime)
        guard longPress else { return }
        isLongPress = true
    }
    
    private func checkTouchOn(node: SKNode, in location: CGPoint) -> Bool {
        guard let node = node as? VectorProtocol else { return false }
        let startPos = node.startPoint.position
        let endPos = node.endPoint.position
        let step = node.startPoint.path!.boundingBox.width

        let pointA = CGPoint(x: startPos.x - step, y: startPos.y)
        let pointB = CGPoint(x: endPos.x - step, y: endPos.y)
        let pointC = CGPoint(x: endPos.x + step, y: endPos.y)
        let pointD = CGPoint(x: startPos.x + step, y: startPos.y)
        
        let path = CGMutablePath()
        path.move(to: pointA)
        path.addLine(to: pointB)
        path.addLine(to: pointC)
        path.addLine(to: pointD)
        path.addLine(to: pointA)
        
        return path.contains(location)
    }
}
