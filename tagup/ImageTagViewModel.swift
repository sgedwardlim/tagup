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
        DataManager.shared.saveImageTag(title, image, notes)
    }
}
