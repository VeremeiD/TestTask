//
//  VectorConnectionOption.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation

enum VectorConnectionOption: Equatable {
    case aa(point: CGPoint)
    case bb(point: CGPoint)
    case ab(point: CGPoint)
    case ba(point: CGPoint)
    case noIntersection
    
    var intersectionPoint: CGPoint? {
        switch self {
        case .aa(let point), .bb(let point), .ab(let point), .ba(let point):
            return point
        case .noIntersection:
            return nil
        }
    }
}
