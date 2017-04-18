//
//  LinkTagViewModel.swift
//  tagup
//
//  Created by Edward on 4/17/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class LinkTagViewModel {
    
    var linkTag: LinkTag?
    
    var titleText: String {
        guard let title = linkTag?.title else {
            return ""
        }
        return title
    }
    
    var link: String {
        guard let link = linkTag?.link else {
            return ""
        }
        return link
    }
    
    // get the image that was saved as the preview
    var linkImage: UIImage? {
        guard let imageData = linkTag?.image else {
            return nil
        }
        return UIImage(data: imageData as Data)!
    }
    
    var notesText: String {
        guard let notes = linkTag?.notes else {
            return ""
        }
        return notes
    }
    
    /*
     *  Initalize ImageTagViewModel with a Tag
     */
    init(linkTag: LinkTag?) {
        self.linkTag = linkTag
    }
    
    func saveLinkTag(_ title: String?,_ link: String?,_ image: UIImage?,_ notes: String?) {
        
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = delegate.persistentContainer.viewContext
        // Check to see if the imageTag variable is set, if set,
        // then edit the current tag, else create a new tag to be saved
        if linkTag == nil {
            linkTag = LinkTag(context: context)
        }
        
        linkTag?.title = title
        linkTag?.notes = notes
        linkTag?.link = link
        linkTag?.image = getImageData(from: image)
        
        // usually the saving of the data should be handled by DataManager,
        // but coredata dosent allow for saving of data in such a way
        delegate.saveContext()
    }
    
    func deleteLinkTag() {
        guard let tag = linkTag else { return }
        DataManager.shared.deleteTag(tag)
    }
    
    private func getImageData(from image: UIImage?) -> NSData? {
        return image == nil ? nil : UIImagePNGRepresentation(image!)! as NSData
    }
}

