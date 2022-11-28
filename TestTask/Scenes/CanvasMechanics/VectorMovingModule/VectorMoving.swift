//
//  VectorMovingProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation

protocol VectorMoving {
    func move(
        vector: VectorProtocol,
        withSelected point: VectorPointOption,
        to position: CGPoint
    )

    func move(
        vector: VectorProtocol,
        to location: CGPoint,
        previousLocation: CGPoint
    )
}
