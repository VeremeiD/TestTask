//
//  StorageServiceProtocol.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 27.11.22.
//

import Foundation

protocol StorageServiceProtocol {
    func createEntity(from model: VectorModel, completion: @escaping (Bool) -> Void)
    func readEntities(completion: @escaping ([VectorEntity]) -> Void)
    func updateEntity(from model: VectorModel, completion: @escaping (Bool) -> Void)
    func deleteEntity(with identifier: String, completion: @escaping (Bool) -> Void)
}
