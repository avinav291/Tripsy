//
//  SignUpViewController.swift
//  Tripsy
//
//  Created by Avinav Goel on 19/02/16.
//  Copyright © 2016 Avinav Goel. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var firstNameField : UITextField!
    @IBOutlet weak var lastNameField : UITextField!
    @IBOutlet weak var userNameField : UITextField!
    @IBOutlet weak var mobileNumberField : UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let ref = Firebase(url: "https://tripsy.firebaseio.com")
    let userRef = Firebase(url: "https://tripsy.firebaseio.com/users")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUpAction(sender: AnyObject) {
        
//        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
//        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Validate the text fields
//        if username!.characters.count < 5 {
//            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//            
//        } else
            if password!.characters.count < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if email!.characters.count < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Please enter a valid email address", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            ref.createUser(email, password: password, withCompletionBlock: {
                (error) -> Void in
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    
                    
                    
                    self.ref.authUser(email, password: password, withCompletionBlock: {
                        (error, authData) -> Void in
                        if(error != nil){
                            let alert = UIAlertView(title: "Error", message: "Could not verify auth DAta", delegate: self, cancelButtonTitle: "OK")
                            alert.show()
                        }
                        else{
                            let users:[String:String] = ["emailId": self.emailField.text!, "firstName": self.firstNameField.text!, "lastName": self.lastNameField.text!, "userName": self.userNameField.text!, "phoneNumber":self.mobileNumberField.text!]
                            self.userRef.childByAppendingPath(authData.uid).setValue(users)
                            let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                            alert.show()
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("planTrip") as! PlanTripViewController
                                viewController.username = email!
                                
                                self.presentViewController(viewController, animated: true, completion: nil)
                                
                            })
                        }
                    })
                    
                }
            })
            
//            let newUser = PFUser()
//            
//            newUser.username = username
//            newUser.password = password
//            newUser.email = finalEmail
//            
//            // Sign up the user asynchronously
//            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
//                
//                // Stop the spinner
//                spinner.stopAnimating()
//                if ((error) != nil) {
//                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
//                    alert.show()
//                    
//                } else {
//                    let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
//                    alert.show()
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
//                        self.presentViewController(viewController, animated: true, completion: nil)
//                    })
//                }
//            })
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
