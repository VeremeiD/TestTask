//
//  ViewModel.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation

public protocol ViewModel: AnyObject {
    var coordinator: AppCoordinatorProtocol? { get }
}
