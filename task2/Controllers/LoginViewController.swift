//
//  LoginViewController.swift
//  task2
//
//  Created by Anton on 6/6/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var georgia: UISwitch!
    @IBOutlet weak var usa: UISwitch!
    @IBOutlet weak var belarus: UISwitch!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var control: UISegmentedControl!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBAction func button(_ sender: Any) {
        if ((login.text?.elementsEqual(""))!) || ((password.text?.elementsEqual(""))!) == false {
            if control.selectedSegmentIndex == 0 {
                let savedPassword = UserDefaults.standard.object(forKey: login.text!)
                let setKey = login.text! + "Set"
                let cuisine = UserDefaults.standard.object(forKey: setKey)
                if (savedPassword! as! String).elementsEqual(password.text!) {
                    self.performSegue(withIdentifier: "finishLog", sender: cuisine)
                }
            } else {
                if confirm.text?.elementsEqual((password.text)!) == true {
                    UserDefaults.standard.set(password.text!, forKey: login.text!)
                    let cuisine = [belarus.isOn, usa.isOn, georgia.isOn]
                    let setKey = login.text! + "Set"
                    UserDefaults.standard.set(cuisine, forKey: setKey)
                }
            }
        }
    }
    
    @IBOutlet weak var button1: UIButton!
    
    @IBAction func changed(_ sender: Any) {
        if control.selectedSegmentIndex == 0 {
            button1.titleLabel?.text = "Login"
            label3.isHidden = true
            confirm.isHidden = true
            label4.isHidden = true
            label5.isHidden = true
            label6.isHidden = true
            label7.isHidden = true
            belarus.isHidden = true
            usa.isHidden = true
            georgia.isHidden = true
        } else {
            button1.titleLabel?.text = "Register"
            label3.isHidden = false
            confirm.isHidden = false
            label4.isHidden = false
            label5.isHidden = false
            label6.isHidden = false
            label7.isHidden = false
            belarus.isHidden = false
            usa.isHidden = false
            georgia.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        label3.isHidden = true
        confirm.isHidden = true
        label4.isHidden = true
        label5.isHidden = true
        label6.isHidden = true
        label7.isHidden = true
        belarus.isHidden = true
        usa.isHidden = true
        georgia.isHidden = true
        button1.isAccessibilityElement = true
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishLog" {
            if let mvc = segue.destination as? ViewController {
                let cuisine = sender as! [Bool]
                mvc.isbel = cuisine[0]
                mvc.isusa = cuisine[1]
                mvc.isgeorgia = cuisine[2]
            }
        }
    }
}
