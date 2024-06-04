//
//  SearchTableViewCell.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/4/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    private lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        return nameLabel
    }()
    
    private lazy var langLabel: UILabel = {
        let langLabel = UILabel()
        langLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return langLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(thumbnailView)
        addSubview(nameLabel)
        addSubview(langLabel)
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        langLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        let marginGuide = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            thumbnailView.widthAnchor.constraint(equalToConstant: 90),
            thumbnailView.heightAnchor.constraint(equalToConstant: 90),
            
            nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -8),
            
            langLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            langLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            langLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -8),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(flower: Flower) {
        thumbnailView.image = UIImage(data: flower.imageData[0])
        nameLabel.text = flower.name
        langLabel.text = flower.lang
    }
    
}
