//
//  ServiceStatusCell.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 11/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//   Class to create Service Status cell

import UIKit

class ServiceStatusCell: UITableViewCell {
    
    var serviceStatus:ServiceStatusItem? {
        
        didSet {
            guard  let serviceitem = serviceStatus  else {
                return
            }
            
            if let serviceTitle = serviceitem.serviceItemTitle {
                serviceItemTitleLabel.text = serviceTitle
            }
            
            if let serviceImage = serviceitem.serviceItemImage {
                serviceItemImageView.image = UIImage(named: serviceImage)
            }
            
            if let serviceStatus = serviceitem.serviceItemStatus {
                switch serviceStatus {
                case .not_started_servicing:
                    serviceItemStatusLabel.text = LocalizationKey.not_started_str.string
                    serviceItemStatusLabel.textColor = .darkGray
                    break
                case .in_progress_servicing:
                    serviceItemStatusLabel.text = LocalizationKey.in_progress_str.string
                    serviceItemStatusLabel.textColor = .red
                    break
                case .completed_servicing:
                    serviceItemStatusLabel.text = LocalizationKey.completed_str.string
                    serviceItemStatusLabel.textColor = kBrandColor
                    break
                }
            }
            
            if let serviceTime = serviceitem.serviceItemTime {
                serviceItemTimeLabel.text = serviceTime
            }
            
        }
        
    }
    
    private let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    private let serviceItemImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    
    private let serviceItemTitleLabel:UILabel = {
        let label = UILabel()
        var size: CGFloat = 18.0
        if(!Common.isPhone()) {
            size = Common.dynamicFontSize(15)
        }
        label.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let serviceItemStatusLabel:UILabel = {
        let label = UILabel()
        var size: CGFloat = 15.0
        if(!Common.isPhone()) {
            size = Common.dynamicFontSize(12)
        }
        label.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
        label.textColor = kBrandColor
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let serviceItemTimeLabel:UILabel = {
        let label = UILabel()
        var size: CGFloat = 15.0
        if(!Common.isPhone()) {
            size = Common.dynamicFontSize(12)
        }
        label.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.containerView.backgroundColor = .clear
        self.contentView.addSubview(serviceItemImageView)
        containerView.addSubview(serviceItemTitleLabel)
        containerView.addSubview(serviceItemStatusLabel)
        containerView.addSubview(serviceItemTimeLabel)
        self.contentView.addSubview(containerView)
        
        var size: CGFloat = 0.0
        if(!Common.isPhone()) {
            if(Common.isPotrait()) {
                size = 80
            } else {
                size = 120
            }
        }
        
        serviceItemImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        serviceItemImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10+size).isActive = true
        
        size = 50.0
        if(!Common.isPhone()) {
            size = 70
        }
        serviceItemImageView.widthAnchor.constraint(equalToConstant:size).isActive = true
        serviceItemImageView.heightAnchor.constraint(equalToConstant:size).isActive = true
        
        size = 65
        if(!Common.isPhone()) {
            size = 80
        }
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.serviceItemImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:size).isActive = true
        
        serviceItemTitleLabel.centerYAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        serviceItemTitleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        serviceItemTitleLabel.widthAnchor.constraint(equalTo:self.containerView.widthAnchor, multiplier: 0.40).isActive = true
        
        serviceItemTimeLabel.centerYAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        serviceItemTimeLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        serviceItemTimeLabel.widthAnchor.constraint(equalTo:self.containerView.widthAnchor, multiplier: 0.28).isActive = true
        
        serviceItemStatusLabel.centerYAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        serviceItemStatusLabel.trailingAnchor.constraint(equalTo:self.serviceItemTimeLabel.leadingAnchor).isActive = true
        serviceItemStatusLabel.widthAnchor.constraint(equalTo:self.containerView.widthAnchor, multiplier: 0.30).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}


