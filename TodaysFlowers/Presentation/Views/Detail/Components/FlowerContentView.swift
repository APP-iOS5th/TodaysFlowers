//
//  FlowerContentView.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import UIKit

final class FlowerContentView: UIView {
    // MARK: - Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var imageScrollView: UIScrollView = {
        let imageScrollView = UIScrollView()
        imageScrollView.isPagingEnabled = true
        imageScrollView.showsHorizontalScrollIndicator = false
        
        return imageScrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.backgroundStyle = .prominent
        
        return pageControl
    }()
    
    private lazy var mainTitleLabel: UILabel = {
        let mainTitleLabel = UILabel()
        mainTitleLabel.text = "아젤레아"
        mainTitleLabel.textColor = UIColor(named: "FlowerColor")!
        mainTitleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        return mainTitleLabel
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.text = "사랑의 기쁨"
        subTitleLabel.textColor = UIColor(named: "FlowerColor")!
        subTitleLabel.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        
        return subTitleLabel
    }()
    
    private lazy var mainDescriptionLabel: UILabel = {
        let mainContentLabel = UILabel()
        mainContentLabel.buildLabel(by: .description, with: "")
        
        return mainContentLabel
    }()
    
    private lazy var typeTitleLabel: UILabel = {
        let typeTitleLabel = UILabel()
        typeTitleLabel.buildLabel(by: .title, with: "꽃 자생처")
        
        return typeTitleLabel
    }()
    
    private lazy var typeDescriptionLabel: UILabel = {
        let typeContentLabel = UILabel()
        typeContentLabel.buildLabel(by: .description, with: "")
        
        return typeContentLabel
    }()
    
    private lazy var growTitleLabel: UILabel = {
        let growTitleLabel = UILabel()
        growTitleLabel.buildLabel(by: .title, with: "꽃 기르는 법")
        
        return growTitleLabel
    }()
    
    private lazy var growDescriptionLabel: UILabel = {
        let growDescriptionLabel = UILabel()
        growDescriptionLabel.buildLabel(by: .description, with: "")
        
        return growDescriptionLabel
    }()
    
    private lazy var usageTitleLabel: UILabel = {
        let usageTitleLabel = UILabel()
        usageTitleLabel.buildLabel(by: .title, with: "꽃 용도")
        
        return usageTitleLabel
    }()
    
    private lazy var usageDescriptionLabel: UILabel = {
        let usageDescriptionLabel = UILabel()
        usageDescriptionLabel.buildLabel(by: .description, with: "")
        
        return usageDescriptionLabel
    }()
    
    // MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        imageScrollView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentLength = imageScrollView.frame.width
        guard contentLength > 0 else { return }
        
        imageScrollView.contentSize = CGSize(
            width: contentLength * CGFloat(pageControl.numberOfPages),
            height: contentLength
        )
        
        for (index, subview) in imageScrollView.subviews.enumerated() {
            subview.frame = CGRect(
                x: CGFloat(index) * contentLength,
                y: 0,
                width: contentLength,
                height: contentLength
            )
        }
    }
    
    func configureViewContents(with flower: Flower) {
        mainTitleLabel.text = flower.name
        mainDescriptionLabel.text = flower.content
        typeDescriptionLabel.text = flower.type
        growDescriptionLabel.text = flower.grow
        usageDescriptionLabel.text = flower.usage
        
        for subview in imageScrollView.subviews {
            subview.removeFromSuperview()
        }
        
        for imageData in flower.imageData {
            let imageView = UIImageView(image: UIImage(data: imageData))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            imageScrollView.addSubview(imageView)
        }
        pageControl.numberOfPages = flower.imageData.count
        layoutSubviews()
    }
    
    private func configureUI() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageScrollView)
        contentView.addSubview(pageControl)
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(mainDescriptionLabel)
        contentView.addSubview(typeTitleLabel)
        contentView.addSubview(typeDescriptionLabel)
        contentView.addSubview(growTitleLabel)
        contentView.addSubview(growDescriptionLabel)
        contentView.addSubview(usageTitleLabel)
        contentView.addSubview(usageDescriptionLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        typeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        typeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        growTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        growDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        usageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        usageDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageScrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageScrollView.heightAnchor.constraint(equalTo: widthAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: -15),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            
            mainTitleLabel.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor),
            mainTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            mainDescriptionLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor),
            mainDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            typeTitleLabel.topAnchor.constraint(equalTo: mainDescriptionLabel.bottomAnchor),
            typeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            typeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            typeDescriptionLabel.topAnchor.constraint(equalTo: typeTitleLabel.bottomAnchor, constant: 400),
            typeDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            typeDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            growTitleLabel.topAnchor.constraint(equalTo: typeDescriptionLabel.bottomAnchor),
            growTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            growTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            growDescriptionLabel.topAnchor.constraint(equalTo: growTitleLabel.bottomAnchor),
            growDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            growDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            usageTitleLabel.topAnchor.constraint(equalTo: growDescriptionLabel.bottomAnchor),
            usageTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            usageTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            usageDescriptionLabel.topAnchor.constraint(equalTo: usageTitleLabel.bottomAnchor),
            usageDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            usageDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            usageDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

extension FlowerContentView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

#Preview {
    let vc = FlowerContentView()
    
    vc.configureViewContents(with: FlowerStubs.flower)
    
    return vc
}
