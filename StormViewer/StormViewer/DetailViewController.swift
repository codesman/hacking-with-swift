//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Tom Holland on 5/2/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {
    
    var selectedImage: String?

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedImage
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }

    func shareTapped() {
        guard let image = imageView.image else { return }
        
        if let viewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
            viewController.setInitialText("Look at this great image!")
            viewController.add(image)
            viewController.add(URL(string: "http://www.photolib.noaa.gov/nssl"))
            
            present(viewController, animated: true)
        }
        
//        let viewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
//        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
//        present(viewController, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
