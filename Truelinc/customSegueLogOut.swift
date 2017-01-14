//
//  customSegueLogOut.swift
//  Truelinc
//
//  Created by Charlie Molina on 10/02/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse

class customSegueLogOut: UIStoryboardSegue {

    
    override func perform() {
        

        PFUser.logOut()
        
        let VCOrigen = self.source as UIViewController
        let VCDestination = self.destination as UIViewController
        
        VCOrigen.navigationController!.pushViewController(VCDestination, animated:false)
        

        
    }
    
}
