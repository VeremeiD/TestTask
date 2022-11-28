//
//  AddVectorViewModel.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import UIKit

final class AddVectorViewModel: AddVectorViewModelProtocol {
    private(set) weak var coordinator: AppCoordinatorProtocol?
    private var canvasManager: CanvasManagerProtocol
    
    init(coordinator: AppCoordinatorProtocol, manager: CanvasManagerProtocol) {
        canvasManager = manager
        self.coordinator = coordinator
    }
    
    func addVectorTapped(from: CGPoint, to: CGPoint) {
        let vector = VectorModel(
            identifier: "Vector #\(canvasManager.freeVectorIndex)",
            startPoint: from,
            endPoint: to,
            vectorColor: UIColor.random,
            length: from.distance(to: to)
        )
        
        canvasManager.addNew(vector: vector) { [weak self] flag in
            guard let self else { return }
            self.coordinator?.openMainScreen()
            
            guard !flag else { return }
            self.coordinator?.showErrorAlert()
        }
    }
    
    func closeTapped() {
        coordinator?.openMainScreen()
    }
    
    func inputError() {
        coordinator?.showCheckInputAlert()
    }
}
