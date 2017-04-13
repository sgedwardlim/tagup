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
    
    // MARK: Properties
    enum State {
        // Holds all the possible states for a TagViewController at any point in time
        case editable
        case registration
        case presentable
    }
    
    // Gets the current state of the TagViewController
    fileprivate var currentState: State
    
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
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        
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
}



















