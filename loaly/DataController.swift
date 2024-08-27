//
//  DataController.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 7/17/24.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "loaly")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
