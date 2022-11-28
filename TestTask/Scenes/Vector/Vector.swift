//
//  Vector.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 22.11.22.
//

import Foundation
import SpriteKit

class Vector: SKShapeNode, VectorProtocol {
    var startPoint: SKShapeNode { self.childNode(withName: "start") as! SKShapeNode }
    var endPoint: SKShapeNode { self.childNode(withName: "end") as! SKShapeNode }
    var length: Float { startPoint.position.distance(to: endPoint.position) }
    var identifier: String { self.name ?? "vectorline" }
    var color: UIColor { self.strokeColor }

    init(from: CGPoint, to: CGPoint, name: String, color: UIColor) {
        super.init()
        self.name = name
        lineWidth = 3.0
        lineCap = .round
        strokeColor = color

        addChild(createRound(withName: "start"))
        addChild(createRound(withName: "end"))
        
        redraw(from: from, to: to, direction: .none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func highlight() {
        let up = SKAction.run { self.lineWidth = 5.0 }
        let wait = SKAction.wait(forDuration: 0.8)
        let down = SKAction.run { self.lineWidth = 3.0 }
        let queue = SKAction.sequence([up, wait, down])
        
        run(queue)
    }
    
    private func createRound(withName name: String) -> SKShapeNode {
        let shape = SKShapeNode(circleOfRadius: 12.0)
        shape.name = name
        shape.fillColor = .clear
        shape.strokeColor = .clear
        
        return shape
    }
    
    func redraw(from: CGPoint, to: CGPoint, direction: VectorPointOption) {
        let newPath = CGMutablePath()
        
        switch direction {
        case .start:
            startPoint.position = to
        case .end:
            endPoint.position = to
        default:
            startPoint.position = from
            endPoint.position = to
        }
        
        newPath.move(to: startPoint.position)
        newPath.addLine(to: endPoint.position)
        
        drawArrowTo(path: newPath, from: startPoint.position, to: endPoint.position)
        path = newPath
    }
    
    private func drawArrowTo(path: CGMutablePath, from: CGPoint, to: CGPoint) {
        let arrowAngle = 145.0
        let pointerLineLength = 10.0

        let startEndAngle = atan((to.y - from.y) / (to.x - from.x)) + ((to.x - from.x) < 0 ? CGFloat(Double.pi) : 0)
        
        let arrowLine1 = CGPoint(
            x: to.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle + arrowAngle),
            y: to.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle + arrowAngle)
        )
        
        let arrowLine2 = CGPoint(
            x: to.x + pointerLineLength * cos(CGFloat(Double.pi) - startEndAngle - arrowAngle),
            y: to.y - pointerLineLength * sin(CGFloat(Double.pi) - startEndAngle - arrowAngle)
        )
        
        path.addLine(to: arrowLine1)
        path.move(to: to)
        path.addLine(to: arrowLine2)
    }
    
    static func empty() -> Vector {
        return Vector(from: .zero, to: .zero, name: "", color: .random)
    }
}
