//
//  MoviesViewController.swift
//  Flix
//
//  Created by Nancy Xu on 6/15/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import RateView

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    /* ------ OUTLETS ------ */
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var gestureView: UIView!
    @IBOutlet weak var savedButton: UIBarButtonItem!
    
    /* ------ GLOBAL VARS ------ */
    // Array of dictionarys, with each dictionary corresponding to a movie
    var movies: [NSDictionary]?
    var refreshControl: UIRefreshControl?
    var showResults: [Int] = []
    
    /* ------ VIEW CONTROLLER FUNCTIONS ------ */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize search bar
        searchBar.delegate = self
        savedButton.tintColor = UIColor.whiteColor()

        // Initialize a UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(loadData(_:)), forControlEvents: UIControlEvents.ValueChanged)
        movieTableView.insertSubview(refreshControl!, atIndex: 0)
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        print("Reached b")
        loadData(true)
        print("Reached a")
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func loadData(initial: Bool) {
        print("load start")
        let apiKey = "59b1d112f52c2b668627198c51f733b8"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        
        // ... Create the NSURLRequest (myRequest) ...
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        if (initial) { MBProgressHUD.showHUDAddedTo(self.view, animated: true) }
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in if let data = dataOrNil {
            
            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                data, options:[]) as? NSDictionary {
                //print("response: \(responseDictionary)")
                self.movies = responseDictionary["results"] as? [NSDictionary]
                // print(self.movies)
                self.movieTableView.reloadData()}
            }
            
            // Hide HUD once the network request comes back (must be done on main UI thread)
            if (initial) {
                self.showResults = []
                for index in 0...(self.movies!.count-1) {
                    self.showResults.append(index)
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
            
            // Reload the tableView now that there is new data
            self.movieTableView.reloadData()
            
            // Tell the refreshControl to stop spinning
            self.refreshControl!.endRefreshing()
        });
        task.resume()
        print("load end")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /* ------ TABLEVIEW DATA SOURCE FUNCTIONS ------ */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(showResults.count)
        return showResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movie = movies![showResults[indexPath.row]]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let imageUrl = NSURL(string: baseUrl + posterPath)
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterImage.setImageWithURL(imageUrl!)
        
        // first create UIImageView
        var image : UIImageView
        image  = UIImageView(frame:CGRectMake(0, 0, 40, 150))
        image.image = UIImage(named:"arrow")
        
        // then set it as cellAccessoryType
        //cell.accessoryView = image
        print("getting a cell")
        return cell
    }
    
    /* ------ SEARCH BAR DELEGATE FUNCTIONS ------ */
    // This method updates filteredData based on the text in the Search Box
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("reached search")
        // When there is no text, filteredData is the same as the original data
        showResults = []
        if searchText.isEmpty {
            for index in 0...(movies!.count - 1) {
                showResults.append(index)
            }
        } else {
            for index in 0...(movies!.count - 1) {
                if movies![index].objectForKey("original_title")!.rangeOfString(searchText, options: .CaseInsensitiveSearch).location != NSNotFound {
                    showResults.append(index)
                }
            }
        }
        movieTableView.reloadData()
        gestureView.hidden = false
    }
    
    /* ------ GESTURE FUNCTIONS ------ */
    
    
    @IBAction func tapDisappear(sender: AnyObject) {
        view.endEditing(true)
        gestureView.hidden = true
    }
    
    /* ------- SEGUE ------ */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! DetailsViewController
        if (segue.identifier == "saved") {
            let defaults = NSUserDefaults.standardUserDefaults()
            vc.date = defaults.objectForKey("date") as! String
            vc.rating = defaults.integerForKey("rating")
            vc.name = defaults.objectForKey("name") as! String
            vc.overview = defaults.objectForKey("overview") as! String
            vc.url = defaults.URLForKey("url")
            
        } else {
            let indexPath = movieTableView.indexPathForCell(sender as! MovieCell)
            let movie = movies![showResults[indexPath!.row]]
            vc.date = movie["release_date"] as! String
            vc.rating = movie["vote_average"] as! Int
            vc.name = movie["title"] as! String
            vc.overview = movie["overview"] as! String
            let posterPath = movie["poster_path"] as! String
            let baseUrl = "http://image.tmdb.org/t/p/w500"
            vc.url = NSURL(string: baseUrl + posterPath)
        }
        
    }
}
