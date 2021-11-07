//
//  FeedViewController.swift
//  College MarketPlace
//
//  Created by Jason Mai on 11/6/21.
//

import UIKit
import Parse
import AlamofireImage


class FeedViewController: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var universityText = ""
    
    var universityArr = ["University at Buffalo", "New York University", "Northeastern College", "DYou'ville College", "Daemen College", "Binghampton College", "Canisius College", "University of California, San Diego", "University of California, Los Angeles", "Cornell University", "Rochester Institute of Technology", "Harvard University", "Boston University", "University of North Carolina"]
    var searchUniversity = [String]()
    var existingUniversity = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search for School"
//        searchController.searchResultsUpdater = self
//        navigationItem.searchController = searchController
        // Do any additional setup after loading the view.
        
        var query = PFQuery(className:"University")
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil{
                // there was no error in the fetch
            }
            if let returnedobjects = objects {
                for object in returnedobjects{
                    self.universityArr.append(object["name"] as! String)
                }
            }
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Loading Up College Selected")
        // Find Selected College
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let univChosen = universityArr[indexPath.row]
        
        let collegeMarketViewController = segue.destination as! CollegeMarketViewController
        collegeMarketViewController.userInputRequest = univChosen
        
    }
    

}


extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if existingUniversity {
            return searchUniversity.count
        }
        else{
            return universityArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if existingUniversity {
            cell?.textLabel?.text = searchUniversity[indexPath.row]
        }
        else{
            cell?.textLabel?.text = universityArr[indexPath.row]
        }
        return cell!
    }
}

extension FeedViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchUniversity = universityArr.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        existingUniversity = true
        tableView.reloadData()
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        existingUniversity = false
        searchBar.text = ""
        tableView.reloadData()
    }
}



