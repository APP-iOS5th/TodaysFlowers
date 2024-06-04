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
        mainContentLabel.buildLabel(by: .description, with: "아잘레아는 사계성 품종들이 많이 나와 있으며 특히 겨울철 실내 분화용으로 많이 이용하고 있다. 꽃색은 빨간 것들이 주종을 이루며, 최근에는 끝에 흰줄이 들어가 있는 복색도 나오고 보다 연한 핑크계통인 품종들도 많다.")
        
        return mainContentLabel
    }()
    
    private lazy var typeTitleLabel: UILabel = {
        let typeTitleLabel = UILabel()
        typeTitleLabel.buildLabel(by: .title, with: "꽃 자생처")
        
        return typeTitleLabel
    }()
    
    private lazy var typeDescriptionLabel: UILabel = {
        let typeContentLabel = UILabel()
        typeContentLabel.buildLabel(by: .description, with: "철쭉과에 속하는 식물은 지구상에서 극지방을 제외하고 널리 분포하여 전 세계적으로 약 100속 3000여종이 자생하고 있다. 여기서 철쭉속에 속하는 식물만 하더라도 대가족으로써 딸린 식구들이 약 800∼1000종이나 되는데 중국대륙에 자생하는 것들이 많으며 유럽에서 오래 전에 이들을 도입하어 분화용 원예품종으로 개발하여 전 세계적으로 공급하고 있다.")
        
        return typeContentLabel
    }()
    
    private lazy var growTitleLabel: UILabel = {
        let growTitleLabel = UILabel()
        growTitleLabel.buildLabel(by: .title, with: "꽃 기르는 법")
        
        return growTitleLabel
    }()
    
    private lazy var growDescriptionLabel: UILabel = {
        let growDescriptionLabel = UILabel()
        growDescriptionLabel.buildLabel(by: .description, with: "아잘레아는 삽목이 잘 되고 생육기간도 짧으며 병충해에도 강해 현재 국내 화목류 생산량 중에서 단연 우위를 차지하고 있다. 삽목으로 번식이 용이하고 반그늘에서 마르지 않게만 관리하면 된다.")
        
        return growDescriptionLabel
    }()
    
    private lazy var usageTitleLabel: UILabel = {
        let usageTitleLabel = UILabel()
        usageTitleLabel.buildLabel(by: .title, with: "꽃 용도")
        
        return usageTitleLabel
    }()
    
    private lazy var usageDescriptionLabel: UILabel = {
        let usageDescriptionLabel = UILabel()
        usageDescriptionLabel.buildLabel(by: .description, with: "아잘레아는 사계성 품종들이 많이 나와 있으며 특히 겨울철 실내 분화용으로 많이 이용하고 있다. 꽃색은 빨간 것들이 주종을 이루며, 최근에는 끝에 흰줄이 들어가 있는 복색도 나오고 있고, 보다 연한 핑크계통인 품종들도 많다.")
        
        return usageDescriptionLabel
    }()
    
    // MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
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
    
    func setupViews(with flower: Flower) {
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
            mainTitleLabel.topAnchor.constraint(equalTo: margin.topAnchor),
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

#Preview {
    FlowerContentView()
}
