//
//  Mis_Tarjetas.swift
//  Truelinc
//
//  Created by Juan Diaz on 26/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse

class Mis_Tarjetas: UIViewController, UITableViewDelegate {
 
    @IBOutlet weak var abrir: UIBarButtonItem!
    @IBOutlet weak var tableViewMisTarjetas: UITableView!
    
    var arrayObject = [PFObject]()
    
    
    
    
    
    override func viewDidLoad() {
        abrir.target = self.revealViewController()
        abrir.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        //query parse
        let query = PFQuery(className: "Tarjetas")
        query.orderByAscending("Empresa")
        query.findObjectsInBackgroundWithBlock { (tarjetas:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                //Succes
                

                for  tarjeta in tarjetas! {
//                    print(tarjeta)
                    self.arrayObject.append(tarjeta)
                }

                self.tableViewMisTarjetas.reloadData()

            }else{
            print(error)
            }
            
        }
        
    
    }
    
    
// tabli view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayObject.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let singleCell: SingleTowCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! SingleTowCellTableViewCell

        singleCell.lb_empresa.text = arrayObject[indexPath.row].objectForKey("Empresa") as? String
        singleCell.lb_nombre.text = arrayObject[indexPath.row].objectForKey("Nombre") as? String
        singleCell.lb_cargo.text = arrayObject[indexPath.row].objectForKey("Cargo") as? String
        
        arrayObject[indexPath.row].objectForKey("LogoEmpresa")?.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
            if imageData != nil {
               let image = UIImage(data: imageData!)
                singleCell.img_logo.image = image
            }else{
                print("error",error)
            }
        })
        
        arrayObject[indexPath.row].objectForKey("Foto")?.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                print(imageData?.length)
                let image = UIImage(data: imageData!)
                singleCell.img_foto.image = image
            }else{
                print("error",error)
            }
        })
        
        return singleCell
    }
    

    
   
}

