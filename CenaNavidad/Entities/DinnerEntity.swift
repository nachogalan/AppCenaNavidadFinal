//
//  DinnerEntity.swift
//  CenaNavidad
//
//  Created by IGNACIO GALAN DE PINA on 9/1/19.
//  Copyright © 2019 IGNACIO GALAN DE PINA. All rights reserved.
//

import Foundation
import RealmSwift

class DinnerEntity: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var place = ""
    @objc dynamic var date = Date()
    var guests:[Guest] = []
    
    
    override static func primaryKey() -> String { //Metodo para asignar una clave primaria
        return "name"
    }
    
    convenience init(dinner: Dinner) {
        self.init()
        
        self.name = dinner.name
       // self.place = dinner.place
        //self.date = dinner.date
       // self.guests.append(guests)
        
    }
    
    func dinnerModel() -> Dinner {
        let model = Dinner()
        
        model.name = self.name
        
        return model
    }
}
