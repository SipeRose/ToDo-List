//
//  TableViewCell.swift
//  ToDo List
//
//  Created by Никита Волков on 25.01.2025.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var checkMarkButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 24).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
        $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        $0.tintColor = .yellow
        return $0
    }(UIButton())
    
    var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.text = "Test String"
        $0.textColor = .white
        return $0
    }(UILabel())
    
    var descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 12, weight: .light)
        $0.textColor = .white
        $0.text = "Test description"
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    var dateLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 12, weight: .light)
        $0.textColor = .gray
        $0.text = "02/10/24"
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        coinfigureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func coinfigureSubviews() {
        contentView.addSubview(checkMarkButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            checkMarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkMarkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkMarkButton.leadingAnchor, constant: 32),
            titleLabel.topAnchor.constraint(equalTo: checkMarkButton.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

}
