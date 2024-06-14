//
//  ImageGalleryViewModel.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import UIKit

final class ImageGalleryViewModel {
    private(set) var imageViews: [UIImageView]
    private(set) var selectedIndex: Int
    
    init(imageViews: [UIImageView], selectedIndex: Int) {
        self.imageViews = imageViews
        self.selectedIndex = selectedIndex
    }
}
