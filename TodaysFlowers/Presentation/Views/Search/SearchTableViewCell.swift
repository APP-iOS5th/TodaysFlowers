//
//  SearchTableViewCell.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/4/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(flower: Flower) {
        nameLabel.text = flower.name
    }
    
}
