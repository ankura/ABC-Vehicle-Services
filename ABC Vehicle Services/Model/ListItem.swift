//
//  ListItem.swift
//  ListView
//
//  Created by Ankur Agarwal on 27/06/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.


import Foundation


/// Model class for list item object
class ListItem: Object {
    
    @objc dynamic var ID: String = ""
    @objc dynamic var type: listType  = .notDefined
    @objc dynamic var date: Date? = nil
    @objc dynamic var data: String? = nil
    
    @objc dynamic var imageName: String = ""
    
    /// method for primary key
    /*override static func primaryKey() -> String? {
     return "ID"
     }*/
    
    static func create(withId ID: String,
                       type: String, date: String, data: String) -> ListItem {
        
        let item = ListItem()
        
        if(!ID.isEmpty) {
            item.ID = ID
        }
        
        if(type.uppercased() == "IMAGE") {
            item.type = .image
            item.imageName = Common.generateRandomString(length: 20)+".jpeg" // random file name
        } else if(type.uppercased() == "TEXT") {
            item.type = .text
        } else if(type.uppercased() == "OTHER") {
            item.type = .other
        }
        
        if(!date.isEmpty) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            item.date = dateFormatter.date(from: date)
        }
        
        if(!data.isEmpty) {
            item.data = data
        }
        
        return item
    }
}
