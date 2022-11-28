//
//  CGPoint+Extensions.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 22.11.22.
//

import UIKit

extension CGPoint {
    func angle(to second: CGPoint) -> Float {
        let originX = second.x - x
        let originY = second.y - y
        let radians = atan2f(Float(originY), Float(originX))
        var degrees = radians * 180.0 / Float.pi

        while degrees < 0 {
            degrees += 360
        }

        return degrees
    }
    
    func distance(to second: CGPoint) -> Float {
        hypotf(
            Float(x - second.x),
            Float(y - second.y)
        )
    }
}
