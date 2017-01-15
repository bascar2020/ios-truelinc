//
//  Mis_Tarjetas.swift
//  Truelinc
//
//  Created by Juan Diaz on 26/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class Mis_Tarjetas: UIViewController, UITableViewDelegate, UISearchResultsUpdating, SWRevealViewControllerDelegate{

    @IBOutlet weak var abrir: UIBarButtonItem!
    @IBOutlet weak var tableViewMisTarjetas: UITableView!

    
    var arrayObject = [PFObject]()
    var arrayObjectFilter = [PFObject]()
    var misTarjetas = [String]()


    var resultSearchBar = UISearchController()

    
    
    override func viewDidLoad() {


        self.tableViewMisTarjetas.tableFooterView = UIView(frame: CGRect.zero)
        
        let logo = UIImage(named: "logoT")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

        
        if self.revealViewController() != nil {
            abrir.target = self.revealViewController()
            abrir.action = #selector(SWRevealViewController.revealToggle(_:))
            self.revealViewController().delegate = self
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        
        // Configure searchBar
        self.resultSearchBar = ({
            // Two setups provided below:
            
            // Setup One: This setup present the results in the current view.
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
            self.tableViewMisTarjetas.tableHeaderView = controller.searchBar
            
            return controller
        })()
        self.tableViewMisTarjetas.tableHeaderView = self.resultSearchBar.searchBar
    
    }
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition)
    {
        if revealController.frontViewPosition == FrontViewPosition.left
        {
            self.view.isUserInteractionEnabled = false
        }
        else
        {
            self.view.isUserInteractionEnabled = true
        }
        
        
    }
    
    
// table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

        if self.resultSearchBar.isActive{
            return self.arrayObjectFilter.count
        }else{
            return arrayObject.count
        }
        

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        
        let singleCell: SingleTowCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! SingleTowCellTableViewCell

        if !self.resultSearchBar.isActive{
            singleCell.lb_empresa.text = (arrayObject[indexPath.row].object(forKey: "Empresa") as AnyObject).capitalized
            singleCell.lb_nombre.text = (arrayObject[indexPath.row].object(forKey: "Nombre") as AnyObject).capitalized
            singleCell.lb_cargo.text = (arrayObject[indexPath.row].object(forKey: "Cargo") as AnyObject).capitalized
            
            
            if(arrayObject[indexPath.row].object(forKey: "LogoEmpresa") != nil){
                
                (arrayObject[indexPath.row].object(forKey: "LogoEmpresa") as AnyObject).getDataInBackground(block: { (imageData: Data?, error) in
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
            
            if(arrayObject[indexPath.row].object(forKey: "Foto") != nil){
                (arrayObject[indexPath.row].object(forKey: "Foto") as AnyObject).getDataInBackground(block: { (imageData: Data?, error) in
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

        }else{
            
            singleCell.lb_empresa.text = (arrayObjectFilter[indexPath.row].object(forKey: "Empresa") as AnyObject).capitalized
            singleCell.lb_nombre.text = (arrayObjectFilter[indexPath.row].object(forKey: "Nombre") as AnyObject).capitalized
            singleCell.lb_cargo.text = (arrayObjectFilter[indexPath.row].object(forKey: "Cargo") as AnyObject).capitalized
        
        
            if(arrayObjectFilter[indexPath.row].object(forKey: "LogoEmpresa") != nil){

                (arrayObjectFilter[indexPath.row].object(forKey: "LogoEmpresa") as AnyObject).getDataInBackground(block: { (imageData: Data?, error) in
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
        
            if(arrayObjectFilter[indexPath.row].object(forKey: "Foto") != nil){
                (arrayObjectFilter[indexPath.row].object(forKey: "Foto") as AnyObject).getDataInBackground(block: { (imageData: Data?, error) in
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
            }
        
        return singleCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showCard", sender: indexPath)

    }

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if tableViewMisTarjetas.indexPathForSelectedRow != nil {
            tableViewMisTarjetas.deselectRow(at: tableViewMisTarjetas.indexPathForSelectedRow! , animated: false)
        }
        
        self.callTarjetasParseAndDrawTable()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCard"){
            
            if let destination = segue.destination as? TarjetaViewController{
                let path = tableViewMisTarjetas.indexPathForSelectedRow
                let cell = tableViewMisTarjetas.cellForRow(at: path!) as! SingleTowCellTableViewCell
                
                destination.tarjetaesmia = true // esta variable representa que el usuario sigue esta tarjeta
                destination.viaSegueTarjeta = arrayObject[path!.row]
                destination.viaSegueLogo = cell.img_logo.image!
                destination.viaSegueFoto = cell.img_foto.image!
                
            }
        }
        
    }
    
    
    func callTarjetasParseAndDrawTable(){
        
        // si la conexion a internet es buena actualiza las tarjetas
        if Reachability.isConnectedToNetwork() == true {
                do{
                    try PFUser.current()?.fetch()
                }catch{
                    print("Error al actualizar")
            }
        }

        
        if (nil != (PFUser.current()?.value(forKey: "tarjetas"))) {
            self.misTarjetas = (PFUser.current()?.value(forKey: "tarjetas")) as! [String]
        }

        
        // si las tarjetas que estan en el array son diferentes a las guardadas actualizar
        if (misTarjetas.count != arrayObject.count){
            arrayObject.removeAll()
            let query = PFQuery(className: "Tarjetas")
            query.whereKey("objectId", containedIn: self.misTarjetas)
            query.order(byAscending: "Empresa")
            
            if Reachability.isConnectedToNetwork() == true {
                print("Internet connection OK")
                do{
                    try PFObject.pinAll(inBackground: query.findObjects())
                } catch  {
                    print("error pin objects")
                }
            } else {
                query.fromLocalDatastore()
                print("Internet connection FAILED")
            }
            
            
            query.findObjectsInBackground { (tarjetas:[PFObject]?, error) in
                
                if error == nil {
                    for  tarjeta in tarjetas! {
                        self.arrayObject.append(tarjeta)
                    }}
                self.tableViewMisTarjetas.reloadData()
            }
            
        }
        else{
        //sin son iguales las tarjetas del array con los objetos solo recargue la tabla
                self.tableViewMisTarjetas.reloadData()
        }//end else

    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {

        self.arrayObjectFilter.removeAll(keepingCapacity: false)
        if searchController.searchBar.text?.characters.count > 0{
            
            for index in (0..<self.arrayObject.count).reversed(){
                let name = arrayObject[index].object(forKey: "Nombre") as! String
                let empresa = arrayObject[index].object(forKey: "Empresa") as! String
                let tags =  arrayObject[index].object(forKey: "tags") as! [String]
                
                if( name.lowercased().contains((searchController.searchBar.text?.lowercased())!) ||
                    empresa.lowercased().contains((searchController.searchBar.text?.lowercased())!) ||
                    self.isTaginArray((searchController.searchBar.text)!,array: tags)){
                    self.arrayObjectFilter.append(arrayObject[index])
                }
            }
            
            self.tableViewMisTarjetas.reloadData()
    
            
        }else{
        self.arrayObjectFilter = self.arrayObject
            self.tableViewMisTarjetas.reloadData()
        }
     
    }
    
    
    func isTaginArray(_ palabra:String, array: [String]) -> Bool{
        if array.isEmpty {
            return false
        }else{
            return array.contains(palabra.lowercased())
        }
        
    }
    
  
    
    

    
   
}

