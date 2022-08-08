//
//  DetailView.swift
//  GitHubClient
//
//  Created by TeRb1 on 08.08.2022.
//

import Foundation
import UIKit


class DetailView: UIViewController {
    
    private let mainGreenColorOfGit = UIColor(hex: 0x6CC644)
    
    var nameRepo = ""
    var nameOwner = ""
    var avatarUrl = ""
    var descriptionOfRepo = ""
    var forksCount = 0
    var watchesCount = 0
    
    private lazy var nameOwnerLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Владелец: " + nameOwner
        return lable
    }()
    
    private lazy var avatarUser: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        if let url = URL(string: avatarUrl) {
            if let data = try? Data(contentsOf: url) {
                image.image = UIImage(data: data)
            }
        }
    
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 50
        return image
    }()
    
    private lazy var descriptionLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Описание: " + descriptionOfRepo
        lable.numberOfLines = 0
        return lable
    }()
    
    private lazy var forksLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Вилок: " + String(forksCount)
        return lable
    }()
    
    private lazy var watchesLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "посмотрели: " + String(watchesCount)
        return lable
    }()
    
    private lazy var commitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = mainGreenColorOfGit
        button.setTitle("Список коммитов", for: .normal)
        button.addTarget(self, action: #selector(self.showCommits), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = nameRepo
        
        addSubView()
        setupConstraints()
    }
    
    private func addSubView() {
        self.view.addSubview(nameOwnerLable)
        self.view.addSubview(avatarUser)
        self.view.addSubview(descriptionLable)
        self.view.addSubview(watchesLable)
        self.view.addSubview(forksLable)
        self.view.addSubview(commitButton)
    }
    
    func setupConstraints() {
        
        let constaraints = [
            avatarUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarUser.heightAnchor.constraint(equalToConstant: 100),
            avatarUser.widthAnchor.constraint(equalToConstant: 100),
            avatarUser.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            nameOwnerLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            nameOwnerLable.leadingAnchor.constraint(equalTo: avatarUser.trailingAnchor, constant: 20),
            nameOwnerLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            descriptionLable.topAnchor.constraint(equalTo: nameOwnerLable.bottomAnchor, constant: 5),
            descriptionLable.leadingAnchor.constraint(equalTo: avatarUser.trailingAnchor, constant: 20),
            descriptionLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            forksLable.topAnchor.constraint(equalTo: avatarUser.bottomAnchor, constant: 20),
            forksLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            forksLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            watchesLable.topAnchor.constraint(equalTo: avatarUser.bottomAnchor, constant: 20),
            watchesLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            watchesLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            commitButton.topAnchor.constraint(equalTo: watchesLable.bottomAnchor, constant: 20),
            commitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            commitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            commitButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        NSLayoutConstraint.activate(constaraints)
        
    }
    
    @objc private func showCommits() {
        UserDefaults.standard.set(nameRepo, forKey: "nameOfRepo")
        UserDefaults.standard.set(nameOwner, forKey: "Login")
        
        let vc = CommitsTableView()
        let commitsScreen = UINavigationController(rootViewController: vc)
        self.present(commitsScreen, animated: true)
    }
    
}
