//
//  MainScreenViewModel.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation

final class MainScreenViewModel: MainScreenViewModelProtocol {
    private(set) weak var coordinator: AppCoordinatorProtocol?
    
    init(coordinator: AppCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func addVectorTapped() {
        coordinator?.openAddVectorScreen()
    }
    
    func openMenuTapped() {
        coordinator?.openSideMenu()
    }
}
