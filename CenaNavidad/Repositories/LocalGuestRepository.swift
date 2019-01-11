//
//  LocalGuestRepository.swift
//  CenaNavidad
//
//  Created by IGNACIO GALAN DE PINA on 10/1/19.
//  Copyright © 2019 IGNACIO GALAN DE PINA. All rights reserved.
//

import UIKit
import RealmSwift

class LocalGuestRepository: Repository {
    
    func getAll() -> [Guest] {
        var guests: [Guest] = []
        do {
            let entities = try Realm().objects(GuestEntity.self).sorted(byKeyPath: "date", ascending: false) //Esto equivaldria a una Query
            for entity in entities {
                let model = entity.guestModel()
                guests.append(model)
            }
        }
        catch let error as NSError {
            print("Error getAll Tasks: ", error.description)
        }
        return guests
    }
    
    
    
    func get(identifier: String) -> Guest? {
        do {
            let realm =  try Realm()
            if let entity = realm.objects(GuestEntity.self).filter("name == %@", identifier).first{ //Esto equivaldria a una Query
                let model = entity.guestModel()
                return model
            }
        }
        catch {
            return nil
        }
        return nil
    }
    
    
    
    func create(a: Guest) -> Bool {
        do {
            let realm = try Realm()
            let entity = GuestEntity(guest: a)
            try realm.write {
                realm.add(entity, update: true)
            }
        }
        catch {
            return false
        }
        
        return true
    }
    
    func update(a: Guest) -> Bool {
        return create(a: a)
    }
    
    func delete(a: Guest) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entityToDelete = realm.objects(GuestEntity.self).filter("name == %@", a.name) //Esto equivaldria a una Query
                realm.delete(entityToDelete)
            }
            
        }
        catch {
            return false
        }
        return true
    }
}

