//
//  LinkTagViewController.swift
//  tagup
//
//  Created by Edward on 4/17/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

/*
 *  Holds all the displayed elements seen on a LinkTagViewController
 */
class LinkTagViewController: TagViewController {
    
    // MARK: UIView Elements
    lazy var linkPreviewImageView: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        iv.contentMode = .scaleToFill
        
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.lightGray.cgColor
        iv.layer.cornerRadius = 10.0
        iv.layer.masksToBounds = true
        
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLinkPreviewImageSelected)))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var linkField: UITextField = {
        let field = UITextField()
        field.borderStyle = .bezel
        field.keyboardType = .URL
        field.placeholder = "https://www.example.com"
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return indicator
    }()
    
    // MARK: Properties
    var viewModel: LinkTagViewModel
    var presentableViewController: LinkTagViewController?
    var linkPreviewImageViewHeightAnchor: NSLayoutDimension?
    // need this constraint to invalidate the layout
    var linkPreviewImageViewHeightAnchorMultiplier: NSLayoutConstraint?
    
    /*
     *  Every Instantiation of ImageTagViewController must have a viewModel
     *  along with the state of itself
     */
    init(state: State, viewModel: LinkTagViewModel, presentableVC: LinkTagViewController? = nil) {
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
        // Needed to display UIView elements under UINavigationBar
        edgesForExtendedLayout = []
        // enable easy dismissal of the keyboard
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewSelected)))
        
        // Setup the view based off the current state of the view
        switch currentState {
        case .editable:
            setupEditableStateView()
            print("editable state")
        case .registration:
            setupRegisterStateView()
            print("registration state")
        case .presentable:
            setupPresentableStateView()
            print("presentable state")
        }
    }
    
    // MARK: UIView State Setup Functions
    /*
     *  Sets up how the view will look in an editable state,
     *  will look exactly the same as the registration state,
     *  with the exception of a delete button at the bottom of contentView
     */
    private func setupEditableStateView() {
        setupLinkFieldLayout()
        setupLinkPreviewImageLayout()
        setupNotesLabelLayout()
        
        contentView.addSubview(notesField)
        
        notesField.heightAnchor.constraint(equalToConstant: 120).isActive = true
        notesField.topAnchor.constraint(equalTo: notesLabel.bottomAnchor).isActive = true
        notesField.leftAnchor.constraint(equalTo: notesLabel.leftAnchor).isActive = true
        notesField.rightAnchor.constraint(equalTo: notesLabel.rightAnchor).isActive = true
        // notes field is not the last element, instead it will be the delete button
        notesField.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -20).isActive = true
    }
    
    /*
     *  Sets up how the view will look in an registration state,
     *  will look exactly the same as the editable state, with the
     *  exception of a delete button at the bottom of contentView
     */
    private func setupRegisterStateView() {
        setupLinkFieldLayout()
        setupLinkPreviewImageLayout()
        setupNotesLabelLayout()
        setupNotesViewLayout()
        
        // hide the linkPreviewImageView before link is entered
        linkPreviewImageViewHeightAnchorMultiplier?.isActive = false
        linkPreviewImageViewHeightAnchor?.constraint(equalToConstant: 0).isActive = true
    }
    
    /*
     *  Sets up how the view will look in an presentable state,
     *  every element in the view in this state should be uneditable
     */
    private func setupPresentableStateView() {
        setupLinkFieldLayout()
        setupLinkPreviewImageLayout()
        setupNotesLabelLayout()
        setupNotesViewLayout()
        
        // disable all the fields
        linkField.isEnabled = false
        linkPreviewImageView.isUserInteractionEnabled = false
    }
    
    /*
     *  Loads up data from the viewModel into the respective fields of
     *  ImageTagViewController
     */
    private func populateFieldsWithData() {
        titleField.text = viewModel.titleText
        linkField.text = viewModel.link
        linkPreviewImageView.image = viewModel.linkImage
        notesField.text = viewModel.notesText
    }
    
    // MARK: UIView Element Layout Functions
    private func setupLinkFieldLayout() {
        contentView.addSubview(linkField)
        
        linkField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        linkField.leftAnchor.constraint(equalTo: titleField.leftAnchor).isActive = true
        linkField.rightAnchor.constraint(equalTo: titleField.rightAnchor).isActive = true
        linkField.topAnchor.constraint(equalTo: titleField.bottomAnchor).isActive = true
    }
    
    private func setupLinkPreviewImageLayout() {
        contentView.addSubview(linkPreviewImageView)
        
        linkPreviewImageView.topAnchor.constraint(equalTo: linkField.bottomAnchor, constant: 12).isActive = true
        linkPreviewImageView.leftAnchor.constraint(equalTo: titleField.leftAnchor).isActive = true
        linkPreviewImageView.rightAnchor.constraint(equalTo: titleField.rightAnchor).isActive = true
        linkPreviewImageViewHeightAnchor = linkPreviewImageView.heightAnchor
        linkPreviewImageViewHeightAnchorMultiplier = linkPreviewImageViewHeightAnchor?.constraint(equalTo: titleField.widthAnchor, multiplier: 2/3)
        linkPreviewImageViewHeightAnchorMultiplier?.isActive = true
    }
    
    private func setupNotesLabelLayout() {
        contentView.addSubview(notesLabel)
        
        notesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        notesLabel.topAnchor.constraint(equalTo: linkPreviewImageView.bottomAnchor, constant: 8).isActive = true
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

extension LinkTagViewController: UITextFieldDelegate, UIWebViewDelegate {
    
    // MARK: UINavigation Button
    override func handleSaveSelected() {
        let title = titleField.text
        let link = linkField.text
        let image = linkPreviewImageView.image
        let notes = notesField.text

        viewModel.saveLinkTag(title, link, image, notes)
        dismiss(animated: true, completion: nil)
    }
    
    override func handleEditSelected() {
        // Initalize editable stateVC with reference to current VC
        let viewController = LinkTagViewController(state: .editable, viewModel: viewModel, presentableVC: self)
        let nav = UINavigationController(rootViewController: viewController)
        present(nav, animated: true, completion: nil)
    }
    
    override func handleDeleteSelected() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteButton = UIAlertAction(title: "Delete Tag", style: .destructive) { (action) in
            self.viewModel.deleteLinkTag()
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
    
    // MARK: Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if currentState == .registration {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: { 
                // show the linkPreviewImageView when link is entered
                self.linkPreviewImageViewHeightAnchorMultiplier?.isActive = false
                self.linkPreviewImageViewHeightAnchor?.constraint(equalTo: self.titleField.widthAnchor, multiplier: 2/3).isActive = true
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        requestLinkThumbnail()
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        _ = textFieldShouldReturn(textField)
    }
    
    private func requestLinkThumbnail() {
        linkPreviewImageView.image = nil
        
        let thumbnailSize = CGRect(x: 0, y: -600, width: 800, height: 600)
        let webView = UIWebView(frame: thumbnailSize)
        let https = "https://"
        var http = "http://"
        guard var urlString = linkField.text?.lowercased() else { return }
        // check if the url has https or http before the url
        if (!urlString.hasPrefix(https) && !urlString.hasPrefix(http)) {
            // insert http:// before the url if it dosent already exist
            http.append(urlString)
            urlString = http
        }
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.loadRequest(urlRequest)
        webView.delegate = self
        view.addSubview(webView)
        
        view.addSubview(activityIndicator)
        activityIndicator.center = linkPreviewImageView.center
        activityIndicator.startAnimating()
        
        print("request url image")
    }
    
    // MARK: UIWebViewDelegate Functions
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // delay the webview render for 5 seconds to allow for thumbnail to load properly
        let delay = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: delay) { [weak self] in
            
            UIGraphicsBeginImageContext(webView.bounds.size)
            webView.layer.render(in: UIGraphicsGetCurrentContext()!)
            self?.linkPreviewImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            webView.removeFromSuperview()
            
            self?.activityIndicator.stopAnimating()
            print("Finished loading webview")
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        webView.removeFromSuperview()
        requestLinkThumbnail()
        print("Failure")
    }
    
    // MARK: Handle Target Selector Actions
    func handleLinkPreviewImageSelected() {
        if currentState == .presentable || currentState == .registration {
            guard let link = linkField.text else { return }
            // start a request to open link in web browser
            print("user selected link: \(link)")
        }
    }
    
    func handleViewSelected() {
        // call the dismisal of keyboard when the view is selected while keyboard is showing
        self.view.endEditing(true)
    }
}






















