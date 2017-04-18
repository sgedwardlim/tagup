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

        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = delegate.persistentContainer.viewContext
        // Check to see if the imageTag variable is set, if set,
        // then edit the current tag, else create a new tag to be saved
        if imageTag == nil {
            imageTag = ImageTag(context: context)
        }
        
        imageTag?.title = title
        imageTag?.notes = notes
        imageTag?.image = getImageData(from: image)
        
        // usually the saving of the data should be handled by DataManager,
        // but coredata dosent allow for saving of data in such a way
        delegate.saveContext()
    }
    
    func deleteImageTag() {
        guard let tag = imageTag else { return }
        DataManager.shared.deleteTag(tag)
    }
    
    private func getImageData(from image: UIImage?) -> NSData? {
        if image != #imageLiteral(resourceName: "upload_image_icon") {
            // image is not the default icon, proceed to parse data
            return UIImagePNGRepresentation(image!)! as NSData
        }
        return nil
    }
}
