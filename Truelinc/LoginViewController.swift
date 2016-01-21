//
//  LoginViewController.swift
//  Truelinc
//
//  Created by Charlie Molina on 20/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse



class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func loginAction(sender: AnyObject) {
        
       
        let username = self.usernameField.text
        let password = self.passwordField.text!
        
        if(username?.utf16.count < 4 || password.utf16.count < 5){
            let alert = UIAlertView(title: "Invalido", message: "El usuario debe ser mayor a 4 y la contraseña mayor a 5", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        }else{
            self.actInd.startAnimating()
            
                PFUser.logInWithUsernameInBackground(username!, password: password, block: { (user, error) -> Void in
                    
                    self.actInd.stopAnimating()
                    
                    if((user) != nil){
                    let alert = UIAlertView(title: "Succses", message: "logged IN", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }else{
                        let alert = UIAlertView(title: "Failed", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }
                    
                })
            
            }
        
    }
    
    
    
}


