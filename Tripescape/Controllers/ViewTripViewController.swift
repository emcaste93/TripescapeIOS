//
//  ViewTripViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 08/08/2021.
//

import UIKit

class ViewTripViewController: UIViewController {

    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblDates: UILabel!
    
    var dest: String = ""
    var dates: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()

        // Do any additional setup after loading the view.
        lblDestination.text = dest != Enums.Location.Black_Forest.description ? dest : "Black Forest"
        lblDates.text = dates
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
