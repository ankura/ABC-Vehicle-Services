//
//  MenuCell.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 10/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  View component for Menu item cell


import UIKit

class MenuCell: UITableViewCell {
  //@@@IBOutlet weak var menuImageView: UIImageView!
  @IBOutlet weak var menuNameLabel: UILabel!
  
  func configureForMenuItem(_ item: MenuItem) {
    //@@menuImageView.image = item.image
    menuNameLabel.text = item.title
  }
}
