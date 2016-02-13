//
//  ViewController.swift
//  Truelinc
//
//  Created by Charlie Molina on 14/01/16.
//  Copyright (c) 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {

    var logIngViewController: PFLogInViewController! = PFLogInViewController()
    var singUpViewController: PFSignUpViewController! = PFSignUpViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if  PFUser.currentUser() != nil {

          self.performSegueWithIdentifier("loginSegue", sender: self)
            

    
        }
        
  
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if(PFUser.currentUser() == nil){
        
            
           self.logIngViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten, .DismissButton]
            
            let logInlogoTitle = UILabel()
            logInlogoTitle.text = "Truelinc"
            
            self.logIngViewController.logInView?.logo = logInlogoTitle
            self.logIngViewController.delegate = self
            
            let signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "Truelinc";
            self.singUpViewController.signUpView?.logo = signUpLogoTitle
            self.singUpViewController.delegate = self
            
            self.logIngViewController.signUpController = self.singUpViewController   
        }
    }

    //MARK: Log in parse
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if(!username.isEmpty || !password.isEmpty){
            return true
        }else{
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Failed Login")
    }
    
    //MARk:  Parse sign up
    
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
                    print("failed  sing up")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("user dismssed sing up")
    }
    
    
    //MARK: Actions
    
//    @IBAction func loginAction (sender: AnyObject){
//        self.presentViewController(self.logIngViewController, animated: true, completion: nil)
//    }
//    
//    
//    @IBAction func signupAction (sender: AnyObject){
//        self.performSegueWithIdentifier("loginSegue", sender: self)
//    }
    
    @IBAction func logoutAction (sender: AnyObject){
        PFUser.logOut()
    }
    
}

