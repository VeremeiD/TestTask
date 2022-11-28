//
//  StorageService.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import Foundation
import CoreData
import UIKit

final class StorageService: StorageServiceProtocol {
    static let shared = StorageService()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StorageModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var models: [VectorModel] = []
    
    private init() { }
    
    func start() { }
    
    func createEntity(from model: VectorModel, completion: @escaping (Bool) -> Void) {
        persistentContainer.performBackgroundTask { context in
            guard let entity = NSEntityDescription.insertNewObject(
                forEntityName: "VectorEntity",
                into: context
            ) as? VectorEntity
            else {
                completion(false)
                return
            }
            
            entity.identifier = model.identifier
            entity.start_point_x = model.startPoint.x
            entity.start_point_y = model.startPoint.y
            entity.end_point_x = model.endPoint.x
            entity.end_point_y = model.endPoint.y
            entity.color_hex = model.vectorColor.hex
            entity.length = model.length
            
            do {
                try context.save()
            } catch {
                completion(false)
            }
            
            completion(true)
        }
    }
    
    func readEntities(completion: @escaping ([VectorEntity]) -> Void) {
        let fetchRequest: NSFetchRequest<VectorEntity> = VectorEntity.fetchRequest()
        let entities = try? persistentContainer.viewContext.fetch(fetchRequest)

        completion(entities ?? [])
    }
    
    func updateEntity(from model: VectorModel, completion: @escaping (Bool) -> Void) {
        persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<VectorEntity> = VectorEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "identifier LIKE %@", model.identifier)
            
            guard let entity = try? context.fetch(fetchRequest).first else {
                completion(false)
                return
            }

            entity.identifier = model.identifier
            entity.start_point_x = model.startPoint.x
            entity.start_point_y = model.startPoint.y
            entity.end_point_x = model.endPoint.x
            entity.end_point_y = model.endPoint.y
            entity.color_hex = model.vectorColor.hex
            entity.length = model.length
            
            do {
                try context.save()
            } catch {
                completion(false)
            }
            
            completion(true)
        }
    }
    
    func deleteEntity(with identifier: String, completion: @escaping (Bool) -> Void) {
        persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<VectorEntity> = VectorEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "identifier LIKE %@", identifier)
            
            do {
                guard let entity = try context.fetch(fetchRequest).first
                else {
                    completion(false)
                    return
                }
                context.delete(entity)
                try context.save()
            } catch {
                completion(false)
            }
            
            completion(true)
        }
    }
}
