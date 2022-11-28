//
//  VectorAlignmentProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation
import UIKit

protocol VectorAlignment {
    func manageStickingByDistance(staticPoint: CGPoint, movingPoint: CGPoint) -> CGPoint
    func manageStickingByAngle(freePoint: CGPoint, midpoint: CGPoint, movingPoint: CGPoint) -> CGPoint?
}
