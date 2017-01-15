//
//  Camara.swift
//  Truelinc
//
//  Created by Juan Diaz on 26/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//
import UIKit
import Foundation
import QRCodeReader
import AVFoundation
import Parse

class Camara: UIViewController, QRCodeReaderViewControllerDelegate {
    
    
    @IBOutlet weak var abrir: UIBarButtonItem!
    
    override func viewDidLoad() {
            
            abrir.target = self.revealViewController()
            abrir.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.scanAction(self)
    }
    
 
    
    lazy var reader = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
        $0.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
        $0.showTorchButton = true
    })
    
    @IBAction func scanAction(_ sender: AnyObject) {
        if QRCodeReader.supportsMetadataObjectTypes() {
            reader.modalPresentationStyle = .formSheet
            reader.delegate               = self
            
            reader.completionBlock = { (result: QRCodeReaderResult?) in
                if let result = result {
                    print("Completion with result: \(result.value) of type \(result.metadataType)")
                }
            }
            
            present(reader, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - QRCodeReader Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
      
        
        //verificar conexion
        if Reachability.isConnectedToNetwork() == true {
            
            let split = result.value.components(separatedBy: ":")
            if(split[0]=="truelinc"){
                
                //obtener tarjeta parse
                let query = PFQuery(className: "Tarjetas")
                query.whereKey("objectId", equalTo: split[1])
                
                //findObjectsInBackground { (tarjetas:[PFObject]?, error: NSError?) -> Void in
                query.findObjectsInBackground { (tarjetas, error) in
                    if error == nil {
                        
                        PFUser.current()?.add(split[1], forKey: "tarjetas")
                        
                        do{
                            try PFUser.current()?.save()
                        } catch {
                            print("error Save")
                        }
                            //cambiar
                        self.dismiss(animated: true, completion: nil)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "inicioViewControler") as! SWRevealViewController
                        self.present(vc, animated: true, completion: nil)
                       
                        

                    }else{
                        self.dismiss(animated: true, completion: { [weak self] in
                            let alert = UIAlertController(
                                title: "Tenemos un problema!",
                                message: ":( Trabajamos para mejorar esto! Disculpa :)",
                                preferredStyle: .alert
                            )
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel){(action) in
                                self!.dismiss(animated: true, completion: nil)
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "inicioViewControler") as! SWRevealViewController
                                self!.present(vc, animated: true, completion: nil)
                                })
                            
                            self?.present(alert, animated: true, completion: nil)
                            })
                        
                    }
                    }
                
                
            }else{
                self.dismiss(animated: true, completion: { [weak self] in
                    let alert = UIAlertController(
                        title: "Tenemos un problema!",
                        message: "El codigo QR no es valido!",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel){(action) in
                        self!.dismiss(animated: true, completion: nil)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "inicioViewControler") as! SWRevealViewController
                        self!.present(vc, animated: true, completion: nil)
                        })
                    
                    self?.present(alert, animated: true, completion: nil)
                    })
            }
        }else{
            self.dismiss(animated: true, completion: { [weak self] in
                let alert = UIAlertController(
                    title: "Tenemos un problema!",
                    message: "No tienes conexión a internet",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .cancel){(action) in
                    self!.dismiss(animated: true, completion: nil)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "inicioViewControler") as! SWRevealViewController
                    self!.present(vc, animated: true, completion: nil)
                    })
                
                self?.present(alert, animated: true, completion: nil)
                })
        }
        
       
        
    }
    
    /**
     Tells the delegate that the camera was switched by the user
     
     - parameter reader: A code reader object informing the delegate about the scan result.
     - parameter newCaptureDevice: The capture device that was switched to
     */
    public func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        self.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "inicioViewControler") as! SWRevealViewController
        self.present(vc, animated: false, completion: nil)
        
    }

    
}
