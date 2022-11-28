//
//  CanvasManager.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 27.11.22.
//

import Foundation
import UIKit

final class CanvasManager: CanvasManagerProtocol {    
    static let shared = CanvasManager()
    var storageService: StorageServiceProtocol?
    var vectorDeleted: Dynamic<String> = Dynamic("")
    var vectorSelected: Dynamic<String> = Dynamic("")
    var vectorAdded: Dynamic<VectorModel> = Dynamic(VectorModel.empty())
    var freeVectorIndex: Int = 0
    
    private init() {
        storageService = StorageService.shared
    }
    
    func start() { }
    
    func selectVector(with identifier: String) {
        vectorSelected.value = identifier
    }
    
    func addNew(vector: VectorModel, completion: @escaping (Bool) -> Void) {
        storageService!.createEntity(from: vector) { [unowned self] flag in
            self.vectorAdded.value = vector
            self.freeVectorIndex += 1
            completion(flag)
        }
    }
    
    func getModels(completion: @escaping ([VectorModel]) -> Void) {
        storageService?.readEntities(completion: { [unowned self] entities in
            let models: [VectorModel] = entities.compactMap { entity in
                guard let identifier = entity.identifier else { return nil }
                let startPoint = CGPoint(x: entity.start_point_x, y: entity.start_point_y)
                let endPoint = CGPoint(x: entity.end_point_x, y: entity.end_point_y)
                return VectorModel(
                    identifier: identifier,
                    startPoint: startPoint,
                    endPoint: endPoint,
                    vectorColor: UIColor(hex: entity.color_hex) ?? UIColor.random,
                    length: entity.length
                )
            }
            self.freeVectorIndex = entities.count
            completion(models)
        })
    }
    
    func update(vector: VectorModel, completion: @escaping (Bool) -> Void) {
        storageService!.updateEntity(from: vector) { flag in
            completion(flag)
        }
    }
    
    func deleteVector(with identifier: String, completion: @escaping (Bool) -> Void) {
        storageService!.deleteEntity(with: identifier) { [unowned self] flag in
            self.vectorDeleted.value = identifier
            completion(flag)
        }
    }
}
