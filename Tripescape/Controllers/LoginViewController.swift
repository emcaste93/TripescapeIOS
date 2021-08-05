//
//  ViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 25/07/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var isLoginSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.isLoginSuccess = false
        configScreen()
    }
    
    func configScreen() {
        setUnderline(txtField: txtUser)
        setUnderline(txtField: txtPass)
        txtPass.isSecureTextEntry = true
    }
    
    func setUnderline(txtField: UITextField){
        let bottonLine = CALayer()
        let height = txtField.frame.height - 1
        bottonLine.frame = CGRect(origin: CGPoint(x: 0, y: height), size: CGSize(width: txtField.frame.width, height: 1))
        bottonLine.backgroundColor = UIColor.black.cgColor
        txtField.borderStyle = .none
        txtField.layer.addSublayer(bottonLine)
    }

    @IBAction func btnLoginClicked(_ sender: Any) {
        btnLogin.isEnabled = false
        print("btnLoginClicked starts")
        if let strUser = txtUser.text, !strUser.isEmpty {
            if let strPassword = txtPass.text, !strPassword.isEmpty {
                AuthenticationService.sharedInstance.loginUser(email: strUser, password: strPassword) { (error: Error?) in
                    //Login completed - check if error
                    print("LoginUser completed")
                    if error != nil {
                        self.displayAlert(title: "Login error", message: error!.localizedDescription)
                    } else {
                        self.isLoginSuccess = true
                        self.txtPass.text = ""
                        self.txtUser.text = ""
                        //Perform segue to main screen
                    }
                }
            } else {
                displayAlert(title: "Error login", message: "Invalid password")
            }
        } else {
            displayAlert(title: "Login error", message: "Invalid user")
        }
        btnLogin.isEnabled = true
    }
    
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        btnLogin.isEnabled = false
        print("btnLoginClicked starts")
        if let strUser = txtUser.text, !strUser.isEmpty {
            if let strPassword = txtPass.text, !strPassword.isEmpty {
                AuthenticationService.sharedInstance.registerUser(email: strUser, password: strPassword) { (error: Error?) in
                    //Login completed - check if error
                    print("LoginUser completed")
                    if error != nil {
                        self.displayAlert(title: "Login error", message: error!.localizedDescription)
                    } else {
                        self.isLoginSuccess = true
                        self.txtPass.text = ""
                        self.txtUser.text = ""
                        //Perform segue to main screen
                        self.performSegue(withIdentifier: "segueCreateTrip", sender: nil)
                    }
                }
            } else {
                displayAlert(title: "Error login", message: "Invalid password")
            }
        } else {
            displayAlert(title: "Login error", message: "Invalid user")
        }
        btnLogin.isEnabled = true
        displayAlert(title: "Sing up completed!", message: "Sign up completed, log in to continue")
    }
    
    func displayAlert(title: String, message: String) {
        let alerta = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: { (accion) in
            alerta.dismiss(animated: true, completion: nil)
        }))
        self.present(alerta, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "segueCreateTrip") {
            var createTripController = segue.destination as! CreateTripViewController
            createTripController.username = txtUser.text!
        }
    }}

