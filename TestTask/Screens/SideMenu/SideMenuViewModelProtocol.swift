//
//  SideMenuViewModelProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 27.11.22.
//

import Foundation

protocol SideMenuViewModelProtocol: ViewModel {
    func selectedCell(with identifier: String)
    func pressedDeleteForCell(with identifier: String)
    func loadModels(completion: @escaping ([VectorModel]) -> Void)
    func closeTapped()
}
