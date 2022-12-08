//
//  MainScreenViewController.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import SpriteKit

final class MainScreenViewController: BaseViewController<MainScreenViewModel> {
    private var mainScene: MainScene?
    private let mainSceneView = SKView()
    
    private let addVectorButton: UIButton = {
        let button = UIButton()
        let localizedTitle = NSLocalizedString("button.add", comment: "")
        button.setTitle(localizedTitle, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 14.0
        
        return button
    }()
    
    private let vectorListButton: UIButton = {
        let button = UIButton()
        let localizedTitle = NSLocalizedString("button.list", comment: "")
        button.setTitle(localizedTitle, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 14.0
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScene = MainScene(size: view.bounds.size)
        mainSceneView.ignoresSiblingOrder = true
        mainSceneView.presentScene(mainScene)
    }
    
    override func setupSubviews() {
        view.addSubview(mainSceneView)
        view.addSubview(addVectorButton)
        view.addSubview(vectorListButton)
    }
    
    override func setupLayout() {
        mainSceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addVectorButton.snp.makeConstraints { make in
            make.width.equalTo(120.0)
            make.height.equalTo(44.0)
            make.right.equalToSuperview().inset(10.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(5.0)
        }
        
        vectorListButton.snp.makeConstraints { make in
            make.width.equalTo(120.0)
            make.height.equalTo(44.0)
            make.left.equalToSuperview().inset(10.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(5.0)
        }
    }
    
    override func setupHandlers() {
        addVectorButton.addTarget(self, action: #selector(addVectorTapped(_:)), for: .touchUpInside)
        vectorListButton.addTarget(self, action: #selector(vectorListTapped(_:)), for: .touchUpInside)
    }
    
    @objc func addVectorTapped(_ sender: UIButton) {
        viewModel.addVectorTapped()
    }
    
    @objc func vectorListTapped(_ sender: UIButton) {
        viewModel.openMenuTapped()
    }
}
