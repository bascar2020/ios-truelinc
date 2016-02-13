//
//  LoginViewController.swift
//  Truelinc
//
//  Created by Charlie Molina on 20/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse



class LoginViewController: UIViewController,  UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!


    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
        
        
      
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        
        return true
        
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        if  PFUser.currentUser() != nil {
            print("bandera entre a login")
            self.performSegueWithIdentifier("tarjetaSegue", sender: self)
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if(self.view.frame.origin.y == 0){
            
            self.view.frame.origin.y -= 180
            
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if(self.view.frame.origin.y == -180){
            
            self.view.frame.origin.y += 180
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
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
                        //                    let alert = UIAlertView(title: "Succses", message: "logged IN",       delegate: self, cancelButtonTitle: "OK")
                        //                        alert.show()
                        self.performSegueWithIdentifier("tarjetaSegue", sender: self)
                    }else{
                        let alert = UIAlertView(title: "Failed", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }
                    
                })
            
            }
        
    }
    
    
    
}


