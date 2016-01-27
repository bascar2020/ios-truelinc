//
//  Mis_Tarjetas.swift
//  Truelinc
//
//  Created by Juan Diaz on 26/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Foundation

class Mis_Tarjetas: UIViewController {
    
    @IBOutlet weak var abrir: UIBarButtonItem!
    override func viewDidLoad() {

        abrir.target = self.revealViewController()
        abrir.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
}
}

