//
//  CreateTripViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 01/08/2021.
//

import UIKit

class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var tbTrips: UITableView!
    var username: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("[CreateViewController] for user: \(username)")
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
