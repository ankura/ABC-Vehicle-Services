//
//  MenuItem.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 10/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Component to create Menu Items

import UIKit

struct MenuItem {
  let title: String
  //let image: UIImage?
  
  /*init(title: String, image: UIImage?) {
    self.title = title
    self.image = image
  }*/
    
    init(title: String) {
      self.title = title
    }
  
  static func allMenuItems() -> [MenuItem] {
    return [
        MenuItem(title: LocalizationKey.logout_str.string)
      
    ]
  }
  
}
