//
//  MenuViewController.swift
//  Truelinc
//
//  Created by Juan Diaz on 25/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

  

    @IBOutlet weak var Open: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
