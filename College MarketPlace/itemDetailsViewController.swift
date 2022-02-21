//
//  itemDetailsViewController.swift
//  College MarketPlace
//
//  Created by Jason Mai on 11/7/21.
//

import UIKit
import Parse
import AlamofireImage

class itemDetailsViewController: UIViewController {
    
    @IBOutlet weak var userSeller: UILabel!
    @IBOutlet weak var sellerPrice: UILabel!
    @IBOutlet weak var sellerCategory: UILabel!
    @IBOutlet weak var sellerItem: UILabel!
    @IBOutlet weak var sellerDescription: UILabel!
    @IBOutlet weak var sellerImage: UIImageView!
    
    var postUser = ""
    var postPrice = ""
    var postCategory = ""
    var postItem = ""
    var postDescription = ""
    var postImage: URL? = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSeller.text = postUser
        sellerPrice.text = postPrice
        sellerCategory.text = postCategory
        sellerItem.text = postItem
        sellerDescription.text = postDescription
        sellerImage.af_setImage(withURL: postImage!)
        // Do any additional setup after loading the view.
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
