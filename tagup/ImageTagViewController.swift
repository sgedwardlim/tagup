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
//        iv.backgroundColor = .lightGray
    
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
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(handleDeleteSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Presentable State UIView Elements
    lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditSelected))
        return button
    }()
    
    // MARK: Properties
    fileprivate var viewModel: ImageTagViewModel
    
    /*
     *  Every Instantiation of ImageTagViewController must have a viewModel
     *  along with the state of itself
    */
    init(state: State, viewModel: ImageTagViewModel) {
        self.viewModel = viewModel
        super.init(state: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        // Needed to display UIView elements under UINavigationBar
        edgesForExtendedLayout = []
        
        // Setup the view based off the current state of the view
        switch currentState {
        case .editable:
            setupEditableStateView()
            
            print("editable state")
        case .registration:
            setupRegisterStateView()
            setupUploadImageViewLayout()
            setupNotesLabelLayout()
            setupNotesViewLayout()
            print("registration state")
        case .presentable:
            setupPresentableStateView()
            setupUploadImageViewLayout()
            setupNotesLabelLayout()
            setupNotesViewLayout()
            print("presentable state")
        }
    }
    
    /*
     *  Sets up how the view will look in an editable state,
     *  will look exactly the same as the registration state,
     *  with the exception of a delete button at the bottom of contentView
    */
    private func setupEditableStateView() {
        populateFieldsWithData()
        
        setupUploadImageViewLayout()
        setupNotesLabelLayout()
        // Place the delete button as the last item instead of noteTextView
        contentView.addSubview(notesField)
        
        notesField.heightAnchor.constraint(equalToConstant: 120).isActive = true
        notesField.topAnchor.constraint(equalTo: notesLabel.bottomAnchor).isActive = true
        notesField.leftAnchor.constraint(equalTo: notesLabel.leftAnchor).isActive = true
        notesField.rightAnchor.constraint(equalTo: notesLabel.rightAnchor).isActive = true
        
        view.addSubview(deleteButton)
        
        deleteButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        deleteButton.topAnchor.constraint(equalTo: notesField.bottomAnchor, constant: 20).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        
    }
    
    /*
     *  Sets up how the view will look in an registration state,
     *  will look exactly the same as the editable state, with the
     *  exception of a delete button at the bottom of contentView
     */
    private func setupRegisterStateView() {
        populateFieldsWithData()
    }
    
    /*
     *  Sets up how the view will look in an presentable state,
     *  every element in the view in this state should be uneditable
     */
    private func setupPresentableStateView() {
        populateFieldsWithData()
        
        // Setup navigationBar buttons
        navigationItem.rightBarButtonItem = editButton
        // Setup fields for presentable state
        titleField.isEnabled = false
        notesField.isEditable = false
        uploadImageView.isUserInteractionEnabled = false
        
        // Add the delete button to the superview of the scrollview,
        // keep the delete button on screen at all times
        view.addSubview(deleteButton)
        
        // Repostion scrollview to not extend to the bounds of screen
        scrollViewBottomAnchor.isActive = false
        scrollView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor).isActive = true
        
        deleteButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
    }
    
    /*
     *  Loads up data from the viewModel into the respective fields of
     *  ImageTagViewController
    */
    private func populateFieldsWithData() {
        titleField.text = viewModel.titleText
        uploadImageView.image = viewModel.uploadedImage
        notesField.text = viewModel.notesText
    }
    
    private func setupUploadImageViewLayout() {
        contentView.addSubview(uploadImageView)
        
        uploadImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        uploadImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        uploadImageView.topAnchor.constraint(equalTo: titleField.bottomAnchor).isActive = true
        uploadImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    private func setupNotesLabelLayout() {
        contentView.addSubview(notesLabel)
        
        notesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        notesLabel.topAnchor.constraint(equalTo: uploadImageView.bottomAnchor, constant: 8).isActive = true
        notesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        notesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
    }
    
    private func setupNotesViewLayout() {
        contentView.addSubview(notesField)
        
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
        viewModel.saveImageTag(title, image, notes)
        dismiss(animated: true, completion: nil)
    }
    
    func handleEditSelected() {
        let imageTagViewController = ImageTagViewController(state: .editable, viewModel: viewModel)
        let nav = UINavigationController(rootViewController: imageTagViewController)
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: Selector Functions
    func handleUploadImageSelected() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func handleDeleteSelected() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteButton = UIAlertAction(title: "Delete Tag", style: .destructive) { (action) in
            self.viewModel.deleteImageTag()
            // navigate back to the homeview controller, number of dismiss 
            // called depends on the currentState of the view
            switch self.currentState {
            case .presentable:
                self.dismiss(animated: true, completion: nil)
            case .editable:
                self.dismiss(animated: false, completion: nil)
                self.dismiss(animated: true, completion: nil)
            default:
                print("End of the world if this prints")
            }
            
            print("delete selected")
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
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


















