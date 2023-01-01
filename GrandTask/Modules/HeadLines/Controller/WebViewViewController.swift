//
//  WebViewViewController.swift
//  GrandTask
//
//  Created by Mohamed Samy on 29/12/2022.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var newURL = ""
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
        // Do any additional setup after loading the view.
    }
    

    func setUpWebView() {
        let url = URL(string: newURL)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
