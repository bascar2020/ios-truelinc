//
//  LoginViewController.swift
//  Truelinc
//
//  Created by Charlie Molina on 20/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse



class SignupViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordTwoField: UITextField!
    
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        self.passwordTwoField.delegate = self
        
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
        

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    
    
    
    @IBAction func signupAction(sender: AnyObject) {
    
        let username = self.usernameField.text
        let password = self.passwordField.text!
        let passwordTwo = self.passwordTwoField.text!
        
        
        if(password.utf16.elementsEqual(passwordTwo.utf16)){
        
            if(username?.utf16.count < 4 || password.utf16.count < 5){
                let alert = UIAlertView(title: "Invalido", message: "El usuario debe ser mayor a 4 y la contraseña mayor a 5", delegate: self, cancelButtonTitle: "OK")
            
                alert.show()
                }else{
        
                    self.actInd.startAnimating()
                
                let newUser = PFUser();
                newUser.username = username
                newUser.password = password
                
                newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                    self.actInd.stopAnimating()
                    
                    if((error) != nil){
                        let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }else{
                        let alert = UIAlertView(title: "Exito", message: "Usuario Creado con exito", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        self.performSegueWithIdentifier("tarjetaSegueDos", sender: self);
                    }
                })
                }
            
        }else{
            let alert = UIAlertView(title: "Invalido", message: "las contraseñas deben ser iguales", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    
    
}
