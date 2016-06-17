//
//  DetailsViewController.swift
//  Flix
//
//  Created by Nancy Xu on 6/17/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import RateView

class DetailsViewController: UIViewController {
    
    /* -------- OUTLETS -------- */
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    /* -------- VARIABLES -------- */
    var name: String?
    var date: String?
    var rating: Int?
    var overview: String?
    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.tintColor = UIColor.whiteColor()
        movieTitle.text = name!
        releaseDate.text = date!
        overviewText.text = overview!
        movieImage.setImageWithURL(url!)
        var ratingView: RateView?
        ratingView = RateView.init(rating: Float(rating!) / 2)
        ratingView?.frame = CGRectMake(5, 30, 60, 10)
        ratingView?.starFillColor = UIColor(red: 0.5647, green: 0.7412, blue: 0.9294, alpha: 1.0)
        ratingView?.starSize = 22
        ratingView?.starBorderColor = UIColor.whiteColor()
        ratingView?.frame.origin.x = 195
        ratingView?.frame.origin.y = 300
        contentView.addSubview(ratingView!)
        contentView.bringSubviewToFront(ratingView!)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(name, forKey: "name")
        defaults.setObject(date, forKey: "date")
        defaults.setObject(overview, forKey: "overview")
        defaults.setInteger(rating!, forKey: "rating")
        defaults.setURL(url, forKey: "url")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backAction(sender: AnyObject) {
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
