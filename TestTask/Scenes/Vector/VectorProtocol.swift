//
//  VectorProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation
import SpriteKit

protocol VectorProtocol: SKShapeNode {
    var startPoint: SKShapeNode { get }
    var endPoint: SKShapeNode { get }
    var length: Float { get }
    var identifier: String { get }
    var color: UIColor { get }
    
    func redraw(from: CGPoint, to: CGPoint, direction: VectorPointOption)
}
