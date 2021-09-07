//
//  MyWebPage.swift
//  ButtonLayout
//
//  Created by Luke Lee on 2021/9/7.
//

import UIKit

class MyWebPage: UIViewController {
    
    private var webView: WKWebView!
    
    private var url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
    }
    
    private func loadWebView() {
        webView.load(URLRequest(url: url))
    }
}
