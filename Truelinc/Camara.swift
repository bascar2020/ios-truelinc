//
//  Camara.swift
//  Truelinc
//
//  Created by Juan Diaz on 26/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import Foundation
class Camara: UIViewController {
    
    @IBOutlet weak var abrir: UIBarButtonItem!
    override func viewDidLoad() {
            
            abrir.target = self.revealViewController()
            abrir.action = Selector("revealToggle:")
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
}