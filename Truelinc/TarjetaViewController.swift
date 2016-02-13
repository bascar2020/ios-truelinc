//
//  TarjetaViewController.swift
//  Truelinc
//
//  Created by Juan Diaz on 27/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit

class TarjetaViewController: UIViewController {

    

    @IBOutlet weak var img_logo: UIImageView!
    @IBOutlet weak var Scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        
        img_logo.layer.cornerRadius = img_logo.frame.size.width/2
        img_logo.clipsToBounds = true
 
        self.Scroll.backgroundColor = UIColor(patternImage: UIImage(named: "city.jpg")!)
        
        
        // Do any additional setup after loading the view.



        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
