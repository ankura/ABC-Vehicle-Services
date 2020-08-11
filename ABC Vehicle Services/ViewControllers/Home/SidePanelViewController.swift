//
//  SidePanelViewController.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 10/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  SidePanel View Controller for showing options


import UIKit

class SidePanelViewController: UIViewController {
  @IBOutlet weak var menuTableView: UITableView!
  
  var delegate: SidePanelViewControllerDelegate?
  
  var menuItems: [MenuItem]!
  
  enum CellIdentifiers {
    static let menuItemCell = "MenuCell"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    menuTableView.reloadData()
  }
}

// MARK: Table View Data Source
extension SidePanelViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.menuItemCell, for: indexPath) as! MenuCell
    cell.configureForMenuItem(menuItems[indexPath.row])
    return cell
  }
}


// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = menuItems[indexPath.row]
    delegate?.didSelectMenuItem(item)
  }
}

protocol SidePanelViewControllerDelegate {
    
  func didSelectMenuItem(_ item: MenuItem)
}
