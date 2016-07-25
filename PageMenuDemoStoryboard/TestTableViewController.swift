//
//  TestTableViewController.swift
//  NFTopMenuController
//
//  Created by Niklas Fahl on 12/17/14.
//  Copyright (c) 2014 Niklas Fahl. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    
    var namesArray : [String] = ["Adom TV", "TV Africa", "TV 3", "GTV Sports TV", "ZTV", "GTV", "Cine Plus TV", "EUro News TV", "France 24 TV", "Kedu TV", "UTV", "Emanuel TV", "RTV"]
    var photoNameArray : [String] = ["Adom.png","TV Africa.png", "TV 3.png", "GTV Sports.png", "ZTV.png", "GTV Sports.png","Cine Plus.png","EUro News_1.png","france 24.png","Kedu TV.png","UTV", "Emanuel.png", "RTV.png"]
     var index : Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let destination = DetailViewController() // Your destination
//        navigationController?.pushViewController(destination, animated: true)
//        index = indexPath.row
//
//        
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let url : NSURL?
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 1:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 2:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 3:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 4:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 5:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 6:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 7:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 8:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 9:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 10:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            case 11:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            default:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
                return;
            }
            default:
                url = NSURL(string: "http://www.sportsgolive.com/adom-tv/")
            return;
        }
        
        if url != nil{
            UIApplication.sharedApplication().openURL(url!)
        }
    
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 13
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : FriendTableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendTableViewCell") as! FriendTableViewCell

        // Configure the cell...
        cell.nameLabel.text = namesArray[indexPath.row]
        cell.photoImageView.image = UIImage(named: photoNameArray[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.0

    }
}