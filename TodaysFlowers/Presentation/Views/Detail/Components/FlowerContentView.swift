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
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
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
        scrollView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let contentLength = scrollView.frame.width
        scrollView.contentSize = CGSize(
            width: contentLength * CGFloat(pageControl.numberOfPages),
            height: contentLength
        )
        
        for (index, subview) in scrollView.subviews.enumerated() {
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
        
        for imageData in flower.imageData {
            let imageView = UIImageView(image: UIImage(data: imageData))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            scrollView.addSubview(imageView)
        }
        pageControl.numberOfPages = flower.imageData.count
    }
    
    private func configureUI() {
        backgroundColor = .white
        addSubview(scrollView)
        addSubview(pageControl)
        addSubview(mainTitleLabel)
        addSubview(subTitleLabel)
        addSubview(mainDescriptionLabel)
        addSubview(typeTitleLabel)
        addSubview(typeDescriptionLabel)
        addSubview(growTitleLabel)
        addSubview(growDescriptionLabel)
        addSubview(usageTitleLabel)
        addSubview(usageDescriptionLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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
        
        let margin = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: margin.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: widthAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            
            mainTitleLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            mainTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            mainDescriptionLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor),
            mainDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            mainDescriptionLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            typeTitleLabel.topAnchor.constraint(equalTo: mainDescriptionLabel.bottomAnchor),
            typeTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            typeTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            typeDescriptionLabel.topAnchor.constraint(equalTo: typeTitleLabel.bottomAnchor),
            typeDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            typeDescriptionLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            growTitleLabel.topAnchor.constraint(equalTo: typeDescriptionLabel.bottomAnchor),
            growTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            growTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            growDescriptionLabel.topAnchor.constraint(equalTo: growTitleLabel.bottomAnchor),
            growDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            growDescriptionLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            usageTitleLabel.topAnchor.constraint(equalTo: growDescriptionLabel.bottomAnchor),
            usageTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            usageTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            usageDescriptionLabel.topAnchor.constraint(equalTo: usageTitleLabel.bottomAnchor),
            usageDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            usageDescriptionLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
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
