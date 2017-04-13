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
class ImageTagViewController: TagViewController {
    
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
    
    // MARK: Editable State UIView Elements
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Properties
    fileprivate var viewModel: ImageTagViewModel?
    
    convenience init(state: State, viewModel :ImageTagViewModel? = nil) {
        self.init(state: state)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        // Needed to display UIView elements under UINavigationBar
        edgesForExtendedLayout = []
        
        switch currentState {
        case .editable:
            setupEditableStateView()
            print("edit state")
        case .registration:
            // new registration of a image tag, so nil is passed
            viewModel = ImageTagViewModel(imageTag: nil)
            setupRegisterStateView()
            print("registration state")
        case .presentable:
            print("presentable state")
        }
    }
    
    /*
     *  Sets up how the view will look in an editable state,
     *  will look exactly the same as the registration state,
     *  with the exception of a delete button at the bottom of contentView
    */
    private func setupEditableStateView() {
        titleField.text = viewModel?.titleText
        uploadImageView.image = viewModel?.uploadedImage
        notesField.text = viewModel?.notesText
        
        setupRegisterStateView()
    }
    
    /*
     *  Sets up how the view will look in an editable state
     */
    private func setupRegisterStateView() {
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
extension ImageTagViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // MARK: NavigationBar Items
    override func handleSaveSelected() {
        let title = titleField.text
        let image = uploadImageView.image
        let notes = notesField.text
        viewModel?.saveImageTag(title, image, notes)
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


















