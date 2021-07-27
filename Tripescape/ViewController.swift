//
//  ViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 25/07/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configScreen()
    }
    
    func configScreen() {
        setUnderline(txtField: txtUser)
        setUnderline(txtField: txtPass)
    }
    
    func setUnderline(txtField: UITextField){
        let bottonLine = CALayer()
        let height = txtField.frame.height - 1
        bottonLine.frame = CGRect(origin: CGPoint(x: 0, y: height), size: CGSize(width: txtField.frame.width, height: 1))
        bottonLine.backgroundColor = UIColor.black.cgColor
        txtField.borderStyle = .none
        txtField.layer.addSublayer(bottonLine)
    }

}

