//
//  CommitsCell.swift
//  GitHubClient
//
//  Created by TeRb1 on 08.08.2022.
//

import UIKit


class CommitsCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lableSha: UILabel = {
        let lable = UILabel()
        lable.clipsToBounds = true
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        return lable
    }()
    
    lazy var lableAuthor: UILabel = {
        let lable = UILabel()
        lable.clipsToBounds = true
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        return lable
    }()
    
    lazy var lableMessage: UILabel = {
        let lable = UILabel()
        lable.clipsToBounds = true
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        lable.numberOfLines = 1
        return lable
    }()
    
    lazy var lableDate: UILabel = {
        let lable = UILabel()
        lable.clipsToBounds = true
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backView)
        contentView.addSubview(lableSha)
        contentView.addSubview(lableAuthor)
        contentView.addSubview(lableMessage)
        contentView.addSubview(lableDate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.frame = CGRect(x: 5, y: 10, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 20)
        lableSha.frame = CGRect(x: 15, y: -15, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 20)
        lableAuthor.frame = CGRect(x: 15, y: 0, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 20)
        lableMessage.frame = CGRect(x: 15, y: 15, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 20)
        lableDate.frame = CGRect(x: 15, y: 30, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 20)
    }
    
    func setupData(_ data: Commits) {
        lableSha.text = data.sha
        lableAuthor.text = data.commit?.author.name
        lableMessage.text = data.commit?.message
        lableDate.text = data.commit?.author.date
    }
    
}
