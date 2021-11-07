//
//  CollegeMarketViewController.swift
//  College MarketPlace
//
//  Created by Jason Mai on 11/6/21.
//

import UIKit
import Parse
import AlamofireImage

class CollegeMarketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var userInputRequest: String = ""
    var posts = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(userInputRequest)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 4.2) / 2
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        self.collectionView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let formattedString = userInputRequest.replacingOccurrences(of: " ", with: "")
        let query = PFQuery(className: formattedString)
        query.includeKey("user")
        query.limit = 25
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostViewCell", for: indexPath) as! PostViewCell
        let post = posts[indexPath.row]
        
        let user = post["user"] as! PFUser
//        cell.usernameLabel.text = user.username
        cell.priceLabel.text = "$" + (post["price"] as! String)
        cell.itemLabel.text = (post["item"] as! String)
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)
        cell.photoView.af_setImage(withURL: url!)
        
        return cell
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cameraViewController = segue.destination as! PostProductViewController
        cameraViewController.universityChosen = userInputRequest
        
        
    }

}
