//
//  ViewController.swift
//  SwiftSample
//
//  Created by SIVASANKAR DEVABATHINI on 11/12/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var tableData: NSMutableArray = []
  
    let kCellIdentifier: String = "Cell"
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
    
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
       
        self.tableView .reloadData()
     
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        
        if segue.identifier == "DataTable" {
            self.view.endEditing(true)
            let viewController = segue.destinationViewController as! DataTableViewController
            
            if sender is UISearchBar{
                viewController.searchString = (sender as! UISearchBar).text
            }
            else{
                viewController.searchString = (sender as! UITableViewCell).textLabel?.text
            }
            
            tableData.removeObject(viewController.searchString)
            tableData.insertObject(viewController.searchString, atIndex: 0)
        }

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
       
        self.performSegueWithIdentifier("DataTable",sender: searchBar)
       
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier)!


        cell.textLabel?.text = tableData.objectAtIndex(indexPath.row) as? String
      
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
        // Background color
        view.tintColor = UIColor .whiteColor()

        
        // Text Color
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.textAlignment = NSTextAlignment.Center
        header.textLabel!.text = "Previous Searches"
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 35
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 50;
    }

}

