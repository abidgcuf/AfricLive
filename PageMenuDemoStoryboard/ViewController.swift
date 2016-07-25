//
//  ViewController.swift
//  PageMenuDemoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController {
    
    var banner: GADBannerView!
    var interstitial: GADInterstitial!
    var pageMenu : CAPSPageMenu?
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - UI Setup
        
        self.title = "Afric Live"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let controller1 : TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
        controller1.title = "Live TV"
        controllerArray.append(controller1)
        let controller2 : NewsViewController = NewsViewController(nibName: "NewsViewController", bundle: nil)
        controller2.title = "Latest News"
        controllerArray.append(controller2)
        let controller3 : TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
        controller3.title = "Live Radio"
        controllerArray.append(controller3)
//        let controller4 : TestCollectionViewController = TestCollectionViewController(nibName: "TestCollectionViewController", bundle: nil)
//        controller3.title = "Latest Photos"
//        controllerArray.append(controller4)
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
            .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.orangeColor()),
            .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(90.0),
            .CenterMenuItems(true)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)

		self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
		
		pageMenu!.didMoveToParentViewController(self)
        
        loadbanner()
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                                      Int64(30 * Double(NSEC_PER_SEC)))
        
        //Creation of the ad and its request
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-2809593728729827/9830485397")
        let req = GADRequest()
        interstitial.loadRequest(req)
        dispatch_after(delayTime, dispatch_get_main_queue())
        {
            self.showAd()
        }
    }
    
    func showAd()
    {
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)//Whatever  shows the ad
        }
    }
    func didTapGoToLeft() {
        let currentIndex = pageMenu!.currentPageIndex
        
        if currentIndex > 0 {
            pageMenu!.moveToPage(currentIndex - 1)
        }
    }
    
    func didTapGoToRight() {
        let currentIndex = pageMenu!.currentPageIndex
        
        if currentIndex < pageMenu!.controllerArray.count {
            pageMenu!.moveToPage(currentIndex + 1)
        }
    }
	
	// MARK: - Container View Controller
	override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
		return true
	}
	
	override func shouldAutomaticallyForwardRotationMethods() -> Bool {
		return true
	}
    
    func loadbanner(){
        banner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        self.banner.adUnitID = "ca-app-pub-2809593728729827/3585601399"
        self.banner.rootViewController = self
        let requestad: GADRequest = GADRequest()
        self.banner.loadRequest(requestad)
        banner.frame = CGRectMake(0, view.bounds.height - banner.frame.size.height, banner.frame.size.width, banner.frame.size.height)
        self.view.addSubview(banner)
    }
    
}


