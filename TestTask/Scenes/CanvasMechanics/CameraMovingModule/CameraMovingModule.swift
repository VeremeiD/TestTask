//
//  CameraMovingModule.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation

final class CameraMovingModule: CameraMoving {
    func moveCameraFrom(location: CGPoint, toLocation: CGPoint, previousLocation: CGPoint) -> CGPoint {
        let deltaX = toLocation.x - previousLocation.x
        let deltaY = toLocation.y - previousLocation.y
        
        return CGPoint(
            x: location.x - deltaX,
            y: location.y - deltaY
        )
    }
}
