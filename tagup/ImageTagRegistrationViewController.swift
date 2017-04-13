//
//  ImageTagRegistrationViewController.swift
//  tagup
//
//  Created by Edward on 4/12/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

/*
 *  Holds all the displayed elements seen on a ImageTagViewController
 */
class ImageTagRegistrationViewController: TagRegistrationViewController {
    
    // MARK: UIView Elements
    let uploadImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "upload_image_icon"))
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .lightGray
    
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.99, alpha: 1.0).cgColor
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        // Needed to display UIView elements under UINavigationBar
        edgesForExtendedLayout = []
        
        contentView.addSubview(uploadImageView)
        contentView.addSubview(notesLabel)
        contentView.addSubview(notesField)
        
        uploadImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        uploadImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        uploadImageView.topAnchor.constraint(equalTo: titleField.bottomAnchor).isActive = true
        uploadImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true

        notesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        notesLabel.topAnchor.constraint(equalTo: uploadImageView.bottomAnchor, constant: 8).isActive = true
        notesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        notesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
        notesField.heightAnchor.constraint(equalToConstant: 120).isActive = true
        notesField.topAnchor.constraint(equalTo: notesLabel.bottomAnchor).isActive = true
        notesField.leftAnchor.constraint(equalTo: notesLabel.leftAnchor).isActive = true
        notesField.rightAnchor.constraint(equalTo: notesLabel.rightAnchor).isActive = true
        notesField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
    }
}




















