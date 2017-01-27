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
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photosTapped(_ sender: AnyObject) {
    
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
    
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let drone = Drone(context: context)
        drone.title = titleTextField.text
        drone.image = UIImagePNGRepresentation(imageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
        navigationController!.popViewController(animated: true)
    
    }
    
    
}
