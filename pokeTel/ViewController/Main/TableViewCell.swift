//
//  contactTableViewCell.swift
//  pokeTel
//
//  Created by 김석준 on 12/7/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .boldSystemFont(ofSize: 16)
        phoneLabel.font = .systemFont(ofSize: 14)
        phoneLabel.textColor = .gray

        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            phoneLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            phoneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(name: String, phoneNumber: String, profileImage: UIImage?) {
        nameLabel.text = name
        phoneLabel.text = phoneNumber
        profileImageView.image = profileImage
    }
}
