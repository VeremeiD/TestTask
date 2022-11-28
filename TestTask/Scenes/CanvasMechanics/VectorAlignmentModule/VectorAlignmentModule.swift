//
//  VectorAlignmentManager.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation

final class VectorAlignmentModule: VectorAlignment {
    func manageStickingByDistance(staticPoint: CGPoint, movingPoint: CGPoint) -> CGPoint {
        let angleBetweenPoints = staticPoint.angle(to: movingPoint)
        
        switch true {
        case horizontalPositionFor(angleBetweenPoints, withSpread: 5.0):
            return CGPoint(
                x: movingPoint.x,
                y: staticPoint.y
            )
        case verticalPositionFor(angleBetweenPoints, withSpread: 5.0):
            return CGPoint(
                x: staticPoint.x,
                y: movingPoint.y
            )
        default:
            return movingPoint
        }
    }
    
    func manageStickingByAngle(freePoint: CGPoint, midpoint: CGPoint, movingPoint: CGPoint) -> CGPoint? {
        let first = midpoint.angle(to: freePoint)
        let second = midpoint.angle(to: movingPoint)
        let result = (second - first).rounded()
        print(result)
        if verticalPositionFor(result, withSpread: 5.0) {
            print("true")
            return CGPoint.zero
        } else {
            return nil
        }
    }
    
    private func horizontalPositionFor(_ angle: Float, withSpread delta: Float) -> Bool {
        let firstCheck = ((360 - delta)...360).contains(angle)
        let secondCheck = (0...delta).contains(angle)
        let thirdCheck = ((180 - delta)...(180 + delta)).contains(angle)
        
        return firstCheck || secondCheck || thirdCheck
    }
    
    private func verticalPositionFor(_ angle: Float, withSpread delta: Float) -> Bool {
        let firstCheck = ((90 - delta)...(90 + delta)).contains(angle)
        let secondCheck = ((270 - delta)...(270 + delta)).contains(angle)
        
        return firstCheck || secondCheck
    }
}
