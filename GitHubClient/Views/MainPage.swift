//
//  MainPage.swift
//  GitHubClient
//
//  Created by TeRb1 on 07.08.2022.
//

import UIKit

class MainPage: UIViewController {
    
    private let refreshController = UIRefreshControl()
    private let tableView = UITableView.init(frame: .zero)
    private var token = UserDefaults.standard.string(forKey: "UserAuthCode") ?? ""
    private var arrayRepositories: [Repositories] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = "Репозитории"
        
        addSubviews()
        updateLayout(with: self.view.frame.size)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(RepositoriesCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 70
        self.tableView.separatorStyle = .none
        
        refreshController.attributedTitle = NSAttributedString(string: "Загрузка...")
        refreshController.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshController)
        refreshController.beginRefreshing()
        
        updateToken()
        print("NEW CODE WAS SET " + token)
        
        postLoginUser()
        sleep(1)
        getRepositories()
    }
    
    func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    //MARK: - Private Methodts
    private func updateToken() {
        guard !token.isEmpty else {
            let requestTokenViewController = LoginPageOauth()
            present(requestTokenViewController, animated: true)
            return
        }
    }
    
    private func postLoginUser() {
        ApiManager.shared.postUserLogin()
    }
    
    private func getRepositories() {
        ApiManager.shared.getRepositories { rep in
            self.arrayRepositories = rep
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshController.endRefreshing()
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getRepositories()
        self.refreshController.endRefreshing()
    }
}

extension MainPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! RepositoriesCell
        let rep = arrayRepositories[indexPath.row]
        cell.setupData(rep)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailView()
        let rep = arrayRepositories[indexPath.row]
        vc.nameRepo = rep.name
        vc.nameOwner = rep.owner?.login ?? ""
        vc.avatarUrl = rep.owner?.avatar_url ?? ""
        vc.descriptionOfRepo = rep.description ?? "Нет описания"
        vc.forksCount = rep.forks_count
        vc.watchesCount = rep.watchers_count
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

