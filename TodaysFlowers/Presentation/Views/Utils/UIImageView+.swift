//
//  UIImageView+.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/13/24.
//

import UIKit

extension UIImageView {
    func asyncImage(urlString: String) {
        Task { @MainActor in
            self.image = await ImageLoader.shared.loadData(with: urlString)
        }
    }
    
    func clone() -> UIImageView {
        guard let cgImage = self.image?.cgImage?.copy() else {
            return .init()
        }
        return UIImageView(
            image: UIImage(
                cgImage: cgImage,
                scale: self.image!.scale,
                orientation: self.image!.imageOrientation
            )
        )
    }
}

