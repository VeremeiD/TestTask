//
//  AppCoordinatorProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 28.11.22.
//

import Foundation

public protocol AppCoordinatorProtocol: AnyObject {
    var rootController: BaseController? { get }
    
    func start()
    func openMainScreen()
    func openSideMenu()
    func openAddVectorScreen()
    func showErrorAlert()
    func showCheckInputAlert()
}
