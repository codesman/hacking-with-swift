//
//  DetailViewController.swift
//  Petitions
//
//  Created by Tom Holland on 5/7/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDetailBody()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setDetailBody() {
        guard detailItem != nil else { return }
        guard let body = detailItem["body"] else { return }
        
        var html = "<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style>body { font-size: 150%; }</style>"
        html += "</head><body>" + body + "</body></html>"
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
