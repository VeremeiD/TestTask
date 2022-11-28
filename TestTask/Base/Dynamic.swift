//
//  Dynamic.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 27.11.22.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
