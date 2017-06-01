//
//  MiTarjetaViewController.swift
//  Truelinc
//
//  Created by juan diaz on 4/04/17.
//  Copyright © 2017 Indibyte. All rights reserved.
//

import UIKit
import Parse

class MiTarjetaViewController: UIViewController {
    
    @IBOutlet weak var abrir: UIBarButtonItem!
    
    @IBOutlet weak var tv_direccion: UITextField!
    @IBOutlet weak var tv_ciudad: UITextField!
    @IBOutlet weak var tv_urlFacebook: UITextField!
    @IBOutlet weak var tv_urlTwitter: UITextField!
    @IBOutlet weak var tv_urlPaginaWeb: UITextField!
    @IBOutlet weak var tv_tweet: UITextField!
    @IBOutlet weak var tv_email: UITextField!
    @IBOutlet weak var tv_telefono: UITextField!
    @IBOutlet weak var tv_cargo: UITextField!
    @IBOutlet weak var tv_empresa: UITextField!
    @IBOutlet weak var tv_nombre: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        abrir.target = self.revealViewController()
        abrir.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let user:PFUser = PFUser.current()!
        
        
        
        if((user.object(forKey: "mi_tarjeta")) != nil){
            
            
            
            let query = PFUser.query()
            query!.includeKey("mi_tarjeta")
            query!.getObjectInBackground(withId: user.objectId!, block: { (objeto, error) in
                if error == nil {
                    let tarjeta = objeto?.object(forKey: "mi_tarjeta") as! PFObject
                    
                    if (tarjeta.object(forKey: "Nombre") != nil ){
                        self.tv_nombre.text = (tarjeta.object(forKey: "Nombre") as AnyObject).capitalized}
                    else{self.tv_nombre.text = ""}
                    
                    if (tarjeta.object(forKey: "Email") != nil ){
                        self.tv_email.text = tarjeta.object(forKey: "Email") as! String}
                    else{self.tv_email.text = ""}
                    
                    if (tarjeta.object(forKey: "Empresa") != nil ){
                        self.tv_empresa.text = ((tarjeta.object(forKey: "Empresa") as AnyObject).capitalized)}
                    else{self.tv_empresa.text = ""}
                    
                    if (tarjeta.object(forKey: "Cargo") != nil ){
                        self.tv_cargo.text = (tarjeta.object(forKey: "Cargo") as AnyObject).capitalized}
                    else{self.tv_cargo.text = ""}
                    
                    if (tarjeta.object(forKey: "Telefono") != nil ){
                        self.tv_telefono.text = tarjeta.object(forKey: "Telefono") as! String}
                    else{self.tv_telefono.text = ""}
                    
                    if (tarjeta.object(forKey: "Twit") != nil ){
                        self.tv_tweet.text = tarjeta.object(forKey: "Twit") as! String}
                    else{self.tv_tweet.text = ""}
                    
                    if (tarjeta.object(forKey: "Direccion") != nil ){
                        self.tv_direccion.text = tarjeta.object(forKey: "Direccion") as? String}
                    else{self.tv_direccion.text = ""}
                    
                    if (tarjeta.object(forKey: "Ciudad") != nil ){
                        self.tv_ciudad.text = (tarjeta.object(forKey: "Ciudad") as AnyObject).capitalized}
                    else{self.tv_ciudad.text = ""}
                    
                    if (tarjeta.object(forKey: "twiter") != nil ){
                        self.tv_urlTwitter.text = tarjeta.object(forKey: "twiter") as! String}
                    else{self.tv_urlTwitter.text = ""}
                    
                    if (tarjeta.object(forKey: "facebook") != nil ){
                        self.tv_urlFacebook.text = tarjeta.object(forKey: "facebook") as! String}
                    else{self.tv_urlFacebook.text = ""}
                    
                    if (tarjeta.object(forKey: "www") != nil ){
                        self.tv_urlPaginaWeb.text = tarjeta.object(forKey: "www") as! String}
                    else{self.tv_urlPaginaWeb.text = ""}
                    
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "Alert", message: "error al traer mi tarjeta", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "click", style: UIAlertActionStyle.default, handler: nil))
                    // self.presentedViewController(alert, animated:true,completion:nil)
                }
            })
            
        }
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
