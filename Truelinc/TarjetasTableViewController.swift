//
//  TarjetasTableViewController.swift
//  Truelinc
//
//  Created by Charlie Molina on 21/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TarjetasTableViewController: PFQueryTableViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    
    
    
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Tarjetas")
        query.cachePolicy = .CacheElseNetwork
        query.orderByDescending("Empresa")
        return query
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! BaseTarjetasViewCell
        
        cell.nombre.text = object?.objectForKey("Nombre") as? String
        cell.empresa.text = object?.objectForKey("Empresa") as? String
        cell.cargo.text = object?.objectForKey("Cargo") as? String
        

       let imageLogo = object?.objectForKey("LogoEmpresa") as? PFFile
        cell.logo.image = UIImage(named: "noLogo")
        cell.logo.file = imageLogo
        cell.logo.loadInBackground()
        
        let imagePerfil = object?.objectForKey("Foto") as? PFFile
        cell.perfil.image = UIImage(named: "noLogo")
        cell.perfil.file = imagePerfil
        cell.perfil.loadInBackground()

        return cell
    
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row + 1 > self.objects?.count
        {
            return 44
        }
        
        let height = super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        return height
    }
    
    
 override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row + 1  > self.objects?.count
        {
            self.loadNextPage()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        }else
        {
            self.performSegueWithIdentifier("showDetail", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"
        {
            let indexPath = self.tableView.indexPathForSelectedRow
            let detailVC = segue.destinationViewController as! PreviewTarjetaViewController
            let object = self.objectAtIndexPath(indexPath)
            
            
            detailVC.empresaStr = object?.objectForKey("Empresa") as! String
            detailVC.cargoStr = object?.objectForKey("Cargo") as! String
            detailVC.imgFoto = object?.objectForKey("Foto") as! PFFile
            detailVC.imgLogo = object?.objectForKey("LogoEmpresa") as! PFFile
            
            self.tableView.deselectRowAtIndexPath(indexPath!, animated: true)
            
         }
    }
    
}
