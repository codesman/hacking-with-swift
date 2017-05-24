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

    var pageTitle = ""
    var pageURL = ""
    
    @IBOutlet weak var script: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpNotifications()
        setUpBarButton()
        loadPlist()
    }
    
    func setUpNotifications() {
    
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: Notification.Name.UIKeyboardWillChangeFrame,
            object: nil
        )
    }
    
    func adjustForKeyboard(notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardScreenEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame.cgRectValue, from: view.window)
        
        switch notification.name {
        case Notification.Name.UIKeyboardWillHide:
            script.contentInset = UIEdgeInsets.zero
        default:
            script.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        script.scrollRangeToVisible(script.selectedRange)
    }
    
    func setUpBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }

    func loadPlist() {
        
        guard let inputItem = extensionContext?.inputItems.first as? NSExtensionItem else { return }
        guard let itemProvider = inputItem.attachments?.first as? NSItemProvider else { return }
        
        itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { (dictionary, error) in
            
            guard let itemDictionary = dictionary as? NSDictionary,
                let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary,
                let title = javaScriptValues["title"] as? String,
                let url = javaScriptValues["URL"] as? String
                else { return }
            
            self.pageTitle = title
            self.pageURL = url
            
            DispatchQueue.main.async {
                self.title = self.pageTitle
            }
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func returnItem() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        
        item.attachments = [customJavaScript]
        
        extensionContext!.completeRequest(returningItems: [item])
    }
    
    @IBAction func done() {
        returnItem()
    }

}
