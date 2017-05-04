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
    var progressView: UIProgressView!
    var sites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        if let url = URL(string: "https://" + sites[0]) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func openTapped() {
        let alert = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        
        for site in sites {
            alert.addAction(UIAlertAction(title: site, style: .default, handler: openPage))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        //        alert.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        present(alert, animated:  true)
    }
    
    func openPage(action: UIAlertAction!) {
        guard let title = action.title, let url = URL(string: "https://" + title) else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let host = navigationAction.request.url?.host else { return }
        
        for site in sites {
            if host.range(of: site) != nil {
                decisionHandler(.allow)
                return
            }
        }
        
        decisionHandler(.cancel)
    }
}

