//
//  PostProductViewController.swift
//  College MarketPlace
//
//  Created by Jason Mai on 11/6/21.
//

import UIKit
import DropDown
import Parse
import AlamofireImage
import Alamofire

class PostProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var universityChosen : String = ""

    
    @IBOutlet weak var vwDropDown: UIView!
    @IBOutlet weak var categorySelector: UILabel!
    @IBOutlet weak var itemPost: UITextField!
    @IBOutlet weak var descriptionPost: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceTag: UITextField!
    
    
    let dropDown = DropDown()
    let dropDownValues = [
                    "Books",
                    "Clothes",
                    "Technology",
                    "Shoes",
                    "House Items",
                    "Food",
                    "Other"
                ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(universityChosen)
        categorySelector.text = "Press to select Category"
        dropDown.anchorView = vwDropDown
        dropDown.dataSource = dropDownValues
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index : Int, item: String) in print("Selected item: \(item) at index: \(index)")
            self.categorySelector.text = dropDownValues[index]
        }
    }
    
    
    @IBAction func showCategoryOptions(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func onSubmit(_ sender: Any) {
        let formattedString = universityChosen.replacingOccurrences(of: " ", with: "")
        let market = PFObject(className: formattedString)
        
        market["user"] = PFUser.current()!
        market["item"] = itemPost.text!
        market["category"] = categorySelector.text!
        market["price"] = priceTag.text!
        market["description"] = descriptionPost.text!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        market["image"] = file
        
        market.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("error")
            }
        }
        
        
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
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
