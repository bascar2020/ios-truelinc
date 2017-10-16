//
//  Buscador.swift
//  Truelinc
//
//  Created by Juan Diaz on 26/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import Foundation
import Parse

enum selectorScope:Int {
    case cerca = 0
    case ciudad = 1
    case pais = 2
}

enum distanciaKm:Double {
    case cerca = 10.0
    case ciudad = 100.0
    case pais = 500.0
}


class Buscador : UIViewController, UITableViewDataSource, UISearchBarDelegate, SWRevealViewControllerDelegate {
    

    @IBOutlet weak var abrir: UIBarButtonItem!
    @IBOutlet weak var tableTarjetas: UITableView!
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    var resultFilter = [PFObject]()
    var cercaFilter = [PFObject]()
    var ciudadFilter = [PFObject]()
    var paisFilter = [PFObject]()
    var misTarjetas = [String]()
    
    override func viewDidLoad() {
        
        self.tableTarjetas.tableFooterView = UIView(frame: CGRect.zero)
        self.searchBarSetup()
        let logo = UIImage(named: "logoT")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        
        if (nil != (PFUser.current()?.value(forKey: "tarjetas"))) {
            self.misTarjetas = (PFUser.current()?.value(forKey: "tarjetas")) as! [String]
        }
        
        
        if self.revealViewController() != nil {
            abrir.target = self.revealViewController()
            abrir.action = #selector(SWRevealViewController.revealToggle(_:))
            self.revealViewController().delegate = self
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    func searchBarSetup(){
        mySearchBar.showsScopeBar = true
        mySearchBar.scopeButtonTitles = ["Cerca","Ciudad","Pais"]
        
        mySearchBar.delegate = self
        self.tableTarjetas.tableHeaderView = mySearchBar
    }
    
// MARK: - search bar delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        self.resultFilter.removeAll(keepingCapacity: false)
        switch searchBar.selectedScopeButtonIndex {
        case selectorScope.cerca.rawValue: //cerca
            self.resultFilter = self.cercaFilter
        case selectorScope.ciudad.rawValue: //Ciudad
            self.resultFilter = self.ciudadFilter
        case selectorScope.pais.rawValue: //Pais
            self.resultFilter = self.paisFilter
        default:
            self.resultFilter = self.cercaFilter
        }
        
        DispatchQueue.main.async{
            self.tableTarjetas.reloadData()
            self.mySearchBar.resignFirstResponder()
        }
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleCell: SingleTowCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! SingleTowCellTableViewCell
        
        
        if(resultFilter[indexPath.row].object(forKey: "Empresa") != nil){
            singleCell.lb_empresa.text = (resultFilter[indexPath.row].object(forKey: "Empresa") as AnyObject).capitalized}
        
        if(resultFilter[indexPath.row].object(forKey: "Nombre") != nil){
            singleCell.lb_nombre.text = (resultFilter[indexPath.row].object(forKey: "Nombre") as AnyObject).capitalized}

        if(resultFilter[indexPath.row].object(forKey: "Cargo") != nil){
                singleCell.lb_cargo.text = (resultFilter[indexPath.row].object(forKey: "Cargo") as AnyObject).capitalized}
        
        
        if(resultFilter[indexPath.row].object(forKey: "LogoEmpresa") != nil){
            
            (resultFilter[indexPath.row].object(forKey: "LogoEmpresa") as AnyObject).getDataInBackground(block: { (imageData: Data?, error) in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    singleCell.img_logo.image = image
                }else{
                   // print("error",error)
                }
            })
            
        }else{
            let image = UIImage(named: "nologo.png")
            singleCell.img_logo.image = image
        }
        
        if(resultFilter[indexPath.row].object(forKey: "Foto") != nil){
            (resultFilter[indexPath.row].object(forKey: "Foto") as AnyObject).getDataInBackground(block: { (imageData: Data?, error) in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    singleCell.img_foto.image = image
                    
                }else{
                  //  print("error",error)
                }
            })
        }else{
            let image = UIImage(named: "no_perfil.png")
            singleCell.img_foto.image = image
        }

        
        return singleCell
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.isEmpty)!{
            searchTarjetas(searchBar)
        }
        
    }
    
    func searchTarjetas(_ searchBar: UISearchBar) {
        if Reachability.isConnectedToNetwork() == true {
            mySearchBar.resignFirstResponder()
            
            var kilometers:Double
            switch searchBar.selectedScopeButtonIndex {
            case 0: //cerca
                kilometers = distanciaKm.cerca.rawValue
            case 1: //Ciudad
                kilometers = distanciaKm.ciudad.rawValue
            case 2: //Pais
                kilometers = distanciaKm.pais.rawValue
            default:
                kilometers = distanciaKm.cerca.rawValue
            }
            
            PFGeoPoint.geoPointForCurrentLocation(inBackground: { (geopoint, error) in
                if error != nil{
                    let myAlert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                }else{
                    print(geopoint)
                    let nombreQuery = PFQuery(className: "Tarjetas")
                    nombreQuery.whereKey("Privada", equalTo: false)
                    nombreQuery.whereKey("Nombre", contains: (searchBar.text!.lowercased()))
                    
                    let empresaQuery = PFQuery(className: "Tarjetas")
                    empresaQuery.whereKey("Privada", equalTo: false)
                    empresaQuery.whereKey("Empresa", contains: (searchBar.text!.lowercased()))
                    
                    let tagsQuery = PFQuery(className: "Tarjetas")
                    tagsQuery.whereKey("Privada", equalTo: false)
                    tagsQuery.whereKey("tags", containedIn: [searchBar.text!.lowercased()])
                    
                    
                    
                    if !self.misTarjetas.isEmpty {
                        nombreQuery.whereKey("objectId", notContainedIn: self.misTarjetas)
                        empresaQuery.whereKey("objectId", notContainedIn: self.misTarjetas)
                        tagsQuery.whereKey("objectId", notContainedIn: self.misTarjetas)
                        
                    }
                    
                    let query = PFQuery.orQuery(withSubqueries: [nombreQuery,empresaQuery,tagsQuery])
                    
                    
                    query.findObjectsInBackground { (results:[PFObject]?, error)  in
                        if error != nil {
                            let myAlert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                            
                            myAlert.addAction(okAction)
                            self.present(myAlert, animated: true, completion: nil)
                            
                            return
                        }else{
                            self.resultFilter.removeAll(keepingCapacity: false)
                            self.cercaFilter.removeAll()
                            self.ciudadFilter.removeAll()
                            self.paisFilter.removeAll()
                            for  tarjeta in results! {
                                
                                if((tarjeta.object(forKey: "GeoPoint") as! PFGeoPoint).distanceInKilometers(to: geopoint)<=kilometers){
                                    self.resultFilter.append(tarjeta)
                                }
                                
                                if((tarjeta.object(forKey: "GeoPoint") as! PFGeoPoint).distanceInKilometers(to: geopoint).isLess(than: distanciaKm.cerca.rawValue)){
                                    self.cercaFilter.append(tarjeta)
                                }
                                print((tarjeta.object(forKey: "GeoPoint") as! PFGeoPoint).distanceInKilometers(to: geopoint))
                                print(tarjeta.object(forKey: "GeoPoint") as! PFGeoPoint)
                                if((tarjeta.object(forKey: "GeoPoint") as! PFGeoPoint).distanceInKilometers(to: geopoint).isLess(than: distanciaKm.ciudad.rawValue)){
                                    self.ciudadFilter.append(tarjeta)
                                }
                                
                                if((tarjeta.object(forKey: "GeoPoint") as! PFGeoPoint).distanceInKilometers(to: geopoint).isLess(than: distanciaKm.pais.rawValue)){
                                    self.paisFilter.append(tarjeta)
                                }
                            }
                            DispatchQueue.main.async{
                                self.tableTarjetas.reloadData()
                                self.mySearchBar.resignFirstResponder()
                            }
                        }
                    }
                }
            })
            
            
            
            
        }else
        {
            let myAlert = UIAlertController(title: "Tenemos un Problema!", message: "Comprueba tu conexion y vuelve a intentarlo", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
        mySearchBar.text = ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showCardOnline", sender: indexPath)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCardOnline"){
            
            if let destination = segue.destination as? TarjetaViewController{
                let path = tableTarjetas.indexPathForSelectedRow
                let cell = tableTarjetas.cellForRow(at: path!) as! SingleTowCellTableViewCell
                
                destination.tarjetaesmia = false // esta variable representa que el usuario sigue esta tarjeta
                destination.viaSegueTarjeta = resultFilter[path!.row]
                destination.viaSegueLogo = cell.img_logo.image!
                destination.viaSegueFoto = cell.img_foto.image!
                
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if tableTarjetas.indexPathForSelectedRow != nil {
            tableTarjetas.deselectRow(at: tableTarjetas.indexPathForSelectedRow! , animated: false)
        }
        
    }



    
    
    
}
