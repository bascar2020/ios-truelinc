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




class SignupViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordTwoField: UITextField!
    
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 150,height: 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        self.passwordTwoField.delegate = self
        
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(self.actInd)
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SignupViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(SignupViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    func keyboardWillShow(_ sender: Notification) {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height

        
        switch screenHeight {
            
        case 480.0 :
            if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= 212}
        case 568.0 :
            if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= 135}
        case 667.0 :
            if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= 80}
        case 736.0 :
            if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= 40}
        default :
            self.view.frame.origin.y -= 100
            
            
        }
        
    }
    func keyboardWillHide(_ sender: Notification) {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height

        
        switch screenHeight {
            
        case 480.0 :
            if(self.view.frame.origin.y == -212){
                self.view.frame.origin.y += 212}
        case 568.0 :
            if(self.view.frame.origin.y == -135){
                self.view.frame.origin.y += 135}
        case 667.0 :
            if(self.view.frame.origin.y == -80){
                self.view.frame.origin.y += 80}
        case 736.0 :
            if(self.view.frame.origin.y == -40){
                self.view.frame.origin.y += 40}
        default :
            self.view.frame.origin.y += 100
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        
    }
    
    
    
    
    
    @IBAction func signupAction(_ sender: AnyObject) {
    
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
                
                newUser.signUpInBackground(block: { (succeed, error) -> Void in
                    self.actInd.stopAnimating()
                    
                    if((error) != nil){
                        let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }else{
                        let alert = UIAlertView(title: "Exito", message: "Usuario Creado con exito", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        self.performSegue(withIdentifier: "tarjetaSegueDos", sender: self);
                    }
                })
                }
            
        }else{
            let alert = UIAlertView(title: "Invalido", message: "las contraseñas deben ser iguales", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    
    
}
