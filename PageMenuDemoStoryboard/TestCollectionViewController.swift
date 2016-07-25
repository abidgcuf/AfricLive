//
//  TestCollectionViewController.swift
//  NFTopMenuController
//
//  Created by Niklas Fahl on 12/17/14.
//  Copyright (c) 2014 Niklas Fahl. All rights reserved.
//

import UIKit

let reuseIdentifier = "MoodCollectionViewCell"

class TestCollectionViewController: UICollectionViewController {
     @IBOutlet var collectionview: UICollectionView!
    var images_cache = [String:UIImage]()
    var moodtitle = [String]()
    var images = [String]()
    let link = "http://www.kaleidosblog.com/tutorial/get_images.php"

    
//    var moodArray : [String] = ["Relaxed", "Playful", "Happy", "Adventurous", "Wealthy", "Hungry", "Loved", "Active"]
//    var backgroundPhotoNameArray : [String] = ["mood1.jpg", "mood2.jpg", "mood3.jpg", "mood4.jpg", "mood5.jpg", "mood6.jpg", "mood7.jpg", "mood8.jpg"]
//    var photoNameArray : [String] = ["relax.png", "playful.png", "happy.png", "adventurous.png", "wealthy.png", "hungry.png", "loved.png", "active.png"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.collectionView!.registerNib(UINib(nibName: "MoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        //#warning Incomplete method implementation -- Return the number of sections
//        return 1
//    }
//
//
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //#warning Incomplete method implementation -- Return the number of items in the section
//        return 8
//    }
//
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell : MoodCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MoodCollectionViewCell
//    
//        // Configure the cell
//        cell.backgroundImageView.image = UIImage(named: backgroundPhotoNameArray[indexPath.row])
//        cell.moodTitleLabel.text = moodArray[indexPath.row]
//        cell.moodIconImageView.image = UIImage(named: photoNameArray[indexPath.row])
//    
//        return cell
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerNib(UINib(nibName: "MoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        get_json()
        
        collectionview.delegate = self
        collectionview.dataSource = self
        refresh()
    }
    
    
    
    internal override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return images.count
    }
    
    
    internal override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell:MoodCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MoodCollectionViewCell", forIndexPath: indexPath) as! MoodCollectionViewCell
        
        if (images_cache[images[indexPath.row]] != nil)
        {
            cell.moodIconImageView.image = images_cache[images[indexPath.row]]
            // cell.moodTitleLabel.text = moodtitle[indexPath.row]
            cell.backgroundImageView.image = UIImage(named: "active.png")
        }
        else
        {
            load_image(images[indexPath.row], imageview:cell.moodIconImageView)
            cell.moodTitleLabel.text = "No Title"
        }
        
        return cell
    }
    
    
    internal override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    
  internal  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    let alertController = UIAlertController(title: "Discription", message:
        "\(images_cache[images[indexPath.row]])", preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "X", style: UIAlertActionStyle.Default,handler: nil))
    
    self.presentViewController(alertController, animated: true, completion: nil)
}
    
    
    func load_image(link:String, imageview:UIImageView)
    {
        
        let url:NSURL = NSURL(string: link)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.timeoutInterval = 10
        
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                
                return
            }
            
            
            var image = UIImage(data: data!)
            
            if (image != nil)
            {
                
                
                func set_image()
                {
                    self.images_cache[link] = image
                    imageview.image = image
                }
                
                
                dispatch_async(dispatch_get_main_queue(), set_image)
                
            }
            
        }
        
        task.resume()
        
    }
    
    
    
    
    func extract_json_data(data:NSString)
    {
        let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
        let json: AnyObject?
        
        do
        {
            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
        }
        catch
        {
            print("error")
            return
        }
        
        guard let images_array = json! as? NSArray else
        {
            print("error")
            return
        }
        
        for j in 0 ..< images_array.count
        {
            images.append(images_array[j] as! String)
        }
        
        dispatch_async(dispatch_get_main_queue(), refresh)
    }
    
    
    
    func refresh()
    {
        self.collectionview.reloadData()
    }
    
    
    func get_json()
    {
        
        let url:NSURL = NSURL(string: link)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.timeoutInterval = 10
        
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            self.extract_json_data(dataString!)
            
        }
        
        task.resume()
        
    }
    

}
