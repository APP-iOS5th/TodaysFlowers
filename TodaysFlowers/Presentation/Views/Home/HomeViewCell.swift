//
//  HomeViewCell.swift
//  TodaysFlowers
//
//  Created by 황민경 on 6/10/24.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    private let flowerImageView = UIImageView()
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
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .white
        contentView.addSubview(nameLabel)
        
        langLabel.font = UIFont.systemFont(ofSize: 14)
        langLabel.textColor = .white
        contentView.addSubview(langLabel)
        
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .white
        contentView.addSubview(dateLabel)
        
        flowerImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        langLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flowerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            flowerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flowerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flowerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
//            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40), // 위쪽 여백을 8포인트로 설정하여 이름 레이블을 상단에 배치
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), // 왼쪽 여백을 8포인트로 설정
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), // 오른쪽 여백을 8포인트로 설정
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            
            langLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5), // 이름 레이블 아래에 4포인트의 여백을 추가하여 꽃말 레이블을 배치
            langLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), // 왼쪽 여백을 8포인트로 설정합니다.
            langLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -25), // 날짜 레이블의 왼쪽 여백을 8포인트로 설정하여 이름 레이블과 함께 배치
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 225), // langLabel과 같은 수평선에 배치
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), // 오른쪽 여백을 8포인트로 설정
//            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25), // 하단 여백을 8포인트로 설정
//            dateLabel.widthAnchor.constraint(equalToConstant: 50),
//            dateLabel.heightAnchor.constraint(equalToConstant: 50),
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
//        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MMM d"
        dateLabel.text = dateFormatter.string(from: flower.date)
    }
}
