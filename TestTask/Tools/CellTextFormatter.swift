//
//  CellTextFormatter.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 4.12.22.
//

import Foundation

struct CellTextFormatter: CellFormatterProtocol {
    private let localizedFrom = NSLocalizedString("sideMenu.cell.from", comment: "")
    private let localizedTo = NSLocalizedString("sideMenu.cell.to", comment: "")
    private let localizedLength = NSLocalizedString("sideMenu.cell.length", comment: "")
    
    let startPoint: CGPoint
    let endPoint: CGPoint
    let length: Float
    
    func format() -> String {
        let formattedFrom = "(\(Int(startPoint.x)), \(Int(startPoint.y)))"
        let formattedTo = "(\(Int(endPoint.x)), \(Int(endPoint.y)))"
        let formattedLength = "\(Int(length))"
        
        return "\(localizedFrom)\(formattedFrom)\n\(localizedTo)\(formattedTo)\n\(localizedLength) \(formattedLength)"
    }
}
