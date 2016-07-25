//
//  NewsViewController.swift
//  Afric Live
//
//  Created by Abid Ali on 7/22/16.
//  Copyright © 2016 CAPS. All rights reserved.
//

import UIKit
import GoogleMobileAds
class NewsViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet var webView:UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

     var interstitial: GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://africlive.tv/androidapps/adomtv/news/")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        webView.delegate = self
        // Do any additional setup after loading the view.
        
//        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
//                                      Int64(30 * Double(NSEC_PER_SEC)))
//        
//        //Creation of the ad and its request
//        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
//        let req = GADRequest()
//        interstitial.loadRequest(req)
//        dispatch_after(delayTime, dispatch_get_main_queue())
//        {
//            self.showAd()
//        }
    }
//    
//    func showAd()
//    {
//        if (self.interstitial.isReady)
//        {
//            self.interstitial.presentFromRootViewController(self)//Whatever  shows the ad
//        }
//    }
    
    func webViewDidStartLoad(webView: UIWebView)  {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView)  {
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doRefresh() {
        webView.reload()
    }
    @IBAction func goBack() {
        webView.goBack()
    }
    
    @IBAction func goForward() {
        webView.goForward()
    }
    @IBAction func stop() {
        webView.stopLoading()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
