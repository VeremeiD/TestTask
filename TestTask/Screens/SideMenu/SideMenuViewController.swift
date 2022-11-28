//
//  SideMenuViewController.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import UIKit

final class SideMenuViewController: BaseViewController<SideMenuViewModel> {
    private var models: [VectorModel] = []
    private var menuSize = UIScreen.main.bounds.width / 3.0
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Vectors:"
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let vectorsTable: UITableView = {
        let table = UITableView()
        table.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "defaultCell"
        )
        table.backgroundColor = .white
        
        return table
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 14.0
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.red.cgColor
        
        return button
    }()
    
    override init(with model: SideMenuViewModel) {
        super.init(with: model)
        view.backgroundColor = .clear
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vectorsTable.dataSource = self
        vectorsTable.delegate = self
        
        viewModel.loadModels { [weak self] models in
            guard let self else { return }
            self.models = models
            
            DispatchQueue.main.async {
                self.vectorsTable.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseIn) {
                self.backgroundView.snp.updateConstraints { make in
                    make.left.equalToSuperview()
                }
                self.view.layoutIfNeeded()
            }
    }
    
    override func setupSubviews() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(vectorsTable)
        backgroundView.addSubview(closeButton)
    }
    
    override func setupLayout() {
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(44.0)
            make.left.right.equalToSuperview().inset(5.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(5.0)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(-menuSize)
            make.width.equalTo(menuSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10.0)
            make.left.right.equalToSuperview().inset(10.0)
        }
        
        vectorsTable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(closeButton.snp.top).inset(10.0)
        }
        
    }
    
    override func setupHandlers() {
        closeButton.addTarget(self, action: #selector(closeMenu), for: .touchUpInside)
    }
    
    @objc func closeMenu(sender: UITapGestureRecognizer) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseOut) {
                self.backgroundView.snp.updateConstraints { make in
                    make.left.equalToSuperview().inset(-self.menuSize)
                }
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.viewModel.closeTapped()
            }
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return models.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell")!
        var content = cell.defaultContentConfiguration()
        let model = models[indexPath.row]
        
        let startPoint = "From(\(Int(model.startPoint.x)), \(Int(model.startPoint.y)))"
        let endPoint = "\nTo (\(Int(model.endPoint.x)), \(Int(model.endPoint.y)))"
        let length = "\nLength: \(Int(model.length))"
        
        content.text = model.identifier
        content.secondaryText = "\(startPoint)\(endPoint)\(length)"
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let identifier = models[indexPath.row].identifier
        viewModel.selectedCell(with: identifier)
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            let model = models.remove(at: indexPath.row)
            viewModel.pressedDeleteForCell(with: model.identifier)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
