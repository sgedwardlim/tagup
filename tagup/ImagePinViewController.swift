//
//  ViewController.swift
//  tagup
//
//  Created by Edward on 4/12/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class ImagePinViewController: UIScrollViewController {
    
    let titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Title"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(titleField)
        
        titleField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleField.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        titleField.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
}




















