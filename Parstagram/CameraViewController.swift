//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Weixin Yang on 10/15/22.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var commentField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSubmitButton(_ sender: Any) {
        //creating a pet table in parseDB
        let post = PFObject(className: "Posts")
        // generate schema
        post["caption"] = commentField.text
        post["author"] = PFUser.current()! //PFUser.current is the current user loggedin
        
        // saving image to another table in DB
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data : imageData!)
        // this table will have the URL to the image
        post["image"] = file
        
        post.saveInBackground{(success, error) in
            if success {
                print("svaed!")
                //once it's submitted we will dismiss the submit image screen
                self.dismiss(animated: true)
                
                //self.performSegue(withIdentifier: "FeedViewController", sender: nil)
            }else {
                print("error!")
            }
        }
    }
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        // picker..delegate is when user is done taking the photo and call me back on the function that has the photo
        picker.delegate = self
        // picker.allowsEditing present a second screen to the user after the user is done taking the photo
        picker.allowsEditing = true
        
        // check if the camera is avaiable
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //picker.sourceType = .camera
            picker.sourceType = .photoLibrary

        } else { // if camera is not avaiable select from photoLibary
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    // display the choosen/taken image to show up in imageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //images comes from info dictionary and cast it as UIImage
        let image = info[.editedImage] as! UIImage
        
        //resizing image
        let size = CGSize(width:300, height:300)
        let scaledImage = image.af.imageScaled(to: size)
        imageView.image = scaledImage
        // dismiss the cameraView
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
