//
//  TarjetaViewController.swift
//  Truelinc
//
//  Created by Juan Diaz on 27/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse

class TarjetaViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var Scroll: UIScrollView!
    @IBOutlet weak var lb_nombre: UITextView!
    @IBOutlet weak var lb_empresa: UILabel!
    @IBOutlet weak var lb_cargo: UILabel!
    @IBOutlet weak var lb_telefono: UITextView!
    @IBOutlet weak var lb_correo: UITextView!
    @IBOutlet weak var tv_twit: UITextView!
    @IBOutlet weak var lb_direccion: UILabel!
    @IBOutlet weak var lb_ubicacion: UILabel!
    @IBOutlet weak var img_foto: UIImageView!
    @IBOutlet weak var img_logo: UIImageView!
    @IBOutlet weak var img_qr: UIImageView!
    @IBOutlet weak var btn_fb: UIButton!
    @IBOutlet weak var btn_tw: UIButton!
    @IBOutlet weak var btn_www: UIButton!
    @IBOutlet weak var btnAddDelete: UIButton!
    
    
    @IBOutlet weak var constraintDtw: NSLayoutConstraint!
    @IBOutlet weak var contraintWtw: NSLayoutConstraint!
    
    @IBOutlet weak var constraintDfb: NSLayoutConstraint!
    @IBOutlet weak var contraintWfb: NSLayoutConstraint!
    
    @IBOutlet weak var constraintDwww: NSLayoutConstraint!
    @IBOutlet weak var contraintWwww: NSLayoutConstraint!
    
    
    
    
    
    
    var linkFacebook = ""
    var linkTwiter = ""
    var linkWWW = ""
    var tarjetaesmia: Bool = false
    var objectId = ""
    
    var viaSegueFoto = UIImage()
    var viaSegueLogo = UIImage()
    var viaSegueTarjeta = PFObject(className: "Tarjeta")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        img_foto.image = viaSegueFoto
        img_logo.image = viaSegueLogo
        
        if (!viaSegueTarjeta.isEqual(nil)){
            objectId = viaSegueTarjeta.objectId!
            
            
            
            if(viaSegueTarjeta.object(forKey: "Qr") != nil){
                (viaSegueTarjeta.object(forKey: "Qr") as AnyObject).getDataInBackground(block: { (imageData: Data?, error) in
                    if error == nil {
                        let image = UIImage(data: imageData!)
                        self.img_qr.image = image
                    
                    }else{
                        print("error",error)
                    }
                })
                }else{
                    let image = UIImage(named: "no_logo.png")// cambiar la imagen
                    self.img_qr.image = image
                }
            
            if (viaSegueTarjeta.object(forKey: "Nombre") != nil ){
                lb_nombre.text = (viaSegueTarjeta.object(forKey: "Nombre") as AnyObject).capitalized}
            else{lb_nombre.text = ""}
            
            if (viaSegueTarjeta.object(forKey: "Email") != nil ){
                lb_correo.text = viaSegueTarjeta.object(forKey: "Email") as! String}
            else{lb_correo.text = ""}
            
            if (viaSegueTarjeta.object(forKey: "Empresa") != nil ){
                lb_empresa.text = ((viaSegueTarjeta.object(forKey: "Empresa") as AnyObject).capitalized)}
            else{lb_empresa.text = ""}
            
            if (viaSegueTarjeta.object(forKey: "Cargo") != nil ){
                lb_cargo.text = (viaSegueTarjeta.object(forKey: "Cargo") as AnyObject).capitalized}
            else{lb_cargo.text = ""}
            
            if (viaSegueTarjeta.object(forKey: "Telefono") != nil ){
                lb_telefono.text = viaSegueTarjeta.object(forKey: "Telefono") as! String}
            else{lb_telefono.text = ""}
            
            if (viaSegueTarjeta.object(forKey: "Twit") != nil ){
                tv_twit.text = viaSegueTarjeta.object(forKey: "Twit") as! String}
            else{tv_twit.text = ""}
            
            if (viaSegueTarjeta.object(forKey: "Direccion") != nil ){
                lb_direccion.text = viaSegueTarjeta.object(forKey: "Direccion") as? String}
            else{lb_direccion.text = ""}
            
            if (viaSegueTarjeta.object(forKey: "Ciudad") != nil ){
                lb_ubicacion.text = viaSegueTarjeta.object(forKey: "Ciudad") as? String}
            else{lb_ubicacion.text = ""}
            
            if (viaSegueTarjeta.object(forKey: "facebook") != nil ){
                self.linkFacebook = viaSegueTarjeta.object(forKey: "facebook") as! String
                if(self.linkFacebook == ""){self.deleteContraintFB()}
            }
            else{self.deleteContraintFB()}
            if (viaSegueTarjeta.object(forKey: "twiter") != nil ){
                self.linkTwiter = viaSegueTarjeta.object(forKey: "twiter") as! String
                if(self.linkTwiter == ""){self.deleteContraintTW()}
            }
            else{self.deleteContraintTW()}
            if (viaSegueTarjeta.object(forKey: "www") != nil){
                self.linkWWW = viaSegueTarjeta.object(forKey: "www") as! String
                if(self.linkWWW == ""){self.deleteContraintWWW()}
            }
            else{self.deleteContraintWWW()}
            
            
            
        }
        
        
        img_logo.layer.cornerRadius = img_logo.frame.size.width/2
        img_logo.clipsToBounds = true
        
        self.Scroll.backgroundColor = UIColor(patternImage: UIImage(named: "city.jpg")!)
        
        
        // Do any additional setup after loading the view.
        
        // inicializar le botton de agregar o eliminar
        
        if(tarjetaesmia){
            self.btnAddDelete.setTitle("Eliminar", for: UIControlState())
            self.btnAddDelete.setTitleColor(UIColor.red, for: UIControlState())
        }else{
            self.btnAddDelete.setTitle("Agregar", for: UIControlState())
            self.btnAddDelete.setTitleColor(UIColor.green, for: UIControlState())
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueQR" {
            if let destination = segue.destination as? QrViewController{
                if(self.img_qr.image != nil){
                    destination.viaSegueQrFull = self.img_qr.image!
                }
                //                else{
                //                destination.viaSegueQrFull = UIImage(named: "indi.png")!
                //                }
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func clickEventFacebook(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: self.linkFacebook )!)
    }
    
    @IBAction func clickEventTwiter(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: self.linkTwiter )!)
    }
    
    @IBAction func clickEventWWW(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: self.linkWWW )!)
    }
    
    @IBAction func botonAddEliminar(_ sender: AnyObject) {
        
        if (self.tarjetaesmia){
            // lamar la funcion eliminar: Eliminar el objectId del array, subirlo a la base de datos. recargar la base local y devoverse a la anterior ventana
            
            let refreshAlert = UIAlertController(title: "Seguro", message: "¿Desea eliminar la tarjeta?.", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Si", style: .default, handler: { (action: UIAlertAction!) in
                self.btnAddDelete.setTitle("Agregar", for: UIControlState())
                self.btnAddDelete.setTitleColor(UIColor.green, for: UIControlState())
                self.tarjetaesmia = false
                self.eliminarTarjeta()
                print("Handle Ok logic here")
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }else{
            
            // agregar la tarjeta
            self.AfregarTarjeta()
            self.btnAddDelete.setTitle("Eliminar", for: UIControlState())
            self.btnAddDelete.setTitleColor(UIColor.red, for: UIControlState())
            self.tarjetaesmia = true
            
        }
        
    }
    
    
    // elminar tarjeta
    
    func eliminarTarjeta(){
        let tarjeta = [self.objectId]
        PFUser.current()?.removeObjects(in: tarjeta, forKey: "tarjetas")
        do{
            try PFUser.current()?.save()
        } catch {
            print("error Save")
        }
        navigationController?.popViewController(animated: true)
        
        
    }
    func AfregarTarjeta(){
        let tarjeta = self.objectId
        PFUser.current()?.add(tarjeta, forKey: "tarjetas")
        do{
            try PFUser.current()?.save()
        } catch {
            print("error Save")
        }
        self.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "inicioViewControler") as! SWRevealViewController
        self.present(vc, animated: true, completion: nil)
        
        
        
    }
    
    //funcions contrain
    
    func deleteContraintFB(){
        self.constraintDfb.constant = 0
        self.contraintWfb.constant = 0
        self.btn_fb.isHidden = true
    }
    func deleteContraintTW(){
        self.constraintDtw.constant = 0
        self.contraintWtw.constant = 0
        self.btn_tw.isHidden = true
    }
    func deleteContraintWWW(){
        self.constraintDwww.constant = 0
        self.contraintWwww.constant = 0
        self.btn_www.isHidden = true
    }
    
    
}


