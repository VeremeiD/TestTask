//
//  CanvasMechanicsProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation
import SpriteKit

protocol CanvasMechanicsProtocol {
    var vectorForAdd: Dynamic<VectorProtocol> { get }
    var deleteVector: Dynamic<String> { get }
    var highlightVector: Dynamic<String> { get }
    var cameraLocation: Dynamic<CGPoint> { get }

    func handleDidMove()
    func handleTouchesBeganTouch(at time: TimeInterval, to location: CGPoint, node: SKNode?)
    func handleTouchesMoved(from previous: CGPoint, to location: CGPoint)
    func handleTouchesEnded()
    func handleUpdateAt(time: TimeInterval)
}
