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
    
    /*
     *  Initalize ImageTagViewModel with a Tag
    */
    init(imageTag: ImageTag?) {
        self.imageTag = imageTag
    }
    
    func saveImageTag(_ title: String?,_ image: UIImage?,_ notes: String?) {
        // Check to see if the imageTag variable is set, if set,
        // then user is in editing state
        if imageTag != nil {
            // user is editing existing tag
            imageTag?.title = title
            imageTag?.notes = notes
            imageTag?.image = getImageData(from: image)
        } else {
            // user is creating a new tag
            let delegate = (UIApplication.shared.delegate as! AppDelegate)
            let context = delegate.persistentContainer.viewContext
            let imageTag = ImageTag(context: context)
            
            // Initalize properties of ImageTag
            imageTag.title = title
            imageTag.notes = notes
            imageTag.image = getImageData(from: image)
        }
        
        guard let tag = imageTag else { return }
        DataManager.shared.saveImageTag(tag: tag)
    }
    
    func deleteImageTag() {
        guard let tag = imageTag else { return }
        DataManager.shared.deleteImageTag(tag)
    }
    
    private func getImageData(from image: UIImage?) -> NSData? {
        if image != #imageLiteral(resourceName: "upload_image_icon") {
            // image is not the default icon, proceed to parse data
            return UIImagePNGRepresentation(image!)! as NSData
        }
        return nil
    }
}
