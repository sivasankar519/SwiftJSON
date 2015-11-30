//
//  DataManager.swift
//  SwiftSample
//
//  Created by SIVASANKAR DEVABATHINI on 11/13/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

import Foundation

protocol SearchAPIProtocol {
    func didReceiveResults(dataObj: NSData)
    
}


class DataManager {
    var delegate: SearchAPIProtocol?
    
    func searchAPIFor(urlString: String) {

        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            if(error != nil) {
                
                print(error!.localizedDescription)
            }
            self.delegate?.didReceiveResults(data!)
           
        })
        task.resume()
    }
    
}