//
//  PlanTripViewController.swift
//  Tripsy
//
//  Created by Avinav Goel on 20/02/16.
//  Copyright © 2016 Avinav Goel. All rights reserved.
//

import UIKit

class PlanTripViewController: UIViewController {
    
    
    let initialref = Firebase(url: "https://tripsy.firebaseio.com")
    let usersRef = Firebase(url: "https://tripsy.firebaseio.com/users")
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    var username : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = username

        initialref.observeAuthEventWithBlock({
            (authData) -> Void in
            if authData == nil {
                dispatch_async(dispatch_get_main_queue(), {
                    ()-> Void in
                    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login") as! LoginViewController
                    self.presentViewController(loginVC, animated: true, completion: nil)
                })
                
            }
            else{
                let userRef = self.usersRef.childByAppendingPath("\(authData.uid)")
                userRef.observeEventType(.Value, withBlock: {
                    (dataSnapshot) -> Void in
                    if let postDictionary = dataSnapshot.value as? Dictionary<String, AnyObject> {
                        self.usernameLabel.text = postDictionary["userName"] as? String
                    }
                })
                
            }
            
        })

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutAction(sender: AnyObject){
        
        // Send a request to log out a user
    initialref.unauth()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
