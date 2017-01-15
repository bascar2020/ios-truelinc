//
//  LoginViewController.swift
//  Truelinc
//
//  Created by Charlie Molina on 20/01/16.
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




class LoginViewController: UIViewController,  UITextFieldDelegate  {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!


    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 150,height: 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(self.actInd)
        
    }

 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        
    }
    
    func keyboardWillShow(_ sender: Notification) {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height

        
        switch screenHeight {
        
        case 480.0 :
            if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= 150}
        case 568.0 :
            if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= 90}
        case 667.0 :
            if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= 40}
        case 736.0 :
            if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= 15}
        default :
            self.view.frame.origin.y -= 100
        }
    }
    
    func keyboardWillHide(_ sender: Notification) {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height

        
        switch screenHeight {
            
        case 480.0 :
            if(self.view.frame.origin.y == -150){
                self.view.frame.origin.y += 150}
        case 568.0 :
            if(self.view.frame.origin.y == -90){
                self.view.frame.origin.y += 90}
        case 667.0 :
            if(self.view.frame.origin.y == -40){
                self.view.frame.origin.y += 40}
        case 736.0 :
            if(self.view.frame.origin.y == -15){
                self.view.frame.origin.y += 15}
        default :
            self.view.frame.origin.y += 100
            
            
        }

        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        
    }
    
    
    
    @IBAction func loginAction(_ sender: AnyObject) {
        
       
        let username = self.usernameField.text
        let password = self.passwordField.text!
        
        if(username?.utf16.count < 4 || password.utf16.count < 5){
            let alert = UIAlertView(title: "Invalido", message: "El usuario debe ser mayor a 4 y la contraseña mayor a 5", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        }else{
            self.actInd.startAnimating()
            
                PFUser.logInWithUsername(inBackground: username!, password: password, block: { (user, error) -> Void in
                    
                    self.actInd.stopAnimating()
                    
                    if((user) != nil){
                        //                    let alert = UIAlertView(title: "Succses", message: "logged IN",       delegate: self, cancelButtonTitle: "OK")
                        //                        alert.show()
                        self.performSegue(withIdentifier: "tarjetaSegue", sender: self)
                    }else{
                        let alert = UIAlertView(title: "Failed", message: "Error Login", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }
                    
                })
            
            }
        
    }
    
    
    
}


