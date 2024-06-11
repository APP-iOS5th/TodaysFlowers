//
//  FlowerContentView.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import UIKit

final class FlowerContentView: UIView {
    // MARK: - Components
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private(set) lazy var imageScrollView: UIScrollView = {
        let imageScrollView = UIScrollView()
        imageScrollView.isPagingEnabled = true
        imageScrollView.showsHorizontalScrollIndicator = false
        
        return imageScrollView
    }()
    
    private(set) lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.backgroundStyle = .prominent
        
        return pageControl
    }()
    
    private lazy var mainTitleLabel: UILabel = {
        let mainTitleLabel = UILabel()
        mainTitleLabel.textColor = UIColor(named: "FlowerColor")!
        mainTitleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        return mainTitleLabel
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.textColor = UIColor(named: "FlowerColor")!
        subTitleLabel.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        
        return subTitleLabel
    }()
    
    private lazy var mainDescriptionLabel: UILabel = {
        let mainContentLabel = UILabel()
        mainContentLabel.buildLabel(by: .description, with: .empty)
        
        return mainContentLabel
    }()
    
    private lazy var typeTitleLabel: UILabel = {
        let typeTitleLabel = UILabel()
        typeTitleLabel.buildLabel(by: .title, with: .typeTitle)
        
        return typeTitleLabel
    }()
    
    private lazy var typeDescriptionLabel: UILabel = {
        let typeContentLabel = UILabel()
        typeContentLabel.buildLabel(by: .description, with: .empty)
        
        return typeContentLabel
    }()
    
    private lazy var growTitleLabel: UILabel = {
        let growTitleLabel = UILabel()
        growTitleLabel.buildLabel(by: .title, with: .growTitle)
        
        return growTitleLabel
    }()
    
    private lazy var growDescriptionLabel: UILabel = {
        let growDescriptionLabel = UILabel()
        growDescriptionLabel.buildLabel(by: .description, with: .empty)
        
        return growDescriptionLabel
    }()
    
    private lazy var usageTitleLabel: UILabel = {
        let usageTitleLabel = UILabel()
        usageTitleLabel.buildLabel(by: .title, with: .usageTitle)
        
        return usageTitleLabel
    }()
    
    private lazy var usageDescriptionLabel: UILabel = {
        let usageDescriptionLabel = UILabel()
        usageDescriptionLabel.buildLabel(by: .description, with: .empty)
        
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
        subTitleLabel.text = flower.lang
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
        layoutIfNeeded()
    }
    
    func updateCurrentPage(to index: Int) {
        pageControl.currentPage = index
        imageScrollView.contentOffset.x = imageScrollView.frame.width * CGFloat(index)
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
        
        contentView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        let margin = contentView.layoutMarginsGuide
        
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
            
            mainTitleLabel.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 20),
            mainTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            mainTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: Spacing.small.rawValue),
            subTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            mainDescriptionLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: Spacing.medium.rawValue),
            mainDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            mainDescriptionLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            typeTitleLabel.topAnchor.constraint(equalTo: mainDescriptionLabel.bottomAnchor, constant: Spacing.large.rawValue),
            typeTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            typeTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            typeDescriptionLabel.topAnchor.constraint(equalTo: typeTitleLabel.bottomAnchor, constant: Spacing.medium.rawValue),
            typeDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            typeDescriptionLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            growTitleLabel.topAnchor.constraint(equalTo: typeDescriptionLabel.bottomAnchor, constant: Spacing.large.rawValue),
            growTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            growTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            growDescriptionLabel.topAnchor.constraint(equalTo: growTitleLabel.bottomAnchor, constant: Spacing.medium.rawValue),
            growDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            growDescriptionLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            usageTitleLabel.topAnchor.constraint(equalTo: growDescriptionLabel.bottomAnchor, constant: Spacing.large.rawValue),
            usageTitleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            usageTitleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            usageDescriptionLabel.topAnchor.constraint(equalTo: usageTitleLabel.bottomAnchor, constant: Spacing.medium.rawValue),
            usageDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            usageDescriptionLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            usageDescriptionLabel.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
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
