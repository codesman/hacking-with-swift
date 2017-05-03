//
//  ViewController.swift
//  BrowseBetter
//
//  Created by Tom Holland on 5/3/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        if let url = URL(string: "https://www.hackingwithswift.com") {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func openTapped() {
        let alert = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    
        present(alert, animated:  true)
    }
    
    func openPage(action: UIAlertAction!) {
        if let url = URL(string: "https://\(String(describing: action.title))") {
            webView.load(URLRequest(url: url))
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

