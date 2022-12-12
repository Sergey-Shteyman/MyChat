//
//  ChatCell.swift
//  MyChat
//
//  Created by Сергей Штейман on 11.12.2022.
//

import UIKit

// MARK: - ChatCell
final class ChatCell: UITableViewCell {
    
    private let robotoFonr = RobotoFont.self
    
    private lazy var senderAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var senderName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: robotoFonr.medium, size: 22)
        label.text = "Person"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension ChatCell {
    
    func setupCell() {
        addSubViews()
        addConstraints()
    }
    
    func addSubViews() {
        myAddSubViews(from: [senderAvatar, senderName])
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            senderAvatar.centerYAnchor.constraint(equalTo: centerYAnchor),
            senderAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            senderAvatar.widthAnchor.constraint(equalToConstant: 60),
            senderAvatar.heightAnchor.constraint(equalToConstant: 60),
            
            senderName.centerYAnchor.constraint(equalTo: centerYAnchor),
            senderName.leadingAnchor.constraint(equalTo: senderAvatar.trailingAnchor, constant: 30),
            senderName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
}
