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
        
        
        
       // newClass()
       // teachersArrayFromPlist()
        
    
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,  true  )[0] as? String
        
        if let students = NSKeyedUnarchiver.unarchiveObjectWithFile(documentsPath! + "/archive03") as? [Person] {
            self.c19 = students
            //Do this stuff
            if let teachers = NSKeyedUnarchiver.unarchiveObjectWithFile(documentsPath! + "/archive04") as?[Person]{
            self.c19Teachers = teachers
            }
        }else{
                //load from plist
                newClass()
            
            
                NSKeyedArchiver.archiveRootObject(c19, toFile:documentsPath! + "/archive03")
                NSKeyedArchiver.archiveRootObject(c19Teachers, toFile:documentsPath! + "/archive04")
            
                //do anny additional setup
        }
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        NSKeyedArchiver.archiveRootObject(c19, toFile:documentsPath + "/archive03")
        NSKeyedArchiver.archiveRootObject(c19Teachers, toFile:documentsPath + "/archive04")
        
        classTableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newClass(){
        
        var pathToTargetPlist = NSBundle.mainBundle().pathForResource("personList", ofType: "plist")
        var personFromPlist = NSArray(contentsOfFile: pathToTargetPlist)
        
        for anyPerson in personFromPlist{
            
            if let person = anyPerson as? Dictionary<String, String>{
                if let firstKey = person["firstName"] as String!{
                    if let lastKey = person["lastName"] as String!{
                        
                        let personInClassRoster = Person(firstname: firstKey, lastname: lastKey)
                        
                        if personInClassRoster.lastname == "Clem" || personInClassRoster.lastname ==  "Johnson" || personInClassRoster.firstname == "Lindy"{
                            
                            c19Teachers.append(personInClassRoster)
                            
                        }else{

                            c19.append(personInClassRoster)
                            
                        }
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
        switch section {
        case 0:
            return self.c19Teachers.count
        default:
            return self.c19.count
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
            destination.theteachers = c19Teachers
            destination.theclass = c19
        if segue.identifier == "PersonIdentifier" {
            if classTableView.indexPathForSelectedRow().section == 0{
                destination.teacher = true
                destination.person =  c19Teachers[classTableView.indexPathForSelectedRow().row]
            }else{
                destination.person = c19[classTableView.indexPathForSelectedRow().row]
            }
        }
        if segue.identifier == "addPerson" {
            destination.newPerson = true
            let thisperson = Person(firstname: "", lastname: "")
                destination.person = thisperson
        }
    }
}































