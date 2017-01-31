//
//  ViewController.swift
//  DroneShots
//
//  Created by Sebastian Muehl on 1/26/17.
//  Copyright © 2017 Sebastian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var droneTableView: UITableView!
    
    var drones : [Drone] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
        droneTableView.dataSource = self
        droneTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        do {
            drones = try context.fetch(Drone.fetchRequest())
            droneTableView.reloadData()
        } catch {
            
            print("Couldn't fetch drones from CoreData")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let drone = drones[indexPath.row]
        cell.textLabel?.text = drone.title
        cell.imageView?.image = UIImage(data: drone.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = drones[indexPath.row] 
        performSegue(withIdentifier: "droneSegue", sender: selectedCell)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DroneViewController
        nextVC.drone = sender as? Drone
    }
    
    
    
}
