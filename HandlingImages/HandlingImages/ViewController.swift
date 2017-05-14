//
//  ViewController.swift
//  HandlingImages
//
//  Created by Tom Holland on 5/14/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var currentImage: UIImage!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    
    @IBAction func changeFilter(_ sender: Any) {
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        currentImage = image
    }

    func navBarSetup(){
        
        title = "Handle It"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }
    
    func importPicture() {
        
        let picker = UIImagePickerController()
        
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
}

