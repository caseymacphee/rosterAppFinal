//
//  DetailViewController.swift
//  rosterApp
//
//  Created by Casey on 8/15/14.
//  Copyright (c) 2014 Casey. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
   
   
    var imageDownloadQ = NSOperationQueue()
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var ImageView: UIImageView!
    
    
    var person: Person!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageDownloadQ.qualityOfService = NSQualityOfService.UserInitiated

        nameField.text = self.person.firstname
        lastNameField.text = self.person.lastname
        
        self.nameField.delegate = self
        self.lastNameField.delegate = self
        // Do any additional setup after loading the view.
    }
     override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if nameField == nil{
        var myURL = NSURL(string: "http://www.zuguide.com/images/483/483.0.570.359.jpg")
        
        var downloadOperation = NSBlockOperation { () -> Void in
            var myData = NSData(contentsOfURL: myURL)
            var myImage = UIImage(data: myData)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.ImageView.image = myImage
            })
        }
        downloadOperation.qualityOfService = NSQualityOfService.Background
        self.imageDownloadQ.addOperation(downloadOperation)
        }else{
            //work with github api
            
        }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func changeprofileimage(sender: AnyObject) {
        var imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        //this gets fired when the image picker is done
        println("user picked an image")
        var editedImage = info[UIImagePickerControllerOriginalImage] as UIImage
        self.ImageView.image = editedImage
        
    }
    func textFieldDidEndEditing(textField: UITextField!) {
        if textField == nameField {
            self.person.firstname = textField.text
        }
        if textField == lastNameField{
            self.person.lastname = textField.text
        }
        
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        //this gets fired when the users cancel out of the process
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
