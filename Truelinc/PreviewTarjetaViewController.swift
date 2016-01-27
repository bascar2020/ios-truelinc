//
//  PreviewTarjetaViewController.swift
//  Truelinc
//
//  Created by Charlie Molina on 21/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse


class PreviewTarjetaViewController: UIViewController {

    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var empresa: UILabel!
    @IBOutlet weak var cargo: UILabel!
    @IBOutlet weak var telefono: UILabel!
    @IBOutlet weak var correo: UILabel!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    var imgFoto: PFFile!
    var imgLogo: PFFile!
    var empresaStr: String!
    var cargoStr: String!
    var telefonoStr: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        
        
    self.imgFoto.getDataInBackgroundWithBlock { (imageData, error) -> Void in
        
            if(error != nil)
            {
                if let imageData = imageData
                {
                    let image = UIImage(data: imageData)
                    self.foto.image = image
                }
            }
        }
        
        
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
