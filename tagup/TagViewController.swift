//
//  ViewController.swift
//  tagup
//
//  Created by Edward on 4/12/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

/*
 *  Holds all the displayed elements seen on a generic TagRegistrationViewController
 *  all types of TAGS should inherhit from this class and adhere to common layout rules
 *  1.) titleField is anchored to the top of view
 *  2.) content unique to children view should be next
 *  3.) notesLabel and notesField should come right after each other and placed towards
        the bottom of the children views
    4.) notesField's or last view element (delete button) bottom anchor must be tied to
        contentView's bottomAnchor as such, ex...
        notesField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
    5.) If currentState is presentable, deletebutton will be placed viewable at all times,
        if currentState is editable, deleteButton will be placed at the bottom of contentView
 
 */
class TagViewController: UIScrollViewController {
    // MARK: NavigationBar View Elements
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelSelected))
        return button
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveSelected))
        return button
    }()
    
    // MARK: ContentView Elements
    let titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Title"
        field.backgroundColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let notesLabel: UILabel = {
        let label = UILabel()
        label.text = "notes: "
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let notesField: UITextView = {
        let field = UITextView()
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.5
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    // MARK: Editable State UIView Elements
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(UIColor(hex: 0xE84A5F), for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.borderWidth = 0.5
        button.layer.borderColor  = UIColor.lightGray.cgColor
        
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
    enum State {
        // Holds all the possible states for a TagViewController at any point in time
        case editable
        case registration
        case presentable
    }
    
    // Gets the current state of the TagViewController
    var currentState: State
    
    // Inorder to instantiate this TagViewController,  a state is required
    init(state: State) {
        self.currentState = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        // setup navigationButtons
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        
        // Setup the view based off the current state of the view
        switch currentState {
        case .editable:
            setupEditableStateView()
        case .presentable:
            setupPresentableStateView()
        case .registration:
            break
        }
        
        setupTitleFieldLayout()
    }
    
    /*
     *  Sets up how the view will look in an editable state,
     *  will look exactly the same as the registration state,
     *  with the exception of a delete button at the bottom of contentView
     */
    private func setupEditableStateView() {
        // Place the delete button as the last item
        contentView.addSubview(deleteButton)
        
        deleteButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
    }
    
    /*
     *  Sets up how the view will look in an presentable state,
     *  every element in the view in this state should be uneditable
     */
    private func setupPresentableStateView() {
        // Setup navigationBar buttons
        navigationItem.rightBarButtonItem = editButton
        // Setup fields for presentable state
        titleField.isEnabled = false
        notesField.isEditable = false
        
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
    
    private func setupTitleFieldLayout() {
        contentView.addSubview(titleField)
        
        titleField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        titleField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
    }
}

/*
 *  Controller Actions for a generic TagRegistrationViewController
 */
extension TagViewController {
    
    // MARK: NavigationBar Items
    func handleCancelSelected() {
        dismiss(animated: true, completion: nil)
    }
    
    func handleSaveSelected() {
        dismiss(animated: true, completion: nil)
    }
    
    func handleEditSelected() {
        dismiss(animated: true, completion: nil)
    }
    
    func handleDeleteSelected() {
        dismiss(animated: true, completion: nil)
    }
}



















