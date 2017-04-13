//
//  TagCellViewModel.swift
//  tagup
//
//  Created by Edward on 4/13/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class TagCellViewModel {
    
    var tag: ImageTag
    
    var titleText: String {
        guard let title = tag.title else {
            return ""
        }
        return title
    }
    
    var thumbnail: UIImage {
        guard let image = tag.image else {
            return #imageLiteral(resourceName: "upload_image_icon")
        }
        return UIImage(data: image as Data)!
    }
    
    init(tag: ImageTag) {
        self.tag = tag
    }
    
}
