//
//  ImageGalleryViewController.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import UIKit
import VisionKit

final class ImageGalleryViewController: UIViewController {
    // MARK: - Components
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        
        return activityIndicator
    }()
    
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
    
    private lazy var editButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "edit"
        
        return UIButton(configuration: configuration)
    }()
    
    private lazy var imageViews: [UIImageView] = []
    
    private let viewModel: ImageGalleryViewModel
    private var originFrame: CGRect = .zero
    
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
            with: viewModel.imageViews,
            selectedIndex: viewModel.selectedIndex
        )
        
        configurePanGesture()
        configureButton()
        configureImageViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            startProcessing()
            await analyze(imageViews: imageViews)
            stopProcessing()
        }
    }
    
    private func analyze(imageViews: [UIImageView]) async {
        await withTaskGroup(of: Void.self) { group in
            for imageView in imageViews {
                group.addTask {
                    await self.analyze(imageView: imageView)
                }
            }
        }
    }
    
    private func analyze(imageView: UIImageView) async {
        let interaction = ImageAnalysisInteraction()
        let analyzer = ImageAnalyzer()
        if let image = imageView.image {
            imageView.addInteraction(interaction)
            let configuration = ImageAnalyzer.Configuration([.visualLookUp])
            let analysis = try? await analyzer.analyze(image, configuration: configuration)
            if let analysis = analysis {
                interaction.analysis = analysis
                interaction.preferredInteractionTypes = .imageSubject
            }
        }
    }
    
    private func startProcessing() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    private func stopProcessing() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }

    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(imageScrollView)
        view.addSubview(pageControl)
        view.addSubview(editButton)
        view.addSubview(activityIndicator)
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let global = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageScrollView.leadingAnchor.constraint(equalTo: global.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: global.trailingAnchor),
            imageScrollView.heightAnchor.constraint(equalTo: global.widthAnchor),
            imageScrollView.centerYAnchor.constraint(equalTo: global.centerYAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant:  -15),
            pageControl.centerXAnchor.constraint(equalTo: global.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            
            editButton.centerXAnchor.constraint(equalTo: global.centerXAnchor),
            editButton.bottomAnchor.constraint(equalTo: global.bottomAnchor, constant: -30),
            
            activityIndicator.centerXAnchor.constraint(equalTo: global.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: global.centerYAnchor),
        ])
    }
    
    private func configureImageScrollView(with imageViews: [UIImageView], selectedIndex: Int) {
        imageScrollView.delegate = self
        
        for subviews in imageScrollView.subviews {
            subviews.removeFromSuperview()
        }

        for imageView in imageViews {
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            self.imageViews.append(imageView)
            imageScrollView.addSubview(imageView)
        }
        pageControl.numberOfPages = imageViews.count
        pageControl.currentPage = selectedIndex
    }
    
    private func configurePanGesture() {
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePullToDismiss(_:))
        )
        view.addGestureRecognizer(panGesture)
    }
    
    private func configureButton() {
        editButton.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }
                let currentPage = self.pageControl.currentPage
                guard let currentImage = imageViews[currentPage].image else {
                    return
                }
                let viewModel = ImageEditViewModel(originalImage: currentImage)
                let viewController = ImageEditViewController(viewModel: viewModel)
                self.present(viewController, animated: true)
            },
            for: .touchUpInside
        )
    }
    
    private func configureImageViews() {
        imageScrollView.layoutIfNeeded()
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
    }
    
    @objc private func handlePullToDismiss(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case .began:
                originFrame = view.frame
            case .changed:
                let translation = gesture.translation(in: view)
                
                if abs(translation.y) > abs(translation.x),
                   translation.y > 0
                {
                    let ratio = (originFrame.height - translation.y) / originFrame.height
                    if ratio < 0.8 {
                        dismiss(animated: true)
                    }
                    view.layer.cornerRadius = 20
                    view.transform = CGAffineTransform(scaleX: ratio, y: ratio)
                }
            case .ended:
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: .zero) {
                    self.view.layer.cornerRadius = 0
                    self.view.transform = .identity
                }
            default:
                return
        }
    }
}

extension ImageGalleryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
