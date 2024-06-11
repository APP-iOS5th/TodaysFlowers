//
//  ImageGalleryViewModel.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import Foundation

final class ImageGalleryViewModel {
    private(set) var imagesData: [Data]
    private(set) var selectedIndex: Int
    
    init(imagesData: [Data], selectedIndex: Int) {
        self.imagesData = imagesData
        self.selectedIndex = selectedIndex
    }
}
