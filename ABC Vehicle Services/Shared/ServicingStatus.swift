//
//  ServicingStatus.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 11/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
// Class to draw/view Service Status of Car

import Foundation
import UIKit

enum CellIdentifiers {
     static let serviceStatusCell = "ServiceStatusCell"
   }

class ServicingStatusTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView = UITableView()
    private var serviceStatusView = UIView()
    
    private var refreshControl = UIRefreshControl()
    
    /// array to draw table
    var serviceItems: Array<ServiceStatusItem> = []
    var serviceStatus: servicingStatus = .no_active_servicing // status if servicing or not
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ServiceStatusCell.self, forCellReuseIdentifier: CellIdentifiers.serviceStatusCell)
        tableView.tableFooterView = UIView() // remove empty last cell
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Method to set up the UI
    func setup() {
        
        serviceStatusView.backgroundColor = .clear
        serviceStatusView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(serviceStatusView)
        
        var size: CGFloat = 0.0
        if(!Common.isPhone()) {
            size = 80.0
        } else {
            size = 65.0
        }
        
        serviceStatusView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        serviceStatusView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        serviceStatusView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        serviceStatusView.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .darkGray
        
        // refresh control to refresh the data
        refreshControl.addTarget(self, action: #selector(reloadData), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(self.refreshControl)
        self.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: serviceStatusView.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    // Method to show status string
    func showCombindStatus() {
        
        var msg = LocalizationKey.service_status_str.string
        
        let estimate = "6"
        
        if(serviceStatus == .active_servicing) {
            msg += "\(LocalizationKey.estimation_str.string) \(estimate) hrs)"
        } else {
            msg += LocalizationKey.no_service_prog_str.string
        }
        
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit // image will never be strecthed vertially or horizontally
        imgView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imgView.image = UIImage(named: LocalizationKey.img_service_status.string)
        serviceStatusView.addSubview(imgView)
        
        var size: CGFloat = 0.0
        if(!Common.isPhone()) {
            if(Common.isPotrait()) {
                size = 80
            } else {
                size = 120
            }
        } else {
            if(!Common.isPotrait()) {
                size = 20
            }
        }
        
        imgView.centerYAnchor.constraint(equalTo:self.serviceStatusView.centerYAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo:self.serviceStatusView.leadingAnchor, constant:10+size).isActive = true
        
        size = 50.0
        if(!Common.isPhone()) {
            size = 70
        }
        
        imgView.widthAnchor.constraint(equalToConstant:size).isActive = true
        imgView.heightAnchor.constraint(equalToConstant:size).isActive = true
        
        let mainStatuslabel = UILabel()
        mainStatuslabel.translatesAutoresizingMaskIntoConstraints = false
        serviceStatusView.addSubview(mainStatuslabel)
        
        mainStatuslabel.centerYAnchor.constraint(equalTo:self.serviceStatusView.centerYAnchor).isActive = true
        mainStatuslabel.leadingAnchor.constraint(equalTo:imgView.trailingAnchor, constant: 5).isActive = true
        mainStatuslabel.widthAnchor.constraint(equalTo:self.serviceStatusView.widthAnchor, multiplier: 0.80).isActive = true
        
        
        size = 18.0
        if(!Common.isPhone()) {
            size = Common.dynamicFontSize(15)
        }
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: msg)
        attributedString.setColorForText(textForAttribute: msg, withColor: UIColor.darkGray)
        attributedString.setFontForText(textForAttribute: msg, withFont: UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold))
        
        if(serviceStatus == .active_servicing) {
            attributedString.setColorForText(textForAttribute: "\(estimate) hrs", withColor: kBrandColor)
            attributedString.setFontForText(textForAttribute: "\(LocalizationKey.estimation_str.string) \(estimate) hrs)", withFont: UIFont.systemFont(ofSize:(size-5), weight:UIFont.Weight.bold))
        } else {
            attributedString.setFontForText(textForAttribute: LocalizationKey.no_service_prog_str.string, withFont: UIFont.systemFont(ofSize:(size-5), weight:UIFont.Weight.bold))
        }
        
        mainStatuslabel.attributedText = attributedString
    }
    
    // Method to reload table
    @objc func reloadData() {
        
        tableView.reloadData()
        self.frame.size.height = serviceStatusView.frame.size.height + tableView.contentSize.height + 10
        
        refreshControl.endRefreshing()
    }
    
    // MARK: Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.serviceStatusCell, for: indexPath as IndexPath) as! ServiceStatusCell
        cell.backgroundColor = .clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        
        cell.serviceStatus = serviceItems[indexPath.row]
        
        cell.separatorInset = UIEdgeInsets.init(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 100.0, bottom: 0.0, right: 0.0)
        
        return cell
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(!Common.isPhone()) {
            return 80
        } else {
            return 65
        }
    }
    
}
