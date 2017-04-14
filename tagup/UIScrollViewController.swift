//
//  UIScrollViewController.swift
//  tagup
//
//  Created by Edward on 4/12/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

/*
 *  A helper class that contains all the elements needed to enable scrolling on
 *  a generic view, all classes inheriting from UIScrollViewController will add
 *  all its children views into the contentView.
 */
class UIScrollViewController: UIViewController {
    
    // MARK: UIView Elements
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Properties
    var scrollViewTopAnchor: NSLayoutConstraint!
    var scrollViewBottomAnchor: NSLayoutConstraint!
    var scrollViewLeftAnchor: NSLayoutConstraint!
    var scrollViewRightAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollViewTopAnchor = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        scrollViewBottomAnchor = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        scrollViewLeftAnchor = scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
        scrollViewRightAnchor = scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        scrollViewTopAnchor.isActive = true
        scrollViewBottomAnchor.isActive = true
        scrollViewLeftAnchor.isActive = true
        scrollViewRightAnchor.isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}
