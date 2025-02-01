//
//  TableViewCell.swift
//  ToDo List
//
//  Created by Никита Волков on 25.01.2025.
//

import UIKit

// MARK: TableViewCell
// Class with custom cell of TableView for making methods for interaction with user and Data like press Checkmark-button or edit some data in task

class TableViewCell: UITableViewCell {
    
    var taskDone = false {
        didSet {
            changeCheckmarkButtonImage()
        }
    }
    weak var ownerTableView: UITableView!
    
    var toDoItem: ToDoDataItem!

    var checkMarkButton: UIButton!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var dateLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        coinfigureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        if !taskDone {
            super.prepareForReuse()
        }
    }

}


// MARK: Checkmark Methods
extension TableViewCell {
    
    @objc fileprivate func pressCheckMarkButton(sender: UIButton!) {
        taskDone = !taskDone
        
        guard let viewController = ownerTableView.delegate as? MainViewController else { return }
        viewController.presenter.interactor.updateToDoData(
            toDoItem: toDoItem,
            completed: taskDone,
            taskDescription: nil
        )
        
        DispatchQueue.main.async {
            self.changeCheckmarkButtonImage()
            self.ownerTableView.reloadData()
        }
    }
    
    fileprivate func changeCheckmarkButtonImage() {
        
        if taskDone {
            self.checkMarkButton.setImage(
                UIImage(systemName: "checkmark.circle"),
                for: .normal
            )
            self.checkMarkButton.tintColor = .systemYellow
            crossTitleAndDescriptionText()
        } else {
            self.checkMarkButton.setImage(
                UIImage(systemName: "circle"),
                for: .normal
            )
            self.checkMarkButton.tintColor = .systemGray
            cancelCrossTitleText()
        }
    }
    
    private func crossTitleAndDescriptionText() {
        guard let titleText = titleLabel.text else { return }
        var attributedString = NSMutableAttributedString(string: titleText)
        attributedString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.systemGray,
            range: NSRange(location: 0, length: attributedString.length)
        )
        titleLabel.attributedText = attributedString
        
        guard let descriptionText = descriptionLabel.text else { return }
        attributedString = NSMutableAttributedString(string: descriptionText)
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.systemGray,
            range: NSRange(location: 0, length: attributedString.length)
        )
        descriptionLabel.attributedText = attributedString
    }
    
    private func cancelCrossTitleText() {
        guard let titleText = titleLabel.text else { return }
        var attrbutedString = NSMutableAttributedString(string: titleText)
        attrbutedString.addAttribute(
            .strikethroughStyle,
            value: NSNumber(value: 0),
            range: NSRange(location: 0, length: attrbutedString.length)
        )
        attrbutedString.addAttribute(
            .foregroundColor,
            value: UIColor.white,
            range: NSRange(location: 0, length: attrbutedString.length)
        )
        titleLabel.attributedText = attrbutedString
        
        guard let descriptionText = descriptionLabel.text else { return }
        attrbutedString = NSMutableAttributedString(string: descriptionText)
        attrbutedString.addAttribute(
            .foregroundColor,
            value: UIColor.white,
            range: NSRange(location: 0, length: attrbutedString.length)
        )
        descriptionLabel.attributedText = attrbutedString
    }
    
}

// MARK: Cell's UI
extension TableViewCell {
    
    fileprivate func coinfigureSubviews() {
        
        checkMarkButton = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: 24).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
            $0.setImage(UIImage(systemName: "circle"), for: .normal)
            $0.tintColor = .systemGray
            $0.addTarget(self, action: #selector(pressCheckMarkButton), for: .touchUpInside)
            return $0
        }(UIButton())
        
        titleLabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.text = "Title"
            $0.textColor = .white
            return $0
        }(UILabel())
        
        descriptionLabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = .systemFont(ofSize: 12, weight: .light)
            $0.textColor = .white
            $0.text = ""
            $0.numberOfLines = 2
            return $0
        }(UILabel())
        
        dateLabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = .systemFont(ofSize: 12, weight: .light)
            $0.textColor = .gray
            $0.text = "02/10/24"
            return $0
        }(UILabel())
        
        contentView.addSubview(checkMarkButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
    }
    
}


// MARK: Layout

extension TableViewCell {
    
    fileprivate func configureConstraints() {
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
