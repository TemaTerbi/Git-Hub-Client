//
//  CommitsTableView.swift
//  GitHubClient
//
//  Created by TeRb1 on 08.08.2022.
//

import UIKit


class CommitsTableView: UIViewController {
    
    private let refreshController = UIRefreshControl()
    private let tableView = UITableView.init(frame: .zero)
    private var arrayCommits: [Commits] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = "Коммиты"
        
        addSubviews()
        updateLayout(with: self.view.frame.size)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(CommitsCell.self, forCellReuseIdentifier: "TableViewCellCommits")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 120
        self.tableView.separatorStyle = .none
        
        
        
        refreshController.attributedTitle = NSAttributedString(string: "Загрузка...")
        refreshController.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshController)
        refreshController.beginRefreshing()
        
        getCommits()
        
    }
    
    func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    //MARK: - Private Methodts
    @objc func refresh(_ sender: AnyObject) {
        self.refreshController.endRefreshing()
    }
    
    private func getCommits() {
        ApiManager.shared.getCommits { commits in
            self.arrayCommits = commits
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshController.endRefreshing()
            }
        }
    }
}

extension CommitsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCommits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCellCommits", for: indexPath) as! CommitsCell
        let com = arrayCommits[indexPath.row]
        cell.setupData(com)
        return cell
    }
}
