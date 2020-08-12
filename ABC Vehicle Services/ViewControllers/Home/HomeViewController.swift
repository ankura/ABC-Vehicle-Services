//
//  HomeViewController.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 09/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Main/Home view controller

import Foundation
import UIKit
import SwiftyJSON
import Toast_Swift
import Alamofire


class HomeViewController: UIViewController, UIGestureRecognizerDelegate, SidePanelViewControllerDelegate {
    
    // add shadown on controller if slide pannel is open
    var currentState: slideOutState = .collapsed {
       didSet {
         let shouldShowShadow = currentState != .collapsed
         showShadowForCenterViewController(shouldShowShadow)
       }
     }
    
    var leftViewController: SidePanelViewController?
    let centerPanelExpandedOffset: CGFloat = 60 // How much panel should expand
    var carInfoList: Array<carInfoItem> = [] // Array to store car information
    var carModel: carInfoItem? // 
    var currentServicingStatus: servicingStatus = .no_active_servicing
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = kBackgroundColor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let carModelView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let carInfoSubView1: UIStackView = {
        //Stack View
        let stackView   = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis  = .horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment = .center
        stackView.spacing   = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let carInfoSubView2: UIStackView = {
        //Stack View
        let stackView   = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis  = .horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment = .center
        stackView.spacing   = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let carInfoView: UIStackView = {

        //Stack View
        let stackView   = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis  = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill//.center
        stackView.spacing   = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }()
    
    private let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let servicingStatusView: ServicingStatusTableView = {
       let view = ServicingStatusTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Method to draw the car info panel
    func getCarInfoView(_ item: carInfoItem) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let value = UILabel()
        value.backgroundColor =  .clear
        value.text = item.value
        var size: CGFloat = 16.0
        if(!Common.isPhone()) {
            size = Common.dynamicFontSize(10)
        }
        value.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
        value.textColor = kBrandColor
        value.textAlignment = .center
        value.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(value)
        
        value.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        value.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        value.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
        let title = UILabel()
        title.backgroundColor =  .clear
        title.text = item.title
        title.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
        title.textColor = .darkGray
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)
        
        title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        title.topAnchor.constraint(equalTo: value.bottomAnchor, constant: 0).isActive = true
        
        return view
    }
    
    
    // method to draw upper portion which consist of car info and book service button
    func upperPortionView() {
        
        let dummyView = UIView()
        dummyView.backgroundColor = .gray
        dummyView.translatesAutoresizingMaskIntoConstraints = false
        carModelView.addSubview(dummyView)

        dummyView.centerYAnchor.constraint(equalTo: carModelView.centerYAnchor, constant: 0).isActive = true
        dummyView.centerXAnchor.constraint(equalTo: carModelView.centerXAnchor, constant: 0).isActive = true
        
        let cardetailView = UIView()
        cardetailView.backgroundColor = .clear
        cardetailView.translatesAutoresizingMaskIntoConstraints = false
        self.carModelView.addSubview(cardetailView)
        
        cardetailView.topAnchor.constraint(equalTo: carModelView.topAnchor, constant: 0).isActive = true
        cardetailView.leadingAnchor.constraint(equalTo: carModelView.leadingAnchor, constant: 0).isActive = true
        cardetailView.trailingAnchor.constraint(equalTo: dummyView.leadingAnchor, constant: -10).isActive = true
        cardetailView.bottomAnchor.constraint(equalTo: carModelView.bottomAnchor, constant: 0).isActive = true
        
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        let image = UIImage(named: (self.carModel?.value)!)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cardetailView.addSubview(imageView)
        
        imageView.bottomAnchor.constraint(equalTo: cardetailView.bottomAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: cardetailView.trailingAnchor, constant: 0).isActive = true
        
         let carlabel = UILabel()
        carlabel.text = self.carModel?.title//"Honda City"
         carlabel.backgroundColor = .clear
         carlabel.frame = imageView.frame
         carlabel.font = UIFont.systemFont(ofSize: Common.dynamicFontSize(13), weight: UIFont.Weight.semibold)
         carlabel.textColor = .darkGray
         carlabel.textAlignment = .center
         carlabel.translatesAutoresizingMaskIntoConstraints = false
         cardetailView.addSubview(carlabel)
         
        carlabel.topAnchor.constraint(equalTo: cardetailView.bottomAnchor, constant: -7).isActive = true
        carlabel.trailingAnchor.constraint(equalTo: cardetailView.trailingAnchor, constant: -35).isActive = true
              
        
        
        let bookButton = UIButton()
        bookButton.backgroundColor = .clear
        let btnImage = UIImage(named: LocalizationKey.img_book_service.string)
        bookButton.setBackgroundImage(btnImage, for: .normal)
        bookButton.imageView?.contentMode = .scaleAspectFit
        bookButton.frame = CGRect(x: 0, y: 0, width: btnImage!.size.width, height: btnImage!.size.height)
        bookButton.addTarget(self, action: #selector(bookServiceTapped), for: UIControl.Event.touchUpInside)
        bookButton.translatesAutoresizingMaskIntoConstraints = false
        self.carModelView.addSubview(bookButton)
        
        bookButton.bottomAnchor.constraint(equalTo: carModelView.bottomAnchor, constant: 0).isActive = true
        bookButton.leadingAnchor.constraint(equalTo: dummyView.trailingAnchor, constant: 10).isActive = true
        //bookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    
    }

    // method to add car statistics in stackview
    func carInfoPortionView()  {
        
        var item = 0
        for infoItem in carInfoList {
            let contView = getCarInfoView(infoItem)
            if(item <= 2) {
                carInfoSubView1.addArrangedSubview(contView)
            } else {
                carInfoSubView2.addArrangedSubview(contView)
            }
            item+=1
        }
        carInfoView.addArrangedSubview(carInfoSubView1)
        carInfoView.addArrangedSubview(carInfoSubView2)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundColor
        //self.navigationItem.title = "Home"
        
        // Create left button for navigation item
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: LocalizationKey.img_menu.string), style: .plain, target: self, action: #selector(menuButtonClicked))
        
        // Create  buttons for the navigation item.
        self.navigationItem.leftBarButtonItem = leftButton
        
        // Create right button for navigation item
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: LocalizationKey.img_notification.string), style: .plain, target: self, action: #selector(notificationButtonClicked))
        
        // Create  buttons for the navigation item.
        self.navigationItem.rightBarButtonItem = rightButton
        
        /*let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)*/
        
        addUI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        drawUI()
    }
    
