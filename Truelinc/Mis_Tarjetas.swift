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
    var misTarjetas = [String]()
    
    
    
    override func viewDidLoad() {
        
        
        let logo = UIImage(named: "logoT")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        

        
        
        
        abrir.target = self.revealViewController()
        abrir.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        //query parse
        
        //cargar las tarjetas del usuario
        
        
            
        self.misTarjetas = (PFUser.currentUser()?.mutableArrayValueForKey("tarjetas"))! as NSArray as! [String]
        let query = PFQuery(className: "Tarjetas")
        query.whereKey("objectId", containedIn: misTarjetas)
        query.orderByAscending("Empresa")
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            do{
              try PFObject.pinAllInBackground(query.findObjects())
            } catch  {
                print("error pin objects")
            }
            
            
        } else {
            query.fromLocalDatastore()
            print("Internet connection FAILED")
        }
        
        
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
        
        
        if(arrayObject[indexPath.row].objectForKey("LogoEmpresa") != nil){

            arrayObject[indexPath.row].objectForKey("LogoEmpresa")?.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    singleCell.img_logo.image = image
                }else{
                    print("error",error)
                }
        })
            
        }else{
            let image = UIImage(named: "nologo.png")
            singleCell.img_logo.image = image
        }
        
        if(arrayObject[indexPath.row].objectForKey("Foto") != nil){
            
            arrayObject[indexPath.row].objectForKey("Foto")?.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                
                    let image = UIImage(data: imageData!)
                    singleCell.img_foto.image = image
                
                }else{
                    print("error",error)
                }
            })
        }else{
            let image = UIImage(named: "no_perfil.png")
            singleCell.img_foto.image = image
        }
        
        return singleCell
    }
    

    
   
}

