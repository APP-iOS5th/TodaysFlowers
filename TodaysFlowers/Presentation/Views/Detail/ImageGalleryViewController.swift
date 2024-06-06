//
//  ImageGalleryViewController.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import UIKit

final class ImageGalleryViewController: UIViewController {
    // MARK: - Components
    private lazy var imageScrollView: UIScrollView = {
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
    
    private let viewModel: ImageGalleryViewModel
    
    init(viewModel: ImageGalleryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureImageScrollView(
            with: viewModel.imagesData,
            selectedIndex: viewModel.selectedIndex
        )
        
        imageScrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let contentLength = imageScrollView.frame.width
        
        imageScrollView.contentSize = CGSize(
            width: contentLength * CGFloat(3),
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
        imageScrollView.contentOffset.x =  contentLength * CGFloat(viewModel.selectedIndex)
        
        print("in layout subview will: ", pageControl.currentPage)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(imageScrollView)
        view.addSubview(pageControl)
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        let global = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageScrollView.leadingAnchor.constraint(equalTo: global.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: global.trailingAnchor),
            imageScrollView.heightAnchor.constraint(equalTo: global.widthAnchor),
            imageScrollView.centerYAnchor.constraint(equalTo: global.centerYAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant:  -15),
            pageControl.centerXAnchor.constraint(equalTo: global.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
    private func configureImageScrollView(with imagesData: [Data], selectedIndex: Int) {
        for subviews in imageScrollView.subviews {
            subviews.removeFromSuperview()
        }
        
        for imageData in imagesData {
            let imageView = UIImageView(image: UIImage(data: imageData))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            imageScrollView.addSubview(imageView)
        }
        pageControl.numberOfPages = imagesData.count
        pageControl.currentPage = selectedIndex
    }
}

extension ImageGalleryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