    // Method to add various UI component on View/Scroll View
    func addUI() {
        
        self.view.addSubview(self.scrollView)
        
        // TODO: - remove it if data is coming from service or local db
        // added to select random values to show different cars, its info and service status from dummy data
        let randomCar = Int.random(in: 0..<3)
        let randomStats = Int.random(in: 0..<3)
        let randomService = true//Bool.random()
        let randomSerStat = Int.random(in: 0..<4)
        
        //carModel = carInfoItem(title: "Honda City", value: "honda_car")
        let carData = CarAPI.getCarData()
        carModel = carInfoItem(title: carData[randomCar].carName, value: carData[randomCar].carImage)
        
        /*carInfoList.append(carInfoItem(title: "KM Driven", value: "14765"))
        carInfoList.append(carInfoItem(title: "Fuel Level", value: "45 L"))
        carInfoList.append(carInfoItem(title: "Tyre Thread", value: "2 mm"))
        carInfoList.append(carInfoItem(title: "Engine Health", value: "Good"))
        carInfoList.append(carInfoItem(title: "Oil Level", value: "2.6L / 3L"))
        carInfoList.append(carInfoItem(title: "Battery Life", value: "Bad"))*/
        
        // getting car statistics from dummy data. It should be replaced if data is coming from service or local db
        let carStats = StatsAPI.getStatsData()
        carInfoList.append(carInfoItem(title: LocalizationKey.km_driven_str.string, value: carStats[randomStats].kmDriven))
        carInfoList.append(carInfoItem(title: LocalizationKey.fuel_level_str.string, value: carStats[randomStats].fuelLevel))
        carInfoList.append(carInfoItem(title: LocalizationKey.tyre_thread_str.string, value: carStats[randomStats].tyreThread))
        carInfoList.append(carInfoItem(title: LocalizationKey.engine_health_str.string, value: carStats[randomStats].engineHealth))
        carInfoList.append(carInfoItem(title: LocalizationKey.oil_level_str.string, value: carStats[randomStats].oilLevel))
        carInfoList.append(carInfoItem(title: LocalizationKey.battery_life_str.string, value: carStats[randomStats].batteryLife))
        
        // TODO:-
        self.upperPortionView()
        self.scrollView.addSubview(self.carModelView)
        
        self.scrollView.addSubview(self.lineView1)
        
        self.carInfoPortionView()
        self.scrollView.addSubview(self.carInfoView)
        
        self.scrollView.addSubview(self.lineView2)
        
        // if vehicle is in servicing or not
        if(randomService) {
            
            self.servicingStatusView.serviceStatus = .active_servicing
            
            var serviceStatus: Array<ServiceStatusItem> = []
            /*serviceStatus.append(ServiceStatusItem(serviceItemTitle: "Oil Change", serviceItemImage: "service_oil", serviceItemStatus: .completed_servicing, serviceItemTime: "(10:30 am)"))
            serviceStatus.append(ServiceStatusItem(serviceItemTitle: "Brake Oil", serviceItemImage: "service_break_oil", serviceItemStatus: .completed_servicing, serviceItemTime: "(11:30 am)"))
            serviceStatus.append(ServiceStatusItem(serviceItemTitle: "Oil Filter", serviceItemImage: "service_filter", serviceItemStatus: .in_progress_servicing, serviceItemTime: "(12:10 pm)"))
            serviceStatus.append(ServiceStatusItem(serviceItemTitle: "Battery Check", serviceItemImage: "service_battery", serviceItemStatus: .not_started_servicing, serviceItemTime: "(01:00 pm)"))*/
            
            let serStats = ServiceStatusAPI.getServiceStatus()
            
            serviceStatus.append(ServiceStatusItem(serviceItemTitle: LocalizationKey.oil_change_str.string, serviceItemImage: LocalizationKey.img_service_oil.string, serviceItemStatus: serStats[randomSerStat].oilChange, serviceItemTime: serStats[randomSerStat].oilChangeTime))
            serviceStatus.append(ServiceStatusItem(serviceItemTitle: LocalizationKey.brake_oil_str.string, serviceItemImage: LocalizationKey.img_service_break_oil.string, serviceItemStatus: serStats[randomSerStat].brakeOil, serviceItemTime: serStats[randomSerStat].brakeOilTime))
            serviceStatus.append(ServiceStatusItem(serviceItemTitle: LocalizationKey.oil_filter_str.string, serviceItemImage: LocalizationKey.img_service_filer.string, serviceItemStatus: serStats[randomSerStat].filterChange, serviceItemTime: serStats[randomSerStat].filterChangeTime))
            serviceStatus.append(ServiceStatusItem(serviceItemTitle: LocalizationKey.battery_check_str.string, serviceItemImage: LocalizationKey.img_service_battery.string, serviceItemStatus: serStats[randomSerStat].batteryCheck, serviceItemTime: serStats[randomSerStat].batteryCheckTime))
            
            self.servicingStatusView.serviceItems = serviceStatus
        } else {
            
            self.servicingStatusView.serviceStatus = .no_active_servicing
            
        }
        self.servicingStatusView.showCombindStatus()
        self.scrollView.addSubview(self.servicingStatusView)

    }
    
    
    // Method to draw UI on screen based on device type and orientation
    func drawUI() {
        
        //setup scroll view
         
         self.scrollView.frame = self.view.frame
        
        let guide = self.view.safeAreaLayoutGuide
        
         self.scrollView.removeConstraints(self.scrollView.constraints)
         self.scrollView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
         self.scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0).isActive = true
         self.scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant:  0).isActive = true
         self.scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0).isActive = true
        
        //self.carModelView.removeConstraints(self.upperPortionView.constraints)
        carModelView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 10).isActive = true
        carModelView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0).isActive = true
        carModelView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        carModelView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        lineView1.topAnchor.constraint(equalTo: carModelView.bottomAnchor, constant: 25).isActive = true
        lineView1.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 10).isActive = true
        lineView1.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -10).isActive = true
        lineView1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        carInfoView.topAnchor.constraint(equalTo: self.carModelView.bottomAnchor, constant: 20).isActive = true
        carInfoView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        carInfoView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        let viewsDictionary = ["stackView":carInfoView]
        let stackView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[stackView]-10-|",  //horizontal constraint 10 points from left and right side
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        self.scrollView.addConstraints(stackView_H)
        
        var val: CGFloat = 0.0
        if(Common.isPhone()) {
            val = 12
        } else if(!Common.isPhone() && Common.isPotrait()) {
            val = 8
        }
        
        lineView2.topAnchor.constraint(equalTo: carInfoView.bottomAnchor, constant: 50-val).isActive = true
        lineView2.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 10).isActive = true
        lineView2.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -10).isActive = true
        lineView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        servicingStatusView.topAnchor.constraint(equalTo: self.lineView2.bottomAnchor, constant: 10).isActive = true
        servicingStatusView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 5).isActive = true
        servicingStatusView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -5).isActive = true
        servicingStatusView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        servicingStatusView.reloadData()
        
        
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        
        val = 0.0
        if(Common.isPhone() && !Common.isPotrait()) {
            val = 70.0
        }
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: (contentRect.size.height+val))
    }
    
    
    /// Method to handle click on menu button (left navigation)
    @objc private func menuButtonClicked() {
        
        let notAlreadyExpanded = (self.currentState != .leftPanelExpanded)
        if notAlreadyExpanded {
            self.addLeftPanelViewController()
        }
        self.animateLeftPanel(shouldExpand: notAlreadyExpanded)
        
    }
    
    
    /// Method to handle click on notification button (right navigation)
    // as of now it is behaving as logout button
    @objc private func notificationButtonClicked() {
        
        self.showAlert(title: LocalizationKey.alert_title_confirmation.string, message: LocalizationKey.logout_conf_str.string, actionTitle: LocalizationKey.alert_yes.string, secondTitle: LocalizationKey.alert_no.string, completion: { (success,val) -> Void in
            if success {
                if(val == 0) { // yes, go back
                    
                    Common.logOutResetValue()
                    let loginVC =  self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")as! LoginViewController
                    UIApplication.shared.windows.first?.rootViewController = loginVC
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    
                } else if (val == 1) { // no
                   // do if anything is required
                }
            }})
    }
    
    
    /// Method to handle click on book service button
    @objc private func bookServiceTapped() {
        // TODO: - Need to implement book service module
    }
    
    
    /// Method which notifies the container that the size of its view is about to change.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in

        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
                self.drawUI()
        })
        super.viewWillTransition(to: size, with: coordinator)

    }
    
    
    // Method to add left panel
    func addLeftPanelViewController() {
        /*guard leftViewController == nil else { return }

      if let vc = self.leftSidePanelViewController() {
        vc.menuItems = MenuItem.allMenuItems()
        addChildSidePanelController(vc)
        leftViewController = vc
      }*/
    }
    
    
    // Method to animate left panel
    func animateLeftPanel(shouldExpand: Bool) {
      if shouldExpand {
        currentState = .leftPanelExpanded
        animateCenterPanelXPosition(
            targetPosition: self.view.frame.width - centerPanelExpandedOffset)
      } else {
        animateCenterPanelXPosition(targetPosition: 0) { _ in
            self.currentState = .collapsed
          self.leftViewController?.view.removeFromSuperview()
          self.leftViewController = nil
        }
      }
    }
    
    
    // Method to animate
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
      UIView.animate(withDuration: 0.5,
                     delay: 0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 0,
                     options: .curveEaseInOut, animations: {
                       //self.centerNavigationController.view.frame.origin.x = targetPosition
                        self.view.frame.origin.x = targetPosition
      }, completion: completion)
    }
    
    
    // Method to show opacity when side menu is open
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
      if shouldShowShadow {
        self.view.layer.shadowOpacity = 0.8
      } else {
        self.view.layer.shadowOpacity = 0.0
      }
    }
    
    // Method to add child side panel
    func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
      /*sidePanelController.delegate = self
      view.insertSubview(sidePanelController.view, at: 0)
      addChild(sidePanelController)
      sidePanelController.didMove(toParent: self)*/
    }
    
    
    func leftSidePanelViewController() -> SidePanelViewController? {
        return self.storyboard?.instantiateViewController(withIdentifier: "SideVC")as? SidePanelViewController
    }
    
    // MARK:- Gesture recognizer
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch recognizer.state {
        case .began:
            if currentState == .collapsed {
                if gestureIsDraggingFromLeftToRight {
                    addLeftPanelViewController()
                    showShadowForCenterViewController(true)
                }
                
            }
            
        case .changed:
            if gestureIsDraggingFromLeftToRight || currentState == .leftPanelExpanded {
            if let rview = recognizer.view {
                rview.center.x = rview.center.x + recognizer.translation(in: view).x
                recognizer.setTranslation(CGPoint.zero, in: view)
                }
            }
            
        case .ended:
            if let _ = leftViewController,
                let rview = recognizer.view {
                // animate the side panel open or closed based on whether the view
                // has moved more or less than halfway
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
            
        default:
            break
        }
    }
    
    // MARK:- SidePanelViewControllerDelegate delegate Method
    func didSelectMenuItem(_ item: MenuItem) {
           //
       }
    
    // MARK:-
}
