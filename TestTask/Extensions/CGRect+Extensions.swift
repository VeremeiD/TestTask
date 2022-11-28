//
//  CGRect+Extensions.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 27.11.22.
//

import UIKit

extension CGRect {
    init(center: CGPoint, size: CGSize)
    {
        self.init(
            x: center.x - size.width / 2,
            y: center.y - size.height / 2,
            width: size.width,
            height: size.height
        )
    }
}
