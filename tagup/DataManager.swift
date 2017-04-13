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
        
        var tags: [TagCellViewModel] = []
        do {
            let imageTags = try context.fetch(ImageTag.fetchRequest())
            for tag in imageTags {
                let viewModel = TagCellViewModel(tag as! Tag)
                tags.append(viewModel)
            }
        } catch {
            print("Fetching ImageTags Failed")
        }
        
        completion(tags)
    }
}
