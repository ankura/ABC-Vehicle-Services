//
//  DetailViewController.swift
//  ListView
//
//  Created by Ankur Agarwal on 28/06/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Class to show detail of an list item

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var selectedListItem: ListItem? = nil
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    
    private let dataLabel: UITextView = {
        let label = UITextView()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.isEditable = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundColor
        
        self.navigationItem.title = "Detail"
        
        displayView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    
    
    /// Method to display the content
    private func displayView() {
        
        let itemType = self.selectedListItem!.type
        
        // if image add image view only
        if(itemType == .image) {
            
            self.view.addSubview(imageView)
            
            imageView.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width).offset(0)
                make.height.equalTo(self.view.safeAreaLayoutGuide.snp.width).multipliedBy(0.75)
                make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX).offset(0)
                make.centerY.equalTo(self.view.safeAreaLayoutGuide.snp.centerY).offset(0)
            }
            
            let size = CGSize(width: self.view.frame.width, height: self.view.frame.width*0.75) // maintain 3/4 aspect ration
            
            // image path
            let path = URL.urlInDocumentsDirectory(with: self.selectedListItem!.imageName).path
            // check if path/image exists
            if FileManager.default.fileExists(atPath: path) {
                
                var image = UIImage(contentsOfFile: path)
                // Scale image to fit within specified size while maintaining aspect ratio
                image = image!.af_imageAspectScaled(toFit: size)
                imageView.image = image
                
            } else {
                // if not show alert and navigate back
                self.showAlert(title: ALERT_TITLE_FAIL, message: IMAGE_ERROR, actionTitle: ALERT_OK, completion: { (success) -> Void in
                    if success {
                        self.navigationController?.popViewController(animated: true)
                    }})
            }
            
        } else if(itemType == .text || itemType == .other) {
            // if text or other, add scrollview and textview
            
            self.view.addSubview(scrollView)
            
            scrollView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(10)
                make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leadingMargin).offset(10)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).offset(-10)
                make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailingMargin).offset(-10)
            }
            scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: scrollView.contentSize.height)
            
            scrollView.addSubview(dataLabel)
            
            dataLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(scrollView).offset(0)
                make.leading.equalTo(scrollView).offset(5)
                make.width.equalTo(scrollView).offset(-10)
                make.height.equalToSuperview()
            }
            
            dataLabel.text = self.selectedListItem!.data
            
        }
        
    }
    
}
