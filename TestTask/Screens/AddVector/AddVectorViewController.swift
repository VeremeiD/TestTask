//
//  AddVectorViewController.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import UIKit

final class AddVectorViewController: BaseViewController<AddVectorViewModel> {
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 14.0
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("addVector.title", comment: "")
        label.textAlignment = .center
        
        return label
    }()
    
    private let descriptionStartXLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("addVector.description.start.x", comment: "")
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    private let descriptionStartYLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("addVector.description.start.y", comment: "")
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    private let descriptionEndXLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("addVector.description.end.x", comment: "")
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    private let descriptionEndYLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("addVector.description.end.y", comment: "")
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    private let startXInput: UITextField = {
        let field = UITextField()
        field.placeholder = NSLocalizedString("addVector.placeholder", comment: "")
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.overrideUserInterfaceStyle = .light
        
        return field
    }()
    
    private let startYInput: UITextField = {
        let field = UITextField()
        field.placeholder = NSLocalizedString("addVector.placeholder", comment: "")
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.overrideUserInterfaceStyle = .light
        
        return field
    }()
    
    private let endXInput: UITextField = {
        let field = UITextField()
        field.placeholder = NSLocalizedString("addVector.placeholder", comment: "")
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.overrideUserInterfaceStyle = .light
        
        return field
    }()
    
    private let endYInput: UITextField = {
        let field = UITextField()
        field.placeholder = NSLocalizedString("addVector.placeholder", comment: "")
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.overrideUserInterfaceStyle = .light
        
        return field
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        let localizedTitle = NSLocalizedString("button.add", comment: "")
        button.setTitle(localizedTitle, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let localizedTitle = NSLocalizedString("button.close", comment: "")
        button.setTitle(localizedTitle, for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .clear
        
        return button
    }()
    
    override func setupSubviews() {
        view.backgroundColor = .clear
        
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionStartXLabel)
        contentView.addSubview(startXInput)
        contentView.addSubview(descriptionStartYLabel)
        contentView.addSubview(startYInput)
        contentView.addSubview(descriptionEndXLabel)
        contentView.addSubview(endXInput)
        contentView.addSubview(descriptionEndYLabel)
        contentView.addSubview(endYInput)
        contentView.addSubview(addButton)
        contentView.addSubview(closeButton)
    }
    
    override func setupLayout() {
        contentView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(startXInput.snp.top).inset(-50.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10.0)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalToSuperview().inset(20.0)
            make.height.equalTo(44.0)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().inset(20.0)
            make.height.equalTo(44.0)
        }
        
        endYInput.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10.0)
            make.right.equalToSuperview().inset(20.0)
            make.left.equalTo(contentView.snp.centerX)
        }
        
        descriptionEndYLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20.0)
            make.centerY.equalTo(endYInput)
        }
        
        endXInput.snp.makeConstraints { make in
            make.bottom.equalTo(endYInput.snp.top).inset(-10.0)
            make.right.equalToSuperview().inset(20.0)
            make.left.equalTo(contentView.snp.centerX)
        }
        
        descriptionEndXLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20.0)
            make.centerY.equalTo(endXInput)
        }
        
        startYInput.snp.makeConstraints { make in
            make.bottom.equalTo(endXInput.snp.top).inset(-10.0)
            make.right.equalToSuperview().inset(20.0)
            make.left.equalTo(contentView.snp.centerX)
        }
        
        descriptionStartYLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20.0)
            make.centerY.equalTo(startYInput)
        }
        
        startXInput.snp.makeConstraints { make in
            make.bottom.equalTo(startYInput.snp.top).inset(-10.0)
            make.right.equalToSuperview().inset(20.0)
            make.left.equalTo(contentView.snp.centerX)
        }
        
        descriptionStartXLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20.0)
            make.centerY.equalTo(startXInput)
        }
    }
    
    override func setupHandlers() {
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        self.hideKeyboardWhenTapped()
    }
    
    @objc func addTapped() {
        viewModel.addVectorTapped(
            fromX: startXInput.text,
            fromY: startYInput.text,
            toX: endXInput.text,
            toY: endYInput.text
        )
    }
    
    @objc func closeTapped() {
        viewModel.closeTapped()
    }
}
