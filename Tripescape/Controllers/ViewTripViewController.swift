//
//  ViewTripViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 08/08/2021.
//

import UIKit

class ViewTripViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()

        // Do any additional setup after loading the view.
    }
    
    func setupNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
