//
//  DroneViewController.swift
//  DroneShots
//
//  Created by Sebastian Muehl on 1/26/17.
//  Copyright © 2017 Sebastian. All rights reserved.
//

import UIKit

class DroneViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var drone: Drone? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        //Open the VC from tapping on a row in the Table
        if drone != nil {
            imageView.image = UIImage(data: drone!.image as! Data)
            titleTextField.text = drone!.title
            
            addButton.setTitle("Update", for: .normal)
        }
            //Game doesn't exist - hide delete button
        else {
            deleteButton.isHidden = true
        }
        
    }
    
    //Tapping on Photos button
    @IBAction func photosTapped(_ sender: AnyObject) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //Tapping on Camera button
    @IBAction func cameraTapped(_ sender: AnyObject) {
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //Tapping on Add button
    @IBAction func addTapped(_ sender: AnyObject) {
        
        if drone != nil {
            //If there is a game, update the content
            drone!.title = titleTextField.text
            drone!.image = UIImagePNGRepresentation(imageView.image!) as NSData?
        }
        else {
            //If there is no game, create a new one
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let drone = Drone(context: context)
            drone.title = titleTextField.text
            drone.image = UIImagePNGRepresentation(imageView.image!) as NSData?
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //Back to VC after tapping Add button
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(drone!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //Back to VC after tapping Add button
        navigationController!.popViewController(animated: true)
    }
    
    
}
