//
//  SideMenuViewModel.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation

final class SideMenuViewModel: SideMenuViewModelProtocol {
    private(set) weak var coordinator: AppCoordinatorProtocol?
    private let canvasManager: CanvasManagerProtocol
    
    init(coordinator: AppCoordinatorProtocol, manager: CanvasManagerProtocol) {
        canvasManager = manager
        self.coordinator = coordinator
    }

    func selectedCell(with identifier: String) {
        canvasManager.selectVector(with: identifier)
    }
    
    func pressedDeleteForCell(with identifier: String) {
        canvasManager.deleteVector(with: identifier) { [weak self] flag in
            guard let self,
                  !flag else { return }
            self.coordinator?.showErrorAlert()
        }
    }
    
    func loadModels(completion: @escaping ([VectorModel]) -> Void) {
        self.canvasManager.getModels { models in
            completion(models)
        }
    }
    
    func closeTapped() {
        coordinator?.openMainScreen()
    }
}
