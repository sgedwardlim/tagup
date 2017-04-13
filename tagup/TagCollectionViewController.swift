//
//  ViewController.swift
//  tagup
//
//  Created by Edward on 4/1/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class TagCollectionViewController: UICollectionViewController {
    
    // MARK: UIView Elements
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(handleAddButtonSelected))
        return button
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Properties
    fileprivate let tagCellId = "tagCellId"
    fileprivate let cellsPerRow: CGFloat = 2.0
    fileprivate let margin: CGFloat = 10.0
    fileprivate let topMargin: CGFloat = 20.0
    var tags: [TagCellViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // fetch all the tags from coredata
        DataManager.shared.fetchAllTags { [weak self] tags in
            self?.tags = tags
            self?.collectionView?.reloadData()
//            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func setupViews() {
//        activityIndicator.startAnimating()
        
        navigationItem.rightBarButtonItem = addButton
        
//        collectionView?.backgroundView = activityIndicator
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(TagCell.self, forCellWithReuseIdentifier: tagCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = tags?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellId, for: indexPath) as! TagCell
        cell.tagCellViewModel = tags?[indexPath.item]
        return cell
    }
}

// MARK: Handle User Actions
extension TagCollectionViewController {
    /*
     Modally present the creation view for a single tag
     */
    func handleAddButtonSelected() {
        presentCustomSelectionAlert()
    }
    
    private func presentCustomSelectionAlert() {
        let alert = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let linkButton = UIAlertAction(title: "Link", style: .default) { (action) in
            // link selected
            print("Link selected")
        }
        
        let imageButton = UIAlertAction(title: "Image", style: .default) { (action) in
            // image selected
            print("Image selected")
            let imageTagRegistrationController = ImageTagRegistrationViewController()
            let nav = UINavigationController(rootViewController: imageTagRegistrationController)
            self.present(nav, animated: true, completion: nil)
        }
        
        let noteButton = UIAlertAction(title: "Note", style: .default) { (action) in
            // note selected
            print("Note selected")
        }
        
        let folderButton = UIAlertAction(title: "Folder", style: .default) { (action) in
            // folder selected
            print("Folder selected")
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(linkButton)
        alert.addAction(imageButton)
        alert.addAction(noteButton)
        alert.addAction(folderButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: Collection View and Cell Layout Customizations
extension TagCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = customize(collectionViewLayout, margin: margin)
        let itemWidth = cellWidth(collectionView, layout: flowLayout, cellsPerRow: cellsPerRow)
        return CGSize(width: itemWidth, height: itemWidth * 1.1)
    }
    
    /*
     Customizes the layout of a collectionView with space to the left and right of each cell that is 
     specified with the parameter margin
    */
    private func customize(_ collectionViewLayout: UICollectionViewLayout, margin: CGFloat) -> UICollectionViewFlowLayout {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        // Interitem spacing affects the horrizontal spacing between cells
        flowLayout.minimumInteritemSpacing = margin
        // Line spacing affects the vertical space between cells
        flowLayout.minimumLineSpacing = margin
        // Section insets affect the entire container for the collectionView cells
        flowLayout.sectionInset = UIEdgeInsets(top: topMargin, left: margin, bottom: 0, right: margin)
        return flowLayout
    }
    
    /*
     Calculates the proper size of an individual cell with the specified number of cells in a row desired,
     along with the layout of the collectionView
     */
    private func cellWidth(_ collectionView: UICollectionView, layout flowLayout: UICollectionViewFlowLayout, cellsPerRow: CGFloat) -> CGFloat {
        // Calculate the ammount of "horizontal space" that will be needed in a row
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * (cellsPerRow - 1)
        let itemWidth = (collectionView.bounds.size.width - marginsAndInsets) / cellsPerRow
        return itemWidth
    }
}















