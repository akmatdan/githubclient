//
//  LoginViewController.swift
//  githubclient
//
//  Created by Rasul Sultanbekov on 31/5/23.
//

import UIKit

import RxSwift
import WebKit
import RxCocoa
import Resolver

class LoginViewController: UIViewController, ILoginScreen, WKNavigationDelegate {

    var viewModel: ILoginViewModel!
    
    private var webView: WKWebView!
    private var deviceCodeLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    var authorizationURL: URL {
        return viewModel.authorizationURL
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadAuthorizationPage()
        
    }

    private func setupUI() {
        setupWebView()
        setupDeviceCodeLabel()
        
    }

    private func setupWebView() {
        let webViewConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupDeviceCodeLabel() {
        deviceCodeLabel = UILabel()
        deviceCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceCodeLabel.textAlignment = .center
        deviceCodeLabel.font = UIFont.systemFont(ofSize: 14)
        deviceCodeLabel.textColor = .gray
        view.addSubview(deviceCodeLabel)

        NSLayoutConstraint.activate([
            deviceCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deviceCodeLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 16), // Updated constraint
            deviceCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deviceCodeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        view.bringSubviewToFront(deviceCodeLabel)
    }


    private func loadAuthorizationPage() {
        let request = URLRequest(url: authorizationURL)
        webView.load(request)
    }
    
    private func handleLoginCompletion() {
        if let deviceCode = self.deviceCodeLabel {
            // Use the device code as needed (e.g., send it to the server)
            print("Device Code: \(deviceCode)")
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.querySelector('pre').innerText") { [weak self] (result, error) in
            if let deviceCode = result as? String {
                DispatchQueue.main.async { [weak self] in
                    self?.deviceCodeLabel.text = "Device Code: \(deviceCode)"
                }
            }
        }
    }
}
