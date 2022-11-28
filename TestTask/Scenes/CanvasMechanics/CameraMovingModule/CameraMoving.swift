//
//  CameraMovingProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation
import SpriteKit

protocol CameraMoving {
    func moveCameraFrom(location: CGPoint, toLocation: CGPoint, previousLocation: CGPoint) -> CGPoint
}
