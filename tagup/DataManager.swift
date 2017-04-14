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
    
    func saveImageTag(_ title: String?,_ image: UIImage?,_ notes: String?) {
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = delegate.persistentContainer.viewContext
        let imageTag = ImageTag(context: context)
        
        // Initalize properties of ImageTag
        imageTag.title = title
        imageTag.notes = notes
        
        if image != #imageLiteral(resourceName: "upload_image_icon") {
            // Image has been uploaded
            imageTag.image = UIImagePNGRepresentation(image!)! as NSData
        } else {
            imageTag.image = nil
        }
        
        delegate.saveContext()
    }
    
    func deleteImageTag(_ imageTag: ImageTag) {
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = delegate.persistentContainer.viewContext
        
        context.delete(imageTag)
        delegate.saveContext()
    }
}






