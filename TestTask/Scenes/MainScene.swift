//
//  MainScene.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import SpriteKit
import UIKit

final class MainScene: SKScene {
    private let cameraNode: SKCameraNode = SKCameraNode()
    private let mechanics: CanvasMechanicsProtocol = CanvasMechanicsInitializer.createDefault()

    override func didMove(to view: SKView) {
        backgroundColor = UIColor.lightGray
        camera = cameraNode
        handleBindings()
        mechanics.handleDidMove()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        
        mechanics.handleTouchesBeganTouch(
            at: touch.timestamp,
            to: location,
            node: nodes.first
        )
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        
        mechanics.handleTouchesMoved(
            from: previousLocation,
            to: location
        )
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        mechanics.handleTouchesEnded()
    }
    
    override func update(_ currentTime: TimeInterval) {
        mechanics.handleUpdateAt(time: currentTime)
    }
    
    func handleBindings() {
        mechanics.highlightVector.bind { [weak self] identifier in
            guard let self,
                  let vector = self.childNode(withName: identifier) as? Vector else { return }
            vector.highlight()
        }
        
        mechanics.deleteVector.bind { [weak self] identifier in
            guard let self,
                  let vector = self.childNode(withName: identifier) else { return }
            vector.removeFromParent()
        }
        
        mechanics.cameraLocation.bind { [weak self] location in
            guard let self else { return }
            self.camera?.position = location
        }
        
        mechanics.vectorForAdd.bind({ [weak self] vector in
            guard let self else { return }
            self.addChild(vector)
        })
    }
}
