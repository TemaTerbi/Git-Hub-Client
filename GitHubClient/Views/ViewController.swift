//
//  ViewController.swift
//  GitHubClient
//
//  Created by TeRb1 on 07.08.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    private let loginButtonColor = UIColor(hex: 0x6CC644)

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = loginButtonColor
        button.setTitle("Войти в GitHub", for: .normal)
        button.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addSubView()
        setupConstraints()
    }
    
    //MARK: - Private Methodts
    private func addSubView() {
        self.view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        
        let constraints = [
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func login() {
        let vc = LoginPageOauth()
        vc.modalPresentationStyle = .fullScreen
        let test = UINavigationController(rootViewController: vc)
        self.present(test, animated: true)
        
        UserDefaults.standard.removeObject(forKey: "AccessToken")
        UserDefaults.standard.removeObject(forKey: "UserAuthCode")
    }
}

