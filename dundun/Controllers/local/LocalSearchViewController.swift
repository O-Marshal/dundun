//
//  LocalSearchViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/28.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class LocalSearchViewController: UISearchController {
    
    let tableView = UITableView()
    
    let coreLocation = CLLocationManager()
    
    let mapSearch = AMapSearchAPI()
    
    override func viewDidLoad() {
        initView()
        initEvent()
    }
    
    func initView() {
        initTitleView()
        initSearchBarView()
        
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.size.equalTo(view)
        }
        tableView.rowHeight = 100
        tableView.separatorInset = UIEdgeInsetsZero
    }
    
    func initEvent() {
        tableView.dataSource = self
        tableView.registerClass(LocalTableViewCell.classForCoder(), forCellReuseIdentifier: "local")
        
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
                coreLocation.requestWhenInUseAuthorization()
            } else {
                coreLocation.desiredAccuracy = kCLLocationAccuracyHundredMeters
                coreLocation.delegate = self
            }
        } else {
            Notify.show(Whisper: "定位没有打开", theme: NotiTheme.Warring, viewController: self)
        }
    }
    
}

extension LocalSearchViewController {
    
    func initTitleView() {
        let segemented = UISegmentedControl(items: ["附近商家", "所有店铺"])
        segemented.addTarget(self, action: #selector(onSegementedChange(_:)), forControlEvents: .ValueChanged)
        navigationItem.titleView = segemented
        segemented.selectedSegmentIndex = 0
        onSegementedChange(segemented)
    }
    
    func initSearchBarView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_search"), style: .Plain, target: self, action: #selector(onSearch))
        
    }
    
    func onSegementedChange(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        coreLocation.startUpdatingLocation()
        coreLocation.distanceFilter = 100
    }
    
    func onSearch() {
        showViewController(UISearchController(), sender: nil)
    }
    
}

extension LocalSearchViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("local") as! LocalTableViewCell
        return cell
    }
}
//AMapLocationManager
// MARK: - IOS定位 -
extension LocalSearchViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        Notify.show(Whisper: "定位没有打开", theme: NotiTheme.Warring, viewController: self)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0].coordinate)
        coreLocation.stopUpdatingLocation()
    }
    
}

// MARK: - AMAP高德地图云检索 -
extension LocalSearchViewController: AMapSearchDelegate {
    func initAmap() {
        mapSearch.delegate = self
        
        let amapRequest = AMapCloudPOILocalSearchRequest()
        amapRequest.tableID = "55aef614e4b0a8cc8c5c4978"
        amapRequest.keywords = ""
        amapRequest.city = "全国"
        
        mapSearch.AMapCloudPOILocalSearch(amapRequest)
        
    }
    
    func onCloudSearchDone(request: AMapCloudSearchBaseRequest!, response: AMapCloudPOISearchResponse!) {
        print(response.POIs[0].name!)
    }
}