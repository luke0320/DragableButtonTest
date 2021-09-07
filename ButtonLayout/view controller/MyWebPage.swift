//
//  MyWebPage.swift
//  ButtonLayout
//
//  Created by Luke Lee on 2021/9/7.
//

import UIKit
import WebKit

class MyWebPage: UIViewController {
    
    //MARK: - UI
    private var webView: WKWebView!
    
    private var url: URL
    
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: - lifecycle
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWebView()
        setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLoading(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadWebView()
    }
    
    //MARK: - ui configuration
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.fillSuperview()
    }
    
    //MARK: - helper
    private func loadWebView() {
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: self.url))
        }
    }
    
    private func startLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            loading
                ? self.activityIndicator.startAnimating()
                : self.activityIndicator.stopAnimating()
        }
    }
}

//MARK: - WKNavigation Delegate Methods
extension MyWebPage: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startLoading(true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        startLoading(false)
    }
    
}
