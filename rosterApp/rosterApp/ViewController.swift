//
//  ViewController.swift
//  rosterApp
//
//  Created by Casey on 8/9/14.
//  Copyright (c) 2014 Casey. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate   {

    @IBOutlet weak var classTableView: UITableView!
    var c19 = [Person]()
    var c19Teachers = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.classTableView.dataSource = self
        self.classTableView.delegate = self
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,  true  )[0] as? String
        if let c19 = NSKeyedUnarchiver.unarchiveObjectWithFile(documentsPath! + "/archive") as? [Person] {
            //Do this stuff
            var that = "hello"
            
            
        }else{
            //load from plist
            newClass()
            NSKeyedArchiver.archiveRootObject(c19, toFile:documentsPath! + "/archive")
        //do anny additional setup
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        var c19 = NSKeyedUnarchiver.unarchiveObjectWithFile(documentsPath + "/archive") as [Person]
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newClass(){
        var pathToTargetPlist = NSBundle.mainBundle().pathForResource("personList", ofType: "plist")
        var personFromPlist = NSArray(contentsOfFile: "pathToTargetPlist")
        
        for i in personFromPlist {
            if let person = i as? Dictionary<String, String>{
                if let firstN = person["firstName"] as String!{
                    if let lastN = person["lastName"] as String!{
                        let newperson = Person(firstname: firstN, lastname: lastN)
                        //newperson.profilepicture = UIImage(named: "stockProfileImage")
                            println(newperson)
                        if newperson.lastname == "Clem" || newperson.lastname ==  "Johnson" || newperson.firstname == "Lindy"{
                            newperson.isTeacher = true
                            self.c19Teachers.append(newperson)
                        }
                            self.c19.append(newperson)
                        
                    }
                }
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 2
    }
    
   func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        if section == 0 {
            return "Teachers"
        } else{
            return "Students"
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        if section == 0{
            return 2
        }else{
            return (c19.count - 2)
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        //get my cell
        println("method called for cell at row:\(indexPath.row)")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        if indexPath.section == 0 {
            var personForRow = self.c19Teachers[indexPath.row]
            cell.textLabel.text = personForRow.fullName()
        }else{
            //configure it for the row
            var personForRow = self.c19[indexPath.row]
            cell.textLabel.text = personForRow.fullName()
        
       }
        //return the cell
        return cell
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println(indexPath.section)
    }
     override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
       let destination = segue.destinationViewController as DetailViewController
        if segue.identifier == "PersonIdentifier" {
            if classTableView.indexPathForSelectedRow().section == 0{
                let thisperson = c19Teachers[classTableView.indexPathForSelectedRow().row]
                destination.person = thisperson
            }else{
                destination.person = c19[classTableView.indexPathForSelectedRow().row]
            }
        }
        if segue.identifier == "addPerson" {
            
        let thisperson = Person(firstname: "", lastname: "")
            destination.person = thisperson
        }
    }

}































