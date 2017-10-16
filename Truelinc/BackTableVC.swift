//
//  BackTableVC.swift
//  Truelinc
//
//  Created by Juan Diaz on 25/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import Foundation
import Parse

class BackTableVC: UITableViewController{

    var TableArray = [String]()
    @IBOutlet var tableMenu: UITableView!
    
    
    override func viewDidLoad() {
        TableArray = ["Mis Tarjetas","Mi Perfil","Buscador","Escanear Qr","Log Out"]
        self.tableMenu.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        
        cell.textLabel?.text = TableArray [indexPath.row]
        
        return cell
        
    }
    

    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
                //print(indexPath.row)
                if (indexPath.row == 4){
                    PFUser.logOut()
                    self.performSegue(withIdentifier: "segueLogOut", sender: self)
                    
                    }

        return indexPath
    }
    
}   
