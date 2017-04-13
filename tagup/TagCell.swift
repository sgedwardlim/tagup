//
//  PinCell.swift
//  tagup
//
//  Created by Edward on 4/2/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    // MARK: Properties
    var tagCellViewModel: TagCellViewModel? {
        didSet {
            guard let viewModel = tagCellViewModel else { return }
            titleLabel.text = viewModel.titleText
            thumbnailImage.image = viewModel.thumbnail
        }
    }
    
    let tagContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thumbnailImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleToFill
        
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(tagContainer)
        tagContainer.addSubview(thumbnailImage)
        tagContainer.addSubview(titleLabel)
        
        tagContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tagContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tagContainer.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tagContainer.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        thumbnailImage.topAnchor.constraint(equalTo: tagContainer.topAnchor, constant: 2).isActive = true
        thumbnailImage.centerXAnchor.constraint(equalTo: tagContainer.centerXAnchor).isActive = true
        thumbnailImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -4).isActive = true
        thumbnailImage.leftAnchor.constraint(equalTo: tagContainer.leftAnchor, constant: 2).isActive = true
        thumbnailImage.rightAnchor.constraint(equalTo: tagContainer.rightAnchor, constant: -2).isActive = true
        
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: tagContainer.bottomAnchor, constant: -4).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: thumbnailImage.leftAnchor, constant: 4).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: thumbnailImage.rightAnchor).isActive = true
    }
}











