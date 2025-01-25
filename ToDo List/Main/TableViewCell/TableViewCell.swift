//
//  TableViewCell.swift
//  ToDo List
//
//  Created by Никита Волков on 25.01.2025.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var checkBoxOutlet: UIButton! {
            didSet {
                checkBoxOutlet.setImage(UIImage(named:"unchecked"), for: .normal)
                checkBoxOutlet.setImage(UIImage(named:"checked"), for: .selected)
            }
    }
    
    var titleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        addTitle()
        addCheckBox()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addTitle() {
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.text = "kdfsslkfdlskdf;lskf;lskdf,l"
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    func addCheckBox() {
        checkBoxOutlet = UIButton()
        checkBoxOutlet.setImage(UIImage(named: "checkmark.circle"), for: .normal)
        checkBoxOutlet.backgroundColor = .white
        self.addSubview(checkBoxOutlet)
        checkBoxOutlet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkBoxOutlet.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            checkBoxOutlet.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }

}
