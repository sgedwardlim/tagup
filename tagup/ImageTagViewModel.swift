//
//  ImageTagRegistrationViewModel.swift
//  tagup
//
//  Created by Edward on 4/12/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class ImageTagViewModel {
    
    var imageTag: ImageTag?
    
    var titleText: String {
        guard let title = imageTag?.title else {
            return ""
        }
        return title
    }
    
    var uploadedImage: UIImage {
        guard let imageData = imageTag?.image else {
            return #imageLiteral(resourceName: "upload_image_icon") 
        }
        return UIImage(data: imageData as Data)!
    }
    
    var notesText: String {
        guard let notes = imageTag?.notes else {
            return ""
        }
        return notes
    }
    
    init(imageTag: ImageTag?) {
        self.imageTag = imageTag
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
    
}
