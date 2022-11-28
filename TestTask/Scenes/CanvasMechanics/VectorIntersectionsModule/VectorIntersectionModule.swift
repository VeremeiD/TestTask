//
//  VectorIntersectionManager.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation
import UIKit

final class VectorIntersectionModule: VectorIntersection {
    func checkIntersectionBetween(
        staticVectorStart startPoint: CGPoint,
        staticVectorEnd endPoint: CGPoint,
        touchLocation: CGPoint,
        selectedPoint: VectorPointOption
    ) -> VectorConnectionOption {
        let startPointArea = CGRect(center: startPoint, size: CGSize(width: 44.0, height: 44.0))
        let endPointArea = CGRect(center: endPoint, size: CGSize(width: 44.0, height: 44.0))
        
        guard !startPointArea.intersects(endPointArea) else { return .noIntersection }

        switch selectedPoint {
        case .start:
            if startPointArea.contains(touchLocation) {
                return .aa(point: startPoint)
            }
            if endPointArea.contains(touchLocation) {
                return .ba(point: endPoint)
            }
            return .noIntersection
        case .end:
            if startPointArea.contains(touchLocation) {
                return .ab(point: startPoint)
            }
            if endPointArea.contains(touchLocation) {
                return .bb(point: endPoint)
            }
            return .noIntersection
        default:
            return .noIntersection
        }
    }
}
