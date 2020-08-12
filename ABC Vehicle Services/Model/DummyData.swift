//
//  DummyData.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 12/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Class which will acts as data from service. Dummy data

import Foundation

struct carStat {
    let kmDriven: String?
    let fuelLevel: String?
    let tyreThread: String?
    let engineHealth: String?
    let oilLevel: String?
    let batteryLife: String?
}

struct carDetails {
  let carName:String?
  let carImage:String?
}

struct carServiceStatus {
    let oilChange: servicingItemStatus
    let oilChangeTime: String?
    let brakeOil: servicingItemStatus
    let brakeOilTime: String?
    let filterChange: servicingItemStatus
    let filterChangeTime: String?
    let batteryCheck: servicingItemStatus
    let batteryCheckTime: String?
}

class CarAPI {
 static func getCarData() -> [carDetails]{
   let details = [
     carDetails(carName: "Honda City", carImage: "honda_car"),
     carDetails(carName: "Ecosports", carImage: "ecosports_car"),
     carDetails(carName: "Hyundai Creta", carImage: "creta_car")
    ]
   return details
  }
}

class StatsAPI {
 static func getStatsData() -> [carStat]{
   let stats = [
     carStat(kmDriven: "14765", fuelLevel: "45 L", tyreThread: "2 mm", engineHealth: "Good", oilLevel: "2.6L / 3L", batteryLife: "Bad"),
     carStat(kmDriven: "4000", fuelLevel: "20 L", tyreThread: "4 mm", engineHealth: "Average", oilLevel: "1.0 L / 3L", batteryLife: "Good"),
     carStat(kmDriven: "53000", fuelLevel: "100 L", tyreThread: "3 mm", engineHealth: "Poor", oilLevel: "0.5 L / 4L", batteryLife: "Average")
    ]
   return stats
  }
}


class ServiceStatusAPI {
    static func getServiceStatus() -> [carServiceStatus]{
     let status = [
        carServiceStatus(oilChange: .not_started_servicing, oilChangeTime: "(10:30 am)", brakeOil: .not_started_servicing, brakeOilTime: "(11:15 am)", filterChange: .not_started_servicing, filterChangeTime: "(12:30 pm)", batteryCheck: .not_started_servicing, batteryCheckTime: "(02:00 pm)"),
        carServiceStatus(oilChange: .completed_servicing, oilChangeTime: "(12:30 pm)", brakeOil: .completed_servicing, brakeOilTime: "(02:00 pm)", filterChange: .in_progress_servicing, filterChangeTime: "(03:00 pm)", batteryCheck: .in_progress_servicing, batteryCheckTime: "(04:00 pm)"),
        carServiceStatus(oilChange: .completed_servicing, oilChangeTime: "(10:00 pm)", brakeOil: .in_progress_servicing, brakeOilTime: "(11:00 am)", filterChange: .in_progress_servicing, filterChangeTime: "(12:30 pm)", batteryCheck: .not_started_servicing, batteryCheckTime: "(02:30 pm)"),
        carServiceStatus(oilChange: .completed_servicing, oilChangeTime: "(01:00 pm)", brakeOil: .completed_servicing, brakeOilTime: "(02:15 pm)", filterChange: .completed_servicing, filterChangeTime: "(04:00 pm)", batteryCheck: .in_progress_servicing, batteryCheckTime: "(06:00 pm)"),
      ]
     return status
    }
}
