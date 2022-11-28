//
//  VectorMovingModule.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation

final class VectorMovingModule: VectorMoving {
    func move(
        vector: VectorProtocol,
        withSelected point: VectorPointOption,
        to position: CGPoint
    ) {
        let from = point == .start
                    ? vector.endPoint.position
                    : vector.startPoint.position
        
        vector.redraw(
            from: from,
            to: position,
            direction: point
        )
    }
    
    func move(
        vector: VectorProtocol,
        to location: CGPoint,
        previousLocation: CGPoint
    ) {
        let deltaX = location.x - previousLocation.x
        let deltaY = location.y - previousLocation.y
        
        let from = CGPoint(
            x: vector.startPoint.position.x + deltaX,
            y: vector.startPoint.position.y + deltaY
        )
        
        let to = CGPoint(
            x: vector.endPoint.position.x + deltaX,
            y: vector.endPoint.position.y + deltaY
        )
        
        vector.redraw(from: from, to: to, direction: .node)
    }
}
