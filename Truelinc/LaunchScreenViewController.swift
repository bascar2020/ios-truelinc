//
//  LaunchScreenViewController.swift
//  Truelinc
//
//  Created by Charlie Molina on 25/02/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

        if  PFUser.current() != nil {
            print("ENTRE usuario LOGIN")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "inicioViewControler") as! SWRevealViewController
            self.present(vc, animated: true, completion: nil)
        }else
        {
            print("ENTRE usuario blanco")
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: "inicioSegue", sender: self)
            }
        }

        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
