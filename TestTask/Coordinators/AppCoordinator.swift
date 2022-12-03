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
            title: NSLocalizedString("alert.error.title", comment: ""),
            message: NSLocalizedString("alert.error.message", comment: ""),
            preferredStyle: .alert
        )

        let button = UIAlertAction(
            title: NSLocalizedString("alert.button.ok", comment: "").uppercased(),
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
            title: NSLocalizedString("alert.check_input.title", comment: ""),
            message: NSLocalizedString("alert.check_input.message", comment: ""),
            preferredStyle: .alert
        )

        let button = UIAlertAction(
            title: NSLocalizedString("alert.button.ok", comment: "").uppercased(),
            style: .default
        )

        dialogMessage.addAction(button)

        DispatchQueue.main.async {
            self.rootController!.present(dialogMessage, animated: true, completion: nil)
        }
    }
}
