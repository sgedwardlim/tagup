//
//  TagCellViewModel.swift
//  tagup
//
//  Created by Edward on 4/13/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class TagCellViewModel {
    
    var tag: Tag
    
    var titleText: String {
        guard let title = tag.title else {
            return ""
        }
        return title
    }
    
    var thumbnail: UIImage {
        switch tag {
        case is ImageTag:
            let imageTag = tag as! ImageTag
            guard let image = imageTag.image else {
                return #imageLiteral(resourceName: "upload_image_icon")
            }
            return UIImage(data: image as Data)!
        default:
            return #imageLiteral(resourceName: "upload_image_icon")
        }
    }
    
    init(_ tag: Tag) {
        self.tag = tag
    }
    
}
