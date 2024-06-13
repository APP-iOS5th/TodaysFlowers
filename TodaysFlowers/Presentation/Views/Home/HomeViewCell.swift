//
//  HomeViewCell.swift
//  TodaysFlowers
//
//  Created by 황민경 on 6/10/24.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    static let identifier = "FlowerCell"
    private let flowerImageView = UIImageView()
    private let barView = UIView()
    private let nameLabel = UILabel()
    private let langLabel = UILabel()
    private let dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        flowerImageView.contentMode = .scaleAspectFill
        flowerImageView.clipsToBounds = true
        flowerImageView.layer.cornerRadius = 12
        contentView.addSubview(flowerImageView)
        
        barView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        contentView.addSubview(barView)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = .white
        contentView.addSubview(nameLabel)
        
        langLabel.font = UIFont.systemFont(ofSize: 14)
        langLabel.textColor = .white
        contentView.addSubview(langLabel)
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .white
        contentView.addSubview(dateLabel)
        
        flowerImageView.translatesAutoresizingMaskIntoConstraints = false
        barView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        langLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flowerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            flowerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flowerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flowerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            barView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 180),
            barView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            barView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 80),
            
            langLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            langLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 105),
        
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 105),

        ])
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    
    func configure(with flower: Flower) {
        if let imageData = flower.imageData.first, let image = UIImage(data: imageData) {
            flowerImageView.image = image
        } else {
            flowerImageView.image = UIImage(named: "defaultImage") // 기본 이미지 설정
        }
        nameLabel.text = flower.name
        langLabel.text = flower.lang
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        dateLabel.text = dateFormatter.string(from: flower.date)
    }
}
