//
//  VectorModel.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import UIKit

struct VectorModel {
    let identifier: String
    let startPoint: CGPoint
    let endPoint: CGPoint
    let vectorColor: UIColor
    let length: Float
    
    static func empty() -> VectorModel {
        VectorModel(
            identifier: "",
            startPoint: CGPoint.zero,
            endPoint: CGPoint.zero,
            vectorColor: UIColor.red,
            length: 0
        )
    }
}
