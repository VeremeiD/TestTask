//
//  BaseViewController.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import SnapKit
import UIKit

open class BaseController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
        
        setupSubviews()
        setupLayout()
        setupHandlers()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupSubviews() { }
    open func setupLayout() { }
    open func setupHandlers() { }
}

open class BaseViewController<T>: BaseController where T: ViewModel {
    public private(set) var viewModel: T!
    
    public init(with model: T) {
        viewModel = model
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
