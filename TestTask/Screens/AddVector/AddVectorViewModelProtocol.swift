//
//  AddvectorViewModelProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 27.11.22.
//

import Foundation

protocol AddVectorViewModelProtocol: ViewModel {
    func addVectorTapped(from: CGPoint, to: CGPoint)
    func closeTapped()
    func inputError()
}
