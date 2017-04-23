//
//  NoteTagViewController.swift
//  tagup
//
//  Created by Edward on 4/21/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class NoteTagViewController: TagViewController {
    
    // MARK: Properties
    fileprivate var viewModel: NoteTagViewModel
    // Holds a reference to the presentableState VC for deletion handling
    fileprivate var presentableViewController: NoteTagViewController?
    
    /*
     *  Every Instantiation of ImageTagViewController must have a viewModel
     *  along with the state of itself
     */
    init(state: State, viewModel: NoteTagViewModel, presentableVC: NoteTagViewController? = nil) {
        self.viewModel = viewModel
        self.presentableViewController = presentableVC
        super.init(state: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        populateFieldsWithData()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // only populate the fields with data when currentState is in presentable mode
        if currentState == .presentable {
            populateFieldsWithData()
        }
    }
    
    private func setupViews() {
        switch currentState {
        case .registration:
            setupRegistrationStateView()
        case .editable:
            setupEditableStateView()
        case .presentable:
            setupPresentableStateView()
        }
    }
    
    private func setupRegistrationStateView() {
        setupNotesLabelLayout()
        setupNotesViewLayout()
    }
    
    private func setupEditableStateView() {
        setupNotesLabelLayout()
        // Place the delete button as the last item instead of noteTextView
        contentView.addSubview(notesField)
        
        notesField.heightAnchor.constraint(equalToConstant: 120).isActive = true
        notesField.topAnchor.constraint(equalTo: notesLabel.bottomAnchor).isActive = true
        notesField.leftAnchor.constraint(equalTo: notesLabel.leftAnchor).isActive = true
        notesField.rightAnchor.constraint(equalTo: notesLabel.rightAnchor).isActive = true
        notesField.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -20).isActive = true
    }
    
    private func setupPresentableStateView() {
        setupNotesLabelLayout()
        setupNotesViewLayout()
        
        // disable all the fields here
        // only fields are already disabled in super class
    }
    
    /*
     *  Loads up data from the viewModel into the respective fields of
     *  ImageTagViewController
     */
    private func populateFieldsWithData() {
        titleField.text = viewModel.titleText
        notesField.text = viewModel.notesText
    }
    
    private func setupNotesLabelLayout() {
        contentView.addSubview(notesLabel)
        
        notesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        notesLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 8).isActive = true
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
 *  Holds all controller functions for NoteTagViewController
 */
extension NoteTagViewController {
    // MARK: NavigationBar Items
    override func handleSaveSelected() {
        let title = titleField.text
        let notes = notesField.text
        viewModel.saveNoteTag(title, notes)
        dismiss(animated: true, completion: nil)
    }
    
    override func handleEditSelected() {
        // Initalize editable stateVC with reference to current VC
        let viewController = NoteTagViewController(state: .editable, viewModel: viewModel, presentableVC: self)
        let nav = UINavigationController(rootViewController: viewController)
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: Selector Functions
    override func handleDeleteSelected() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteButton = UIAlertAction(title: "Delete Tag", style: .destructive) { (action) in
            self.viewModel.deleteNoteTag()
            // navigate back to the homeview controller, way of dismissal
            // depends on the currentState of the view
            switch self.currentState {
            case .presentable:
                self.dismiss(animated: true, completion: nil)
            case .editable:
                self.dismiss(animated: false, completion: {
                    self.presentableViewController?.dismiss(animated: true, completion: nil)
                })
            default:
                print("End of the world if this prints")
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}






