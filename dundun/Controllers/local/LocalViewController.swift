//
//  LocalViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/25.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class LocalViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    var searchControler: UISearchController!
    
    let coreLocation = CLLocationManager()
    
    let mapSearch = AMapSearchAPI()
    var searchPage = 1
    
    var datas: [LocalModel] = []
    
    // 没有数据了
    var isLast = false
    
    var location: CLLocationCoordinate2D? = nil
    
    var keyWords = ""
    
    override func initView() {
        initTitleView()
        initSearchBarView()
        tableView.separatorStyle = .None
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.withBack(MColor.backgroundColor).addTo(view).frame = view.frame
        
        definesPresentationContext = true
        
        searchControler = UISearchController(searchResultsController: nil)
        searchControler.searchBar.barTintColor = MColor.backgroundColor
        searchControler.searchBar.searchBarStyle = .Minimal
        searchControler.searchBar.placeholder = "搜索"
        searchControler.searchResultsUpdater = self
        searchControler.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchControler.searchBar
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        
        mapSearch.delegate = self
        
        tableView.registerClass(LocalTableViewCell.classForCoder(), forCellReuseIdentifier: "local")
        
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
                coreLocation.requestWhenInUseAuthorization()
            } else {
                coreLocation.desiredAccuracy = kCLLocationAccuracyHundredMeters
                coreLocation.delegate = self
            }
        } else {
            Notify.show(Murmur: "定位没有打开", theme: NotiTheme.Warring)
        }
    }
    
    func setAround(location: CLLocationCoordinate2D) {
        if self.location == nil {
            searchPage = 1
            self.location = location
            aroundSearch(CGFloat(location.latitude), longitude: CGFloat(location.longitude))
        }
    }
}

extension LocalViewController {
    
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
        if sender.selectedSegmentIndex == 0 {
            coreLocation.startUpdatingLocation()
            // 本地检索
            keyWords = ""
        } else {
            // 全国检索
            searchPage = 1
            location = nil
            keyWords = ""
            localSearch()
        }
    }
    
    func onSearch() {
        showViewController(UISearchController(), sender: nil)
    }
    
}

extension LocalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ShopViewController.show(self, pid: datas[indexPath.row].shopID)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count == 0 ? 1 : datas.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return datas.count == 0 ? view.frame.height : 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if datas.count == 0 {
            let cell = NoneTableViewCell()
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("local") as! LocalTableViewCell
        cell.setData(datas[indexPath.row].name, logo: datas[indexPath.row].logo, desc: datas[indexPath.row].info, dest: Float(datas[indexPath.row].dist))
        return cell
    }
    
    func reloadData() {
        let footView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        tableView.tableFooterView = footView
        
        let footButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        footView.addSubview(footButton)
        if isLast {
            let title = NSAttributedString(string: "--- 没有更多了 ---", attributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: 16)!, NSForegroundColorAttributeName: MColor.textPlacholderColor])
            footButton.setAttributedTitle(title, forState: .Normal)
        } else {
            let title = NSAttributedString(string: "--- 点击加载更多 ---", attributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: 16)!, NSForegroundColorAttributeName: MColor.textPlacholderColor])
            footButton.setAttributedTitle(title, forState: .Normal)
            footButton.backgroundColor = UIColor.whiteColor()
            footButton.withAction(self, selector: #selector(addMore))
        }
        tableView.reloadData()
    }
    
    func addMore(sender: UIButton) {
        sender.enabled = false
        let title = NSAttributedString(string: "--- 数据加载中... ---", attributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: 16)!, NSForegroundColorAttributeName: MColor.textPlacholderColor])
        sender.setAttributedTitle(title, forState: .Normal)
        if keyWords.characters.count > 0 {
            return barSearch()
        }
        if location == nil {
            localSearch()
        } else {
            aroundSearch(CGFloat(location!.latitude), longitude: CGFloat(location!.longitude))
        }
    }
}
//AMapLocationManager
// MARK: - IOS定位 -
extension LocalViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        Notify.show(Murmur: "定位没有打开", theme: NotiTheme.Warring)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        setAround(locations[0].coordinate)
        coreLocation.stopUpdatingLocation()
    }
    
}

// MARK: - AMAP高德地图云检索 -
extension LocalViewController: AMapSearchDelegate {
    
    func localSearch() {
        // 本地检索的请求参数对象为 AMapCloudPOILocalSearchRequest ，其中：keywords 和 city 参数为必填参数，当 city 传入 "全国" 时，表示在全表进行检索。
        if searchPage == 1 {
            datas = []
        }
        let amapRequest = AMapCloudPOILocalSearchRequest()
        amapRequest.tableID = "573189be7bbf197be3270f37"
        amapRequest.keywords = ""
        amapRequest.city = "全国"
        
        amapRequest.page = searchPage
        mapSearch.AMapCloudPOILocalSearch(amapRequest)
        searchPage += 1
    }
    
    func aroundSearch(lat: CGFloat, longitude: CGFloat) {
        // 周边检索的请求参数对象为 AMapCloudPOIAroundSearchRequest ，其中：center 参数为必填参数。
        if searchPage == 1 {
            datas = []
        }
        let amapRequest = AMapCloudPOIAroundSearchRequest()
        amapRequest.tableID = "573189be7bbf197be3270f37"
        amapRequest.center = AMapGeoPoint.locationWithLatitude(lat, longitude: longitude)
        
        amapRequest.page = searchPage
        mapSearch.AMapCloudPOIAroundSearch(amapRequest)
        searchPage += 1
    }
    
    func onCloudSearchDone(request: AMapCloudSearchBaseRequest!, response: AMapCloudPOISearchResponse!) {
        datas += response.POIs.map({ ( item) -> LocalModel in
            let poi = item as! AMapCloudPOI
            return LocalModel(shopID: poi.customFields["shopID"] as! Int, name: poi.name, info: poi.address, logo: poi.customFields["logo"] as! String, dist: poi.distance)
        })
        isLast = datas.count == response.count
        reloadData()
    }
}

extension LocalViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let keyWords = searchController.searchBar.text {
            self.keyWords = keyWords
            if keyWords.characters.count > 0 {
                searchPage = 1
                location = nil
                barSearch()
            }
        }
    }
    
    // 搜索检索
    func barSearch() {
        // 本地检索的请求参数对象为 AMapCloudPOILocalSearchRequest ，其中：keywords 和 city 参数为必填参数，当 city 传入 "全国" 时，表示在全表进行检索。
        if searchPage == 1 {
            datas = []
        }
        let amapRequest = AMapCloudPOILocalSearchRequest()
        amapRequest.tableID = "573189be7bbf197be3270f37"
        amapRequest.keywords = keyWords
        amapRequest.city = "全国"
        
        amapRequest.page = searchPage
        mapSearch.AMapCloudPOILocalSearch(amapRequest)
        searchPage += 1
    }
}

struct LocalModel {
    var shopID: Int
    var name: String
    var info: String
    var logo: String
    var dist: Int
}