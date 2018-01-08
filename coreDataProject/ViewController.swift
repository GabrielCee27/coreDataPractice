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

        //setting up
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        //creating an entity
//        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
//        let newUser = NSManagedObject(entity: entity!, insertInto: context)
//
//        //populating an entity
//        newUser.setValue("Gabe", forKey: "userName")
//        newUser.setValue("GeeCee27", forKey: "handleName")
//
//        print(newUser)
//
//        //Saving an entity
//        do{
//            try context.save()
//        } catch {
//            print("Failed to save user information.")
//        }
//
//        //making a request
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        request.returnsObjectsAsFaults = false
//
//        do{
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject]{
//                print(data.value(forKey: "userName") as! String)
//                print(data.value(forKey: "handleName") as! String)
//
//                userNameLabel.text = data.value(forKey: "userName") as? String
//
//                var handleName = data.value(forKey: "handleName") as? String
//                handleName = "@" + handleName!
//
//                handleNameLabel.text = handleName
//            }
//        } catch {
//            print("Request failed.")
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func createEntityWith(name:String, userName:String){
        print("Creating an entity...")
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let user = NSManagedObject(entity: entity!, insertInto: context)
        
        user.setValue(name, forKey: "name")
        user.setValue(userName, forKey: "userName")
        
        print(user)
    }

    func save(){
        let context = getContext()
        do {
            try context.save()
        } catch {
            print("Failed to save.")
        }
    }
    
    func fetchReqFor(entityName:String){
        
        let context = getContext()
        
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        req.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(req)
            for result in results as! [NSManagedObject] {
                print(result.value(forKey: "name") as! String)
                print(result.value(forKey: "userName") as! String)
            }
        } catch {
            print("Request failed.")
        }
    }
    
    func deleteAll(entityName:String){
        
        let context = getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
       request.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                
                context.delete(result)
                save()
            }
        } catch {
            print("Request failed.")
        }
        
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        createEntityWith(name: nameTextField.text!, userName: userNameTextField.text!)
        save()
        print("Saved Context")
    }
    
    @IBAction func fetchButtonPressed(_ sender: Any) {
        fetchReqFor(entityName: "User")
        print("Fetch done.")
    }
    
    @IBAction func deleteAllButtonPressed(_ sender: Any) {
        deleteAll(entityName: "User")
        print("Deleted all")
    }
    
    
}

