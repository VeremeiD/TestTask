//
//  MainScreenViewController.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import SpriteKit

final class MainScreenViewController: BaseViewController<MainScreenViewModel> {
    private var models: [VectorModel] = []
    private var initialFrame: CGRect?

    private var mainScene: MainScene?
    private let mainSceneView = SKView()
    
    private let contentView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 8.0
        
        return view
    }()
    
    private let vectorsTable: UITableView = {
        let table = UITableView()
        table.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "defaultCell"
        )
        table.backgroundColor = .white
        table.overrideUserInterfaceStyle = .light
        
        return table
    }()
    
    private let addVectorButton: UIButton = {
        let button = UIButton()
        let localizedTitle = NSLocalizedString("button.add", comment: "")
        button.setTitle(localizedTitle, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 14.0
        
        return button
    }()
    
    private let vectorListButton: UIButton = {
        let button = UIButton()
        let localizedTitle = NSLocalizedString("button.list", comment: "")
        button.setTitle(localizedTitle, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 14.0
        
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let localizedTitle = NSLocalizedString("button.close", comment: "")
        button.setTitle(localizedTitle, for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 14.0
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.red.cgColor
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = MainScene(size: view.bounds.size)
        mainScene = scene
        scene.scaleMode = .aspectFill
        mainSceneView.ignoresSiblingOrder = true
        mainSceneView.presentScene(mainScene)
        initialFrame = contentView.frame
        vectorsTable.dataSource = self
        vectorsTable.delegate = self
    }
    
    override func setupSubviews() {
        view.addSubview(closeButton)
        view.addSubview(vectorsTable)
        view.addSubview(contentView)
        contentView.addSubview(mainSceneView)
        contentView.addSubview(addVectorButton)
        contentView.addSubview(vectorListButton)
    }
    
    override func setupLayout() {
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
        mainSceneView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        vectorsTable.snp.makeConstraints { make in
            let topInset = (view.frame.height * 0.6) + 10.0
            make.bottom.equalTo(closeButton.snp.top).inset(-5.0)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(topInset)
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
        
        closeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10.0)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(44.0)
        }
    }
    
    override func setupHandlers() {
        addVectorButton.addTarget(self, action: #selector(addVectorTapped(_:)), for: .touchUpInside)
        vectorListButton.addTarget(self, action: #selector(vectorListTapped(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
    }
    
    @objc func addVectorTapped(_ sender: UIButton) {
        viewModel.addVectorTapped()
    }
    
    @objc func vectorListTapped(_ sender: UIButton) {
        viewModel.loadModels { [weak self] models in
            guard let self else { return }
            self.models = models
            
            DispatchQueue.main.async {
                self.vectorsTable.reloadData()
            }
        }

        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1.0,
            options: .curveEaseOut) {
                self.contentView.transform = CGAffineTransform(scaleX: 1.0, y: 0.6)
                self.contentView.frame.origin.y = 0
                self.addVectorButton.isHidden = true
                self.vectorListButton.isHidden = true
            }
    }
    
    @objc func closeTapped(_ sender: UIButton) {
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1.0,
            options: .curveEaseOut) {
                self.contentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.contentView.frame.origin.y = self.initialFrame?.origin.y ?? 0
                self.addVectorButton.isHidden = false
                self.vectorListButton.isHidden = false
            }
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
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
        let formatter = CellTextFormatter(
            startPoint: model.startPoint,
            endPoint: model.endPoint,
            length: model.length
        )
        
        content.text = model.identifier
        content.secondaryText = formatter.format()
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

