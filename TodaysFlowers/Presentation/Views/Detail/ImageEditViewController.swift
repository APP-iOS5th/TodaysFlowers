//
//  ImageEditViewController.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/11/24.
//

import UIKit
import Combine

final class ImageEditViewController: UIViewController {
    private lazy var backgroundMenuItems: [UIAction] = {
        let original = UIAction(
            title: "original"
        ) { [weak self] _ in
            self?.viewModel.changeBackgroundEffect(to: .original)
        }
        
        let transparent = UIAction(
            title: "transparent"
        ) { [weak self] _ in
            self?.viewModel.changeBackgroundEffect(to: .transparent)
        }
        
        return [original, transparent]
    }()
    
    private lazy var imageEffectMenuItems: [UIAction] = {
        let none = UIAction(
            title: "none"
        ) { [weak self] _ in
            self?.viewModel.changeImageEffect(to: .none)
        }
        
        let highlight = UIAction(
            title: "highlight"
        ) { [weak self] _ in
            self?.viewModel.changeImageEffect(to: .highlight)
        }
        
        let bokeh = UIAction(
            title: "bokeh"
        ) { [weak self] _ in
            self?.viewModel.changeImageEffect(to: .bokeh)
        }
        
        return [none, highlight, bokeh]
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var backgroundButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Change Background"
        
        return UIButton(configuration: configuration)
    }()
    
    private lazy var imageEffectButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Change Image Effect"
        
        return UIButton(configuration: configuration)
    }()
    
    private let viewModel: ImageEditViewModel
    private var disposableBag = Set<AnyCancellable>()
    
    init(viewModel: ImageEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let backgroundMenu = UIMenu(title: "background", children: backgroundMenuItems)
        backgroundButton.menu = backgroundMenu
        backgroundButton.showsMenuAsPrimaryAction = true
        
        let imageMenu = UIMenu(title: "image", children: imageEffectMenuItems)
        imageEffectButton.menu = imageMenu
        imageEffectButton.showsMenuAsPrimaryAction = true
        
        view.addSubview(imageView)
        view.addSubview(backgroundButton)
        view.addSubview(imageEffectButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundButton.translatesAutoresizingMaskIntoConstraints = false
        imageEffectButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            backgroundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            imageEffectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageEffectButton.topAnchor.constraint(equalTo: backgroundButton.bottomAnchor, constant: 10)
            
        ])
        
        bind()
    }
    
    private func bind() {
        viewModel
            .$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.imageView.image = image
            }
            .store(in: &disposableBag)
    }
}
