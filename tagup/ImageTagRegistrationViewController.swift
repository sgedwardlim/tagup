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
    lazy var uploadImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "upload_image_icon"))
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .lightGray
    
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.99, alpha: 1.0).cgColor
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUploadImageSelected)))
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: Properties
    fileprivate var imageTagRegistrationViewModel: ImageTagRegistrationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // new registration of a image tag, so nil is passed
        imageTagRegistrationViewModel = ImageTagRegistrationViewModel(imageTag: nil)
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

/*
 *  Holds all controller functions for ImageTagViewController
 */
extension ImageTagRegistrationViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // MARK: NavigationBar Items
    override func handleSaveSelected() {
        let title = titleField.text
        let image = uploadImageView.image
        let notes = notesField.text
        imageTagRegistrationViewModel?.saveImageTag(title, image, notes)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Selector Functions
    func handleUploadImageSelected() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: ImagePicker Controls
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageSelected = info[UIImagePickerControllerOriginalImage] as! UIImage
        uploadImageView.image = imageSelected
        dismiss(animated: true, completion: nil)
    }
}


















