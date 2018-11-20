//
//  SignUpViewController.swift
//  EnglishNewsApp
//
//  Created by 三上 綾介 on 2018/11/20.
//  Copyright © 2018年 Ryosuke Mikami. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func willSignup(_ sender: Any) {
//        signup()
    }
    
    @IBAction func willTransitionToLogin(_ sender: Any) {
//        transitionToLogin()
    }
    
    func transitionToLogin() {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    func transitionToView() {
        self.performSegue(withIdentifier: "toView", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
