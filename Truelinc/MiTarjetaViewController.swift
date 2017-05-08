//
//  MiTarjetaViewController.swift
//  Truelinc
//
//  Created by juan diaz on 4/04/17.
//  Copyright © 2017 Indibyte. All rights reserved.
//

import UIKit

class MiTarjetaViewController: UIViewController {

    @IBOutlet weak var abrir: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        abrir.target = self.revealViewController()
        abrir.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
