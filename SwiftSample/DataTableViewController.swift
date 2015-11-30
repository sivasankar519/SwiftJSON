//
//  DataTableViewController.swift
//  
//
//  Created by SIVASANKAR DEVABATHINI on 11/12/15.
//
//

import UIKit

class DataTableViewController: UITableViewController, SearchAPIProtocol {
    
    var tableData : NSArray = []
    var searchString:String!
    let dataManagerObj = DataManager()
    var imageCache = [String:UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = searchString
        searchString = searchString.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        let urlPath = "http://itunes.apple.com/search?term=\(searchString)&limit=50"
        dataManagerObj.delegate = self
        
        dataManagerObj.searchAPIFor(urlPath)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didReceiveResults(dataObj: NSData) {
        
        do {
            let jsonResults = try NSJSONSerialization.JSONObjectWithData(dataObj, options: []) as? NSDictionary
            
            // use jsonResults here
            
            if let results: NSArray = jsonResults!["results"] as? NSArray {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableData = results
                    self.tableView!.reloadData()
                })
                
            }
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: TableCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableCell
        
        cell.textLabel?.text = self.tableData[indexPath.row]["trackName"] as? String
        cell.detailTextLabel?.text = self.tableData[indexPath.row]["artistName"] as? String
        cell.setUpCell((self.tableData[indexPath.row]["artworkUrl60"] as? String)!)
        
        return cell
    }
}
