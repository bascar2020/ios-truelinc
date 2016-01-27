//
//  Mis_Tarjetas.swift
//  Truelinc
//
//  Created by Juan Diaz on 26/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Foundation

class Mis_Tarjetas: UITableViewController {
 
    @IBOutlet weak var abrir: UIBarButtonItem!
    override func viewDidLoad() {
        
        
        abrir.target = self.revealViewController()
        
        abrir.action = Selector("revealToggle:")
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
}
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

