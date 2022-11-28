//
//  VectorIntersectionsProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation

protocol VectorIntersection {
    func checkIntersectionBetween(
        staticVectorStart startPoint: CGPoint,
        staticVectorEnd endPoint: CGPoint,
        touchLocation: CGPoint,
        selectedPoint: VectorPointOption
    ) -> VectorConnectionOption
}
