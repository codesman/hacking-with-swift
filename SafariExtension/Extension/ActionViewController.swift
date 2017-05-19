//
//  ActionViewController.swift
//  Extension
//
//  Created by Tom Holland on 5/19/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let inputItem = extensionContext?.inputItems.first as? NSExtensionItem else { return }
        guard let itemProvider = inputItem.attachments?.first as? NSItemProvider else { return }
        
        itemProvider.loadItem(
            forTypeIdentifier: kUTTypePropertyList as String,
            options: [:],
            completionHandler: { [unowned self] (dictionary, error) in
                
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
