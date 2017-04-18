//
//  DataManager.swift
//  tagup
//
//  Created by Edward on 4/13/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    func fetchAllTags(completion: @escaping ([TagCellViewModel]) -> ()){
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = delegate.persistentContainer.viewContext
        
        var tagViewModels: [TagCellViewModel] = []
        
        
        do {
            // Fetch all tags from the databse
            let tags = try context.fetch(Tag.fetchRequest())
            for tag in tags {
                let viewModel = TagCellViewModel(tag as! Tag)
                tagViewModels.append(viewModel)
            }
        } catch {
            print("Fetching ImageTags Failed")
        }
        
        completion(tagViewModels)
    }
    
    func saveTag(_ tag: Tag) {
        // usually this method should be called to handle saving of data between servers
    }
    
    func deleteTag(_ tag: Tag) {
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = delegate.persistentContainer.viewContext
        
        context.delete(tag)
        delegate.saveContext()
    }
}






