//
//  ViewController.swift
//  coreDataProject
//
//  Created by Gabriel Cisneros on 12/31/17.
//  Copyright © 2017 Gabriel Cisneros. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting up
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //creating an entity
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        //populating an entity
        newUser.setValue("Gabe", forKey: "userName")
        newUser.setValue("GeeCee27", forKey: "handleName")

        print(newUser)
        
        //Saving an entity
        do{
            try context.save()
        } catch {
            print("Failed to save user information.")
        }
        
        //making a request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                print(data.value(forKey: "userName") as! String)
                print(data.value(forKey: "handleName") as! String)
                
                userNameLabel.text = data.value(forKey: "userName") as? String
                
                var handleName = data.value(forKey: "handleName") as? String
                handleName = "@" + handleName!
                
                handleNameLabel.text = handleName
            }
        } catch {
            print("Request failed.")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var handleNameLabel: UILabel!
    
    
    
}

