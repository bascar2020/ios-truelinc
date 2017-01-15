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
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        if  PFUser.currentUser() != nil {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewControllerWithIdentifier("inicioViewControler") as! SWRevealViewController
//            self.presentViewController(vc, animated: true, completion: nil)
//        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(PFUser.current() == nil){
        
            
           self.logIngViewController.fields = [.usernameAndPassword, .logInButton, .signUpButton, .passwordForgotten, .dismissButton]
            
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
    
    func log(_ logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if(!username.isEmpty || !password.isEmpty){
            return true
        }else{
            return false
        }
    }
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func log(_ logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Failed Login")
    }
    
    //MARk:  Parse sign up
    
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didFailToSignUpWithError error: Error?) {
            print("failed sing up")
    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        self.dismiss(animated: true, completion:nil)
    }
    
    func signUpViewControllerDidCancelSignUp(_ signUpController: PFSignUpViewController) {
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
    
    @IBAction func logoutAction (_ sender: AnyObject){
        PFUser.logOut()
    }
    
}

