//
//  ImageEditViewModel.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/11/24.
//

import UIKit
import Combine
import Vision
import CoreImage.CIFilterBuiltins

final class ImageEditViewModel {
    enum BackgroundEffect: String, CaseIterable {
        case original
        case transparent
    }
    
    enum ImageEffect: String, CaseIterable {
        case none
        case highlight
        case bokeh
    }
    
    @Published private(set) var image: UIImage = UIImage()
    
    private var disposableBag = Set<AnyCancellable>()
    
    private var originalImage: CurrentValueSubject<UIImage, Never>
    private var backgroundEffect = CurrentValueSubject<BackgroundEffect, Never>(.original)
    private var imageEffect = CurrentValueSubject<ImageEffect, Never>(.none)

    init(originalImage: UIImage) {
        self.originalImage = CurrentValueSubject(originalImage)
        self.image = originalImage

        Publishers
            .CombineLatest3(
                self.originalImage,
                self.backgroundEffect,
                self.imageEffect
            )
            .sink { [weak self] (inputImage, backgroundEffect, imageEffect) in
                self?.generateImage(
                    usingInputImage: CIImage(image: inputImage)!,
                    backgroundEffect: backgroundEffect,
                    imageEffect: imageEffect
                )
            }
            .store(in: &disposableBag)
    }
    
    func changeBackgroundEffect(to effect: BackgroundEffect) {
        backgroundEffect.send(effect)
    }
    
    func changeImageEffect(to effect: ImageEffect) {
        imageEffect.send(effect)
    }
    
    private func generateImage(
        usingInputImage inputImage: CIImage,
        backgroundEffect: BackgroundEffect,
        imageEffect: ImageEffect
    ) {
        guard let mask = subjectMask(fromImage: inputImage) else {
            return
        }
        
        let backgroundImage = image(forBackground: backgroundEffect, inputImage: inputImage)
            .cropped(to: inputImage.extent)
        
        let composited = apply(
            toInputImage: inputImage,
            background: backgroundImage,
            imageEffect: imageEffect,
            mask: mask
        )
        
        image = UIImage(ciImage: composited)
    }
    
    private func subjectMask(fromImage image: CIImage) -> CIImage? {
        let request = VNGenerateForegroundInstanceMaskRequest()
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            debugPrint("VNImageRequestHandler perform failed.")
            return nil
        }
        
        guard let result = request.results?.first else {
            debugPrint("No subject observation found.")
            return nil
        }
        
        let instances = result.allInstances
        
        do {
            let mask = try result.generateScaledMaskForImage(forInstances: instances, from: handler)
            return CIImage(cvPixelBuffer: mask)
        } catch {
            debugPrint("Failed to generate subject mask.")
            return nil
        }
    }
    
    private func image(forBackground backgroundEffect: BackgroundEffect, inputImage: CIImage) -> CIImage {
        switch backgroundEffect {
            case .original:
                return inputImage
            case .transparent:
                return CIImage(color: .clear)
        }
    }
    
    private func apply(
        toInputImage inputImage: CIImage,
        background: CIImage,
        imageEffect: ImageEffect,
        mask: CIImage
    ) -> CIImage {
        var postEffectBackground = background
        
        switch imageEffect {
            case .none:
                break
            case .highlight:
                let filter = CIFilter.exposureAdjust()
                filter.inputImage = background
                filter.ev = -3
                postEffectBackground = filter.outputImage!
            case .bokeh:
                let filter = CIFilter.bokehBlur()
                filter.inputImage = apply(
                    toInputImage: CIImage(color: .white).cropped(to: inputImage.extent),
                    background: background,
                    imageEffect: .none,
                    mask: mask
                )
                filter.ringSize = 1
                filter.ringAmount = 1
                filter.softness = 1.0
                filter.radius = 20
                postEffectBackground = filter.outputImage!
        }
        
        let filter = CIFilter.blendWithMask()
        filter.inputImage = inputImage
        filter.backgroundImage = postEffectBackground
        filter.maskImage = mask
        
        return filter.outputImage!
    }
}
