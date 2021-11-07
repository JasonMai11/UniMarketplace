//
//  TabBarViewController.swift
//  College MarketPlace
//
//  Created by Jason Mai on 11/6/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var selectedUniversity = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedUniversity)

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        let collegeMarketViewController = segue.destination as! CollegeMarketViewController
//        collegeMarketViewController.userInputRequest = univChosen
//    }
    

}
