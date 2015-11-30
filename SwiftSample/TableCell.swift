//
//  TableCell.swift
//  SwiftSample
//
//  Created by SIVASANKAR DEVABATHINI on 11/13/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell, SearchAPIProtocol {
    let dataManagerObj = DataManager()
    
    func setUpCell(urlString: String){
        dataManagerObj.delegate = self
        dataManagerObj.searchAPIFor(urlString)
    }
    
    func didReceiveResults(dataObj: NSData){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.imageView?.image = UIImage(data: dataObj)
            self.setNeedsLayout()
            });
        
    }
}
