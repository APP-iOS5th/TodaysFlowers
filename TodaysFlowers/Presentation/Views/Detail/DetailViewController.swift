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
    
    private lazy var flowerContentView = FlowerContentView()
    private(set) lazy var flowerContentView = FlowerContentView()
    
    private let viewModel: DetailViewModel
    private var disposableBag = Set<AnyCancellable>()
    
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
        bind()
        configureTapGesture()
        
        startProcessing()
        viewModel.fetchFlower()
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
        
        present(viewController, animated: true)
    }
}

#Preview {
    let viewModel = DetailViewModel(flowerId: 45, useCase: DetailViewUseCaseStub())
    let viewController = DetailViewController(viewModel: viewModel)
    
    return viewController
}
