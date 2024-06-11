//
//  FlowersApi.swift
//  TodaysFlowers
//
//  Created by mosi on 6/11/24.
//

import Combine
import Foundation
import XMLCoder

final class FlowersApi: DetailViewUseCase, SearchUseCase  {
    
    let apikey = "FByld3CLZFH7McV%2B9rrh55h%2F0vqtm0im9vy8Cl16wQOU57mFDm6KkfdwmbW%2FdovSFTlH0KFSroxN7XjFLnIyKg%3D%3D"
    
    func getFlower(by id: Int) -> AnyPublisher<Flower, Never> {
        let urlString = "https://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlowerView01?serviceKey=\(apikey)&dataNo=\(id)"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
                   .map(\.data)
                   .decode(type: Document.self, decoder: XMLDecoder())
                   .map { document -> Flower in
                       let result = document.root.result
                       let imageUrls = [result.imgUrl1, result.imgUrl2, result.imgUrl3]
                       var imageData: [Data] = []
                       
                       for imageUrl in imageUrls {
                           guard let url = URL(string: imageUrl),
                                 let data = try? Data(contentsOf: url) else {
                               fatalError("Failed to load image data from URL: \(imageUrl)")
                           }
                           imageData.append(data)
                       }
                       
                     
                       let dateFormatter = DateFormatter()
                       dateFormatter.dateFormat = "MM-dd"
                       let dateString = "\(result.fMonth)-\(result.fDay)"
                       guard let date = dateFormatter.date(from: dateString) else {
                           fatalError("Failed to convert date: \(dateString)")
                       }
                       
                       return Flower(id: Int(result.dataNo) ?? 0,
                                     name: result.flowNm,
                                     lang: result.flowLang,
                                     content: result.fContent,
                                     type: result.fType,
                                     grow: result.fGrow,
                                     usage: result.fUse,
                                     imageData: imageData,
                                     date: date)
                   }
                   .replaceError(with: Flower(id: -1, name: "", lang: "", content: "", type: "", grow: "", usage: "", imageData: [], date: Date()))
                   .eraseToAnyPublisher()
           }
    
    
    
    func searchBy(name: String) -> AnyPublisher<[Flower], Never> {
        let urlString =
        "https://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlowerList01?serviceKey=\(apikey)&pageNo=1&numOfRows=100&searchType=1&searchWord=\(name)"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
             .map(\.data)
             .decode(type: Document.self, decoder: XMLDecoder())
             .map { document -> [Flower] in
                 let result = document.root.result
                 
                 // Convert image URLs to Data
                 let imageUrls = [result.imgUrl1, result.imgUrl2, result.imgUrl3]
                 var imageData: [Data] = []
                 
                 for imageUrl in imageUrls {
                     guard let url = URL(string: imageUrl),
                           let data = try? Data(contentsOf: url) else {
                         fatalError("Failed to load image data from URL: \(imageUrl)")
                     }
                     imageData.append(data)
                 }
                 
                 // Convert fMonth and fDay to Date
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "MM-dd"
                 let dateString = "\(result.fMonth)-\(result.fDay)"
                 guard let date = dateFormatter.date(from: dateString) else {
                     fatalError("Failed to convert date: \(dateString)")
                 }
                 
                 let flower = Flower(id: Int(result.dataNo) ?? 0,
                                     name: result.flowNm,
                                     lang: result.flowLang,
                                     content: result.fContent,
                                     type: result.fType,
                                     grow: result.fGrow,
                                     usage: result.fUse,
                                     imageData: imageData,
                                     date: date)
                 return [flower]
             }
             .replaceError(with: [])
             .eraseToAnyPublisher()
     }
    
    
    
    func searchBy(flowerLang: String) -> AnyPublisher<[Flower], Never> {
        let urlString =
        "https://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlowerList01?serviceKey=\(apikey)&pageNo=1&numOfRows=100&searchType=4&searchWord=\(flowerLang)"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
             .map(\.data)
             .decode(type: Document.self, decoder: XMLDecoder())
             .map { document -> [Flower] in
                 let result = document.root.result
                 
                 // Convert image URLs to Data
                 let imageUrls = [result.imgUrl1, result.imgUrl2, result.imgUrl3]
                 var imageData: [Data] = []
                 
                 for imageUrl in imageUrls {
                     guard let url = URL(string: imageUrl),
                           let data = try? Data(contentsOf: url) else {
                         fatalError("Failed to load image data from URL: \(imageUrl)")
                     }
                     imageData.append(data)
                 }
                 
                 // Convert fMonth and fDay to Date
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "MM-dd"
                 let dateString = "\(result.fMonth)-\(result.fDay)"
                 guard let date = dateFormatter.date(from: dateString) else {
                     fatalError("Failed to convert date: \(dateString)")
                 }
                 
                 let flower = Flower(id: Int(result.dataNo) ?? 0,
                                     name: result.flowNm,
                                     lang: result.flowLang,
                                     content: result.fContent,
                                     type: result.fType,
                                     grow: result.fGrow,
                                     usage: result.fUse,
                                     imageData: imageData,
                                     date: date)
                 return [flower]
             }
             .replaceError(with: [])
             .eraseToAnyPublisher()
     }
    
    
   
    
    
    
    
    
    
}
