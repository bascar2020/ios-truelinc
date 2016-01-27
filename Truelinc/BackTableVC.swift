//
//  BackTableVC.swift
//  Truelinc
//
//  Created by Juan Diaz on 25/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController{

    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Mis Tarjetas","Buscador","Camara","Log Out"]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        
        cell.textLabel?.text = TableArray [indexPath.row]
        
        return cell
        
    }
}