//
//  HomeViewController.swift
//  ListView
//
//  Created by Ankur Agarwal on 27/06/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Class to show list.

import Foundation
import UIKit
import SwiftyJSON
import Toast_Swift
import Alamofire

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundColor
        
        //self.navigationItem.title = "My List"
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

}
