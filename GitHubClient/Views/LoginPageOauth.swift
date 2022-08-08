//
//  LoginPageOauth.swift
//  GitHubClient
//
//  Created by TeRb1 on 07.08.2022.
//

import UIKit
import WebKit

protocol LoginPageOauthDelegate: AnyObject {
    func handleTokenChanged(token: String)
}

final class LoginPageOauth: UIViewController {
    
    weak var delegate: LoginPageOauthDelegate?
    
    private let webView = WKWebView()
    private let clientId = "17bdb8071f045ddcbda8"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        redirectToOauthPage()
        webView.navigationDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.view.bounds
    }
    
    //MARK: - Private Methodts
    private func redirectToOauthPage() {
        
        guard var urlComponents = URLComponents(string: "https://github.com/login/oauth/authorize") else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "\(clientId)")
        ]
        guard let url = urlComponents.url else { return }
        
        webView.load(URLRequest(url: url))
    }
}

extension LoginPageOauth: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let scheme = URL(string: "http://tematerbi.github.io/?code=")?.scheme ?? ""
        if let url = navigationAction.request.url, url.scheme == scheme, navigationAction.navigationType == .linkActivated {
            decisionHandler(.cancel)
            print(url)
        } else {
            decisionHandler(.allow)
            if let url = navigationAction.request.url, url.scheme == scheme {
                
                print(url)
                
                let targetString = url.absoluteString.replacingOccurrences(of: "#", with: "?")
                guard let components = URLComponents(string: targetString) else { return }
                let token = components.queryItems?.first(where: { $0.name == "code"})?.value
                
                if let token = token {
//                    delegate?.handleTokenChanged(token: token)
                    UserDefaults.standard.set(token, forKey: "UserAuthCode")
                }
                
                let vc = MainPage()
                let mainScreen = UINavigationController(rootViewController: vc)
                mainScreen.modalPresentationStyle = .fullScreen
                self.present(mainScreen, animated: true)
            }
        }
    }
}
