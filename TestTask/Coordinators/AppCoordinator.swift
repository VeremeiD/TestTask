//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import UIKit

final class AppCoordinator: AppCoordinatorProtocol {
    var rootController: BaseController?
    
    init() { }
    
    func start() {
        lazy var viewModel = MainScreenViewModel(coordinator: self)
        let controller = MainScreenViewController(with: viewModel)
        self.rootController = controller
    }
    
    func openMainScreen() {
        DispatchQueue.main.async {
            self.rootController?.dismiss(animated: true)
        }
    }
    
    func openSideMenu() {
        let viewModel = SideMenuViewModel(
            coordinator: self,
            manager: CanvasManager.shared
        )
        let controller = SideMenuViewController(with: viewModel)
        controller.modalPresentationStyle = .overCurrentContext
        
        DispatchQueue.main.async {
            self.rootController?.present(controller, animated: true)
        }
    }
    
    func openAddVectorScreen() {
        let viewModel = AddVectorViewModel(
            coordinator: self,
            manager: CanvasManager.shared
        )
        let controller = AddVectorViewController(with: viewModel)
        controller.modalPresentationStyle = .overCurrentContext
        
        DispatchQueue.main.async {
            self.rootController?.present(controller, animated: true)
        }
    }
    
    func showErrorAlert() {
        openMainScreen()
        let dialogMessage = UIAlertController(
            title: "Error occurred",
            message: "Please try again later",
            preferredStyle: .alert
        )

        let button = UIAlertAction(
            title: "OK",
            style: .default
        )

        dialogMessage.addAction(button)

        DispatchQueue.main.async {
            self.rootController?.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    func showCheckInputAlert() {
        openMainScreen()
        let dialogMessage = UIAlertController(
            title: "Invalid input",
            message: "Please check the entered data",
            preferredStyle: .alert
        )

        let button = UIAlertAction(
            title: "OK",
            style: .default
        )

        dialogMessage.addAction(button)

        DispatchQueue.main.async {
            self.rootController!.present(dialogMessage, animated: true, completion: nil)
        }
    }
}
