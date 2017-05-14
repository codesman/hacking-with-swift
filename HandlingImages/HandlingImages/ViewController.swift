//
//  ViewController.swift
//  HandlingImages
//
//  Created by Tom Holland on 5/14/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    
    @IBAction func changeFilter(_ sender: Any) {
        
        let alert = UIAlertController(title: "Choose Filter", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CIPixelate", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CITwirl", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarSetup()
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    func setFilter(action: UIAlertAction!) {
        
        guard currentImage != nil else { return }
        
        currentFilter = CIFilter(name: action.title!)
        
        let beginImage = CIImage(image: currentImage)
        
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    func applyProcessing() {
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        guard let filterOutput = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(filterOutput, from: filterOutput.extent) else { return }
        
        let processedImage = UIImage(cgImage: cgImage)
        imageView.image = processedImage
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

