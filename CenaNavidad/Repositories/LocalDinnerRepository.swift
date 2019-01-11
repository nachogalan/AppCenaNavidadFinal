//
//  LocalDinnerRepository.swift
//  CenaNavidad
//
//  Created by IGNACIO GALAN DE PINA on 10/1/19.
//  Copyright © 2019 IGNACIO GALAN DE PINA. All rights reserved.
//

import UIKit
import RealmSwift

class LocalDinnerRepository: Repository {
    
    func getAll() -> [Dinner] {
        var dinners: [Dinner] = []
        do {
            let entities = try Realm().objects(DinnerEntity.self).sorted(byKeyPath: "name", ascending: true) //Esto equivaldria a una Query
            for entity in entities {
                let model = entity.dinnerModel()
                dinners.append(model)
            }
        }
        catch let error as NSError {
            print("Error getAll Tasks: ", error.description)
        }
        return dinners
    }
    
    func get(identifier: String) -> Dinner? {
        do {
            let realm =  try Realm()
            if let entity = realm.objects(DinnerEntity.self).filter("name == %@", identifier).first{ //Esto equivaldria a una Query
                let model = entity.dinnerModel()
                return model
            }
        }
        catch {
            return nil
        }
        return nil
    }
    
    func create(a: Dinner) -> Bool {
        do {
            let realm = try Realm()
            let entity = DinnerEntity(dinner: a)
            try realm.write {
                realm.add(entity, update: true)
            }
        }
        catch {
            return false
        }
        
        return true
    }
    
    func update(a: Dinner) -> Bool {
        return create(a: a)
    }
    
    func delete(a: Dinner) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entityToDelete = realm.objects(DinnerEntity.self).filter("name == %@", a.name) //Esto equivaldria a una Query
                realm.delete(entityToDelete)
            }
            
        }
        catch {
            return false
        }
        return true
    }
}
