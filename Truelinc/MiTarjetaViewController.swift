//
//  MiTarjetaViewController.swift
//  Truelinc
//
//  Created by juan diaz on 4/04/17.
//  Copyright © 2017 Indibyte. All rights reserved.
//

import UIKit
import Parse
import WSTagsField
import SwiftValidator
import MapKit

class MiTarjetaViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate, ValidationDelegate {
    
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
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var tagsView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var flagImage: String! = ""
    var tarjeta: PFObject? = nil
    fileprivate let tagsField = WSTagsField()
    
    let validator = Validator()
   
    //variables del mapa
    var geopoint:CLLocation!
    var zipCode: String! = ""
    var locationManager: CLLocationManager!
    var previusAddress: String!
    var geoCoder: CLGeocoder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        abrir.target = self.revealViewController()
        abrir.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Do any additional setup after loading the view.
        
        
        let tapGestureRecognizerFOTO = UITapGestureRecognizer(target: self, action: #selector(imageTappedFOTO(tapGestureRecognizer:)))
        let tapGestureRecognizerLOGO = UITapGestureRecognizer(target: self, action: #selector(imageTappedLOGO(tapGestureRecognizer:)))
        
        foto.isUserInteractionEnabled = true
        foto.addGestureRecognizer(tapGestureRecognizerFOTO)
        foto.clipsToBounds = true
        
        logo.isUserInteractionEnabled = true
        logo.addGestureRecognizer(tapGestureRecognizerLOGO)
        
        logo.layer.cornerRadius = logo.frame.size.width/2
        logo.clipsToBounds = true
        
        
        tagsField.frame = tagsView.bounds
        tagsView.addSubview(tagsField)
        
        tagsField.placeholder = "Enter a tag"
        
        tagsField.backgroundColor = .white
        tagsField.spaceBetweenTags = 10.0
////        tagsField.font = .systemFont(ofSize: 12.0)
//        tagsField.tintColor = .green
//        tagsField.textColor = .black
//        tagsField.fieldTextColor = .blue
//        tagsField.selectedColor = .black
//        tagsField.selectedTextColor = .red
//        tagsField.delimiter = ","
        textFieldEventss()
        
        //validar las tarjetas
        validator.registerField(self.tv_email, rules: [RequiredRule(),EmailRule(message: "correo no valido")])
        validator.registerField(self.tv_telefono, rules: [RequiredRule(), MinLengthRule(length: 10)])
        
        
        //obtener ubicacion
        glGetErrortionManager()
        
        
    }
    
    override func viewWillLayoutSubviews() {
        tagsField.frame = tagsView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let user:PFUser = PFUser.current()!
        
        
        
        if((user.object(forKey: "mi_tarjeta")) != nil){
            
            
            
            let query = PFUser.query()
            query!.includeKey("mi_tarjeta")
            query!.getObjectInBackground(withId: user.objectId!, block: { (objeto, error) in
                if error == nil {
                    self.tarjeta = objeto?.object(forKey: "mi_tarjeta") as! PFObject
                    
                    if (self.tarjeta?.object(forKey: "Nombre") != nil ){
                        self.tv_nombre.text = (self.tarjeta?.object(forKey: "Nombre") as AnyObject).capitalized}
                    else{self.tv_nombre.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "Email") != nil ){
                        self.tv_email.text = self.tarjeta?.object(forKey: "Email") as? String}
                    else{self.tv_email.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "Empresa") != nil ){
                        self.tv_empresa.text = ((self.tarjeta?.object(forKey: "Empresa") as AnyObject).capitalized)}
                    else{self.tv_empresa.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "Cargo") != nil ){
                        self.tv_cargo.text = (self.tarjeta?.object(forKey: "Cargo") as AnyObject).capitalized}
                    else{self.tv_cargo.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "Telefono") != nil ){
                        self.tv_telefono.text = self.tarjeta?.object(forKey: "Telefono") as? String}
                    else{self.tv_telefono.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "Twit") != nil ){
                        self.tv_tweet.text = self.tarjeta?.object(forKey: "Twit") as? String}
                    else{self.tv_tweet.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "Direccion") != nil ){
                        self.tv_direccion.text = self.tarjeta?.object(forKey: "Direccion") as? String}
                    else{self.tv_direccion.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "Ciudad") != nil ){
                        self.tv_ciudad.text = (self.tarjeta?.object(forKey: "Ciudad") as AnyObject).capitalized}
                    else{self.tv_ciudad.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "twiter") != nil ){
                        self.tv_urlTwitter.text = self.tarjeta?.object(forKey: "twiter") as? String}
                    else{self.tv_urlTwitter.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "facebook") != nil ){
                        self.tv_urlFacebook.text = self.tarjeta?.object(forKey: "facebook") as? String}
                    else{self.tv_urlFacebook.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "www") != nil ){
                        self.tv_urlPaginaWeb.text = self.tarjeta?.object(forKey: "www") as? String}
                    else{self.tv_urlPaginaWeb.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "tags") != nil ){
                        self.tarjeta?.mutableArrayValue(forKey: "tags").forEach({ (tag) in
                            self.tagsField.addTag((tag as? String)!)
                        })}
                    else{self.tv_urlPaginaWeb.text = ""}
                    
                    if (self.tarjeta?.object(forKey: "LogoEmpresa") != nil ){
                        
                        (self.tarjeta?.object(forKey: "LogoEmpresa") as AnyObject).getDataInBackground(block: { (imageData: Data?, error) in
                            if error == nil {
                                let image = UIImage(data: imageData!)
                                self.logo.image = image
                            }else{
                                print("error",error!)
                            }
                        })
                    }

                    if (self.tarjeta?.object(forKey: "Foto") != nil ){
                        
                        (self.tarjeta?.object(forKey: "Foto") as AnyObject).getDataInBackground(block: { (imageData: Data?, error) in
                            if error == nil {
                                let image = UIImage(data: imageData!)
                                self.foto.image = image
                            }else{
                                print("error",error!)
                            }
                        })
                    }

                    
                    
                }else{
                    let alert = UIAlertController(title: "Alert", message: "error al traer tarjeta", preferredStyle: UIAlertControllerStyle.alert)
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
    
    
    func imageTappedFOTO(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        flagImage = "foto"
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        
        present(controller,animated: true, completion: nil)
    }
    
    func imageTappedLOGO(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        flagImage = "logo"
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        
        present(controller,animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if(flagImage == "logo"){
                logo.contentMode = .scaleAspectFill
                logo.image = selectImage
            }
            if(flagImage == "foto"){
                foto.contentMode = .scaleAspectFill
                foto.image = selectImage
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        
        present(controller,animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        validator.validate(self)
    }
    
    func validationSuccessful() {
        // submit the form
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        if(self.tarjeta != nil){
            self.tarjeta?.setValue(self.tv_nombre.text, forKey: "Nombre")
            self.tarjeta?.setValue(self.tv_email.text, forKey: "Email")
            self.tarjeta?.setValue(self.tv_empresa.text, forKey: "Empresa")
            self.tarjeta?.setValue(self.tv_cargo.text, forKey: "Cargo")
            self.tarjeta?.setValue(self.tv_telefono.text, forKey: "Telefono")
            self.tarjeta?.setValue(self.tv_tweet.text, forKey: "Twit")
            self.tarjeta?.setValue(self.tv_direccion.text, forKey: "Direccion")
            self.tarjeta?.setValue(self.tv_ciudad.text, forKey: "Ciudad")
            self.tarjeta?.setValue(self.tv_urlTwitter.text, forKey: "twiter")
            self.tarjeta?.setValue(self.tv_urlFacebook.text, forKey: "facebook")
            self.tarjeta?.setValue(self.tv_urlPaginaWeb.text, forKey: "www")
            
            
        
            
        self.tarjeta?.saveInBackground(block: { (succes, err) in
            if(succes){
             alertController.dismiss(animated: true, completion: nil);
            }
        })
        }
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (field, _) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            
        }
    }

    // Location Manager helper stuff
    func glGetErrortionManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        geoCoder = CLGeocoder()
        self.mapView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.first!
        self.mapView.centerCoordinate = location.coordinate
        let reg = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
        self.mapView.setRegion(reg, animated: true)
        geoCode(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        geoCode(location: location)
    }
    
    
    
    func geoCode(location: CLLocation!){
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(data,error) in
            guard let placeMarks = data as [CLPlacemark]! else{
                return
            }
            let loc: CLPlacemark = placeMarks[0]
            //            let addresDisct: [NSString:NSObject] = loc.addressDictionary as! [NSString:NSObject]
            //            let addrList = addresDisct["FormattedAddressLines"] as! [String]
            //            let address =  addrList.joined(separator: ", ")
            var address =  loc.name!
            
            if let subcity =  loc.subAdministrativeArea {
                address += ". "+subcity
            }
            
            if let city =  loc.administrativeArea {
                address += ", "+city
            }
            
            if let zipTemp = loc.postalCode{
                self.zipCode = zipTemp
                address += ","+loc.isoCountryCode!+" "+zipTemp
            }else{
                self.zipCode = "0"
            }
            
            
            self.previusAddress = address
            self.geopoint = loc.location
        })
    }

    
}

extension MiTarjetaViewController {
    fileprivate func textFieldEventss() {
        tagsField.onDidAddTag = { _ in
//            print("DidAddTag")
        }
        
        tagsField.onDidRemoveTag = { _ in
//            print("DidRemoveTag")
        }
        
        tagsField.onDidChangeText = { _, text in
//            print("onDidChangeText")
        }
        
        tagsField.onDidBeginEditing = { _ in
//            print("DidBeginEditing")
        }
        
        tagsField.onDidEndEditing = { _ in
//            print("DidEndEditing")
        }
        
        tagsField.onDidChangeHeightTo = { _, height in
//            print("HeightTo \(height)")
        }
        
        tagsField.onDidSelectTagView = { _, tagView in
//            print("Select \(tagView)")
        }
        
        tagsField.onDidUnselectTagView = { _, tagView in
//            print("Unselect \(tagView)")
        }
    }
}
