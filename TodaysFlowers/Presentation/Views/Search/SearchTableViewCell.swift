//
//  SearchTableViewCell.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/4/24.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "flowerCell"
    
    private lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        nameLabel.textColor = UIColor(named: "FlowerColor")!
        return nameLabel
    }()
    
    private lazy var flowerLangLabel: UILabel = {
        let flowerLangLabel = UILabel()
        flowerLangLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        flowerLangLabel.textColor = .gray
        return flowerLangLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(thumbnailView)
        addSubview(nameLabel)
        addSubview(flowerLangLabel)
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        flowerLangLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        let marginGuide = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            thumbnailView.widthAnchor.constraint(equalToConstant: 90),
            
            nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -8),
            
            flowerLangLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            flowerLangLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            flowerLangLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(flower: Flower) {
        thumbnailView.asyncImage(urlString: flower.imageUrlString[0])
        nameLabel.text = flower.name
        flowerLangLabel.text = flower.lang
    }
}
