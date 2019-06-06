//
//  LoginViewController.swift
//  Part 2.1 Adapted
//
//  Created by Anton on 5/25/19.
//  Copyright © 2019 Anton. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var control: UISegmentedControl!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBAction func button(_ sender: Any) {
        if ((login.text?.elementsEqual(""))!) || ((password.text?.elementsEqual(""))!) == false {
            if control.selectedSegmentIndex == 0 {
                let savedPassword = UserDefaults.standard.object(forKey: login.text!)
                if (savedPassword! as! String).elementsEqual(password.text!) {
                    self.performSegue(withIdentifier: "finishLog", sender: self)
                }
            } else {
                UserDefaults.standard.set(password.text!, forKey: login.text!)
                control.selectedSegmentIndex = 0
            }
        }
    }
    @IBOutlet weak var button1: UIButton!
    @IBAction func changed(_ sender: Any) {
        if control.selectedSegmentIndex == 0 {
            button1.titleLabel?.text = "Login"
        } else {
            button1.titleLabel?.text = "Register"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishLog" {
        }
    }
}
