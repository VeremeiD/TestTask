//
//  CanvasManagerProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 27.11.22.
//

import Foundation

protocol CanvasManagerProtocol {
    var storageService: StorageServiceProtocol? { get }
    
    var vectorDeleted: Dynamic<String> { get }
    var vectorSelected: Dynamic<String> { get }
    var vectorAdded: Dynamic<VectorModel> { get }
    var freeVectorIndex: Int { get }
    
    func addNew(vector: VectorModel, completion: @escaping (Bool) -> Void)
    func getModels(completion: @escaping ([VectorModel]) -> Void)
    func update(vector: VectorModel, completion: @escaping (Bool) -> Void)
    func deleteVector(with identifier: String, completion: @escaping (Bool) -> Void)
    func selectVector(with identifier: String)
}
