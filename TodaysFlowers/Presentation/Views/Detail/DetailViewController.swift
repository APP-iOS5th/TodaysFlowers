//
//  DetailViewController.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
    
    // MARK: - Components
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        
        return activityIndicator
    }()
    
    private(set) lazy var flowerContentView = FlowerContentView()
    
    private let viewModel: DetailViewModel
    private var disposableBag = Set<AnyCancellable>()
    private let galleryAnimationManager = GalleryAnimationManager()
    private var originFrame: CGRect = .zero
    
    init(viewModel: DetailViewModel) {
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
        configureTapGesture()
        flowerContentView.scrollView.delegate = self
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startProcessing()
        viewModel.fetchFlower()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        originFrame = view.frame
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(flowerContentView)
        view.addSubview(activityIndicator)
        
        flowerContentView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let global = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            flowerContentView.topAnchor.constraint(equalTo: global.topAnchor),
            flowerContentView.leadingAnchor.constraint(equalTo: global.leadingAnchor),
            flowerContentView.trailingAnchor.constraint(equalTo: global.trailingAnchor),
            flowerContentView.bottomAnchor.constraint(equalTo: global.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: global.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: global.centerYAnchor),
        ])
    }
    
    private func bind() {
        viewModel
            .$flower
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] flower in
                self?.flowerContentView.configureViewContents(with: flower)
                self?.stopProcessing()
            }
            .store(in: &disposableBag)
    }
    
    private func startProcessing() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        flowerContentView.alpha = 0
    }
    
    private func stopProcessing() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) { [weak self] in
            self?.flowerContentView.alpha = 1
        }
    }
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        flowerContentView.imageScrollView.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let viewController = ImageGalleryViewController(
            viewModel: ImageGalleryViewModel(
                imagesData: viewModel.flower.imageData,
                selectedIndex: flowerContentView.pageControl.currentPage
            )
        )
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = galleryAnimationManager
        present(viewController, animated: true)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            let ratio = (originFrame.height + scrollView.contentOffset.y) / originFrame.height
            if ratio < 0.88 {
                dismiss(animated: true)
            }
            view.layer.cornerRadius = 20
            view.transform = CGAffineTransform(scaleX: ratio, y: ratio)
            view.alpha = ratio
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: .zero) {
            self.view.layer.cornerRadius = 0
            self.view.transform = .identity
            self.view.alpha = 1.0
        }
    }
}
