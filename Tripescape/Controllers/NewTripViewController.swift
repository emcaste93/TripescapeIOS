//
//  NewTripViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 09/08/2021.
//

import UIKit

class NewTripViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // self.tabBarItem.selectedImage = UIImage(named: "book")
   //     let tabBarAppearence = UITabBar.appearance()
      //  tabBarAppearence.tintColor = nil //UIColor.black
      //  tabBar.inActiveTintColor()
      //  self.tabBar.unselectedItemTintColor = UIColor.gray
      /*  if let tabBarItem1 = self.tabBar.items?[0] {
            tabBarItem1.selectedImage = UIImage(named: "book_fill")
            tabBarItem1.image = UIImage(named: "earth")
        }
        
        if let tabBarItem2 = self.tabBar.items?[1] {
            tabBarItem2.selectedImage = UIImage(named: "earth_fill")
            tabBarItem2.image = UIImage(named: "earth")
        }*/
        
        tabBar.inActiveTintColor()
        
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

extension UITabBar {
    func inActiveTintColor() {
        if let items = items {
            for item in items {
                item.image = item.image?.withRenderingMode(.alwaysOriginal)
                item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
            }
        }
    }
}
