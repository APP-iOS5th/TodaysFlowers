//
//  ImageDetectionViewModel.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/11/24.
//

import UIKit
import CoreML
import Vision
import Combine

final class ImageDetectionViewModel {
    @Published var flowerName: String?
    @Published var imageNotFound: Bool = false
    
    func detect(image: CIImage) {
        
        guard let coreMLModel = try? FlowerClassifier(configuration: MLModelConfiguration()),
              let visionModel = try? VNCoreMLModel(for: coreMLModel.model) else {
            fatalError("Failed while loading CoreML Model")
        }
        
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            guard error == nil else {
                fatalError("Failed Request")
            }
            
            guard let classification = request.results as? [VNClassificationObservation] else {
                fatalError("Faild convert VNClassificationObservation")
            }
            
            if let firstItem = classification.first {
                // 신뢰도 0.9 이상
                if firstItem.confidence > 0.9 {
                    self.flowerName = firstItem.identifier.precomposedStringWithCanonicalMapping // CoreML이 반환한 문자열이 NFD여서 NFC형태로 변환해줘야 URL인코딩이 정상적으로 처리됨
                } else {
                    self.imageNotFound = true // 신뢰도가 낮다(ML 모델에 찾고자 하는 이미지가 없음)
                }
            }
        }
        
        // 시뮬레이터에서 GPU를 사용하지 못하여 아래 코드 추가
        #if targetEnvironment(simulator)
           request.usesCPUOnly = true // useCPUOnly가 deprecated되었는데 대안책을 찾지 못하여서 그대로 사용
        #endif
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
