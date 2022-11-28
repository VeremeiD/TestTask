//
//  AddVectorViewController.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import UIKit

final class AddVectorViewController: BaseViewController<AddVectorViewModel> {
    private let descriptionStartLabel: UILabel = {
        let label = UILabel()
        label.text = "Start point"
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let descriptionEndLabel: UILabel = {
        let label = UILabel()
        label.text = "End point"
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let startXInput: UITextField = {
        let field = UITextField()
        field.placeholder = "X"
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.overrideUserInterfaceStyle = .light
        
        return field
    }()
    
    private let startYInput: UITextField = {
        let field = UITextField()
        field.placeholder = "Y"
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.overrideUserInterfaceStyle = .light
        
        return field
    }()
    
    private let endXInput: UITextField = {
        let field = UITextField()
        field.placeholder = "X"
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.overrideUserInterfaceStyle = .light
        
        return field
    }()
    
    private let endYInput: UITextField = {
        let field = UITextField()
        field.placeholder = "Y"
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.overrideUserInterfaceStyle = .light
        
        return field
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14.0
        
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 14.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.red.cgColor
        
        return button
    }()
    
    override func setupSubviews() {
        view.addSubview(descriptionStartLabel)
        view.addSubview(startXInput)
        view.addSubview(startYInput)
        view.addSubview(descriptionEndLabel)
        view.addSubview(endXInput)
        view.addSubview(endYInput)
        view.addSubview(addButton)
        view.addSubview(closeButton)
    }
    
    override func setupLayout() {
        closeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(5.0)
            make.left.right.equalToSuperview().inset(10.0)
            make.height.equalTo(44.0)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(closeButton.snp.top).inset(-10.0)
            make.left.right.equalToSuperview().inset(10.0)
            make.height.equalTo(44.0)
        }
        
        descriptionStartLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20.0)
            make.left.right.equalToSuperview().inset(10.0)
        }
        
        startXInput.snp.makeConstraints { make in
            make.top.equalTo(descriptionStartLabel.snp.bottom).inset(-10.0)
            make.left.equalToSuperview().inset(10.0)
            make.right.equalTo(view.snp.centerX)
        }
        
        startYInput.snp.makeConstraints { make in
            make.top.equalTo(descriptionStartLabel.snp.bottom).inset(-10.0)
            make.right.equalToSuperview().inset(10.0)
            make.left.equalTo(view.snp.centerX)
        }
        
        descriptionEndLabel.snp.makeConstraints { make in
            make.top.equalTo(startXInput.snp.bottom).inset(-20.0)
            make.left.right.equalToSuperview().inset(10.0)
        }
        
        endXInput.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10.0)
            make.right.equalTo(view.snp.centerX).inset(5.0)
            make.top.equalTo(descriptionEndLabel.snp.bottom).inset(-10.0)
        }
        
        endYInput.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10.0)
            make.left.equalTo(view.snp.centerX).inset(5.0)
            make.top.equalTo(descriptionEndLabel.snp.bottom).inset(-10.0)
        }
    }
    
    override func setupHandlers() {
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        self.hideKeyboardWhenTapped()
    }
    
    @objc func addTapped() {
        if let startX = Double(startXInput.text ?? ""),
           let startY = Double(startYInput.text ?? ""),
           let endX = Double(endXInput.text ?? ""),
           let endY = Double(endYInput.text ?? "") {
            viewModel.addVectorTapped(
                from: CGPoint(x: startX, y: startY),
                to: CGPoint(x: endX, y: endY)
            )
        } else {
            viewModel.inputError()
        }
    }
    
    @objc func closeTapped() {
        viewModel.closeTapped()
    }
}
