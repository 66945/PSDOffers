//
//  WebViewController.swift
//  PSDOffers
//
//  Created by Laviolette, Akivah - Student on 3/20/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url = URL(string: "https://www.hackingwithswift.com")!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.allowsBackForwardNavigationGestures = true
        self.webView.load(URLRequest(url: url))
//        DispatchQueue.global(qos: .background).async {
        
    }
    func configure(url: URL) {
        self.url = url
    }
}
