//
//  RepositoriesCell.swift
//  GitHubClient
//
//  Created by TeRb1 on 08.08.2022.
//

import Foundation
import UIKit

class RepositoriesCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lableNameRepo: UILabel = {
        let lable = UILabel()
        lable.clipsToBounds = true
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 15, weight: .bold)
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backView)
        contentView.addSubview(lableNameRepo)
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
        lableNameRepo.frame = CGRect(x: 15, y: 10, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 20)
    }
    
    func setupData(_ data: Repositories) {
        lableNameRepo.text = data.name
    }
    
}
