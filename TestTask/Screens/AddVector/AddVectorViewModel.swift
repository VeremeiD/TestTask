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
    
    func addVectorTapped(
        fromX: String?,
        fromY: String?,
        toX: String?,
        toY: String?
    ) {
        guard let fromX = Double(fromX ?? ""),
              let fromY = Double(fromY ?? ""),
              let toX = Double(toX ?? ""),
              let toY = Double(toY ?? "")
        else {
            coordinator?.showCheckInputAlert()
            return
        }
        
        let start = CGPoint(x: fromX, y: fromY)
        let end = CGPoint(x: toX, y: toY)
        
        let vector = VectorModel(
            identifier: "Vector #\(canvasManager.freeVectorIndex)",
            startPoint: start,
            endPoint: end,
            vectorColor: UIColor.random,
            length: start.distance(to: end)
        )
        
        canvasManager.addNew(vector: vector) { [weak self] success in
            guard let self else { return }
            
            if success {
                self.coordinator?.openMainScreen()
            } else {
                self.coordinator?.showErrorAlert()
            }
        }
    }
    
    func closeTapped() {
        coordinator?.openMainScreen()
    }
}
