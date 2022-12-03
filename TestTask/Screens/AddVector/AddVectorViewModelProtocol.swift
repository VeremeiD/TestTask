//
//  AddvectorViewModelProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 27.11.22.
//

import Foundation

protocol AddVectorViewModelProtocol: ViewModel {
    func addVectorTapped(fromX: String?, fromY: String?, toX: String?, toY: String?)
    func closeTapped()
}
