//
//  FlowersApi.swift
//  TodaysFlowers
//
//  Created by mosi on 6/12/24.
//
import Combine
import Foundation
import XMLCoder

final class FlowersApi: DetailViewUseCase, SearchUseCase, HomeViewUseCase  {
    
    let apikey = "FByld3CLZFH7McV%2B9rrh55h%2F0vqtm0im9vy8Cl16wQOU57mFDm6KkfdwmbW%2FdovSFTlH0KFSroxN7XjFLnIyKg%3D%3D"
    
    func getFlower(by date: Date) -> AnyPublisher<Flower, Never> {
        let calender = Calendar.current
        let month = calender.component(.month, from: date)
        let day = calender.component(.day, from: date)
        
        let urlString = EndpointFactory.buildEndpoint(
            with: .info,
            keyValue: [
                "serviceKey": apikey,
                "fMonth": String(month),
                "fDay": String(day),
            ]
        )
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Document.self, decoder: XMLDecoder())
            .map { document -> Flower in
                
                let result = document.root.result.first!
                
                let imageUrls = [result.imgUrl1, result.imgUrl2, result.imgUrl3]
            
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd"
                let dateString = "\(result.fMonth)-\(result.fDay)"
                guard let date = dateFormatter.date(from: dateString) else {
                    fatalError("Failed to convert date: \(dateString)")
                }
                
                return Flower(id: Int(result.dataNo) ?? 0,
                              name: result.flowNm,
                              lang: result.flowLang,
                              content: result.fContent ?? "",
                              type: result.fType ?? "",
                              grow: result.fGrow ?? "",
                              usage: result.fUse ?? "",
                              imageUrlString: imageUrls,
                              date: date)
            }
            .replaceError(with: Flower(id: -1, name: "", lang: "", content: "", type: "", grow: "", usage: "", imageUrlString: [], date: Date()))
            .eraseToAnyPublisher()
    }
    
    func getFlowers(by date: [Date]) -> AnyPublisher<[Flower], Never> {
        let merged: AnyPublisher<[Flower], Never> =
        Publishers
            .MergeMany (
                date.map {
                    getFlower(by: $0)
                }
            )
            .collect()
            .eraseToAnyPublisher()

       return merged
    }
    
    func getFlower(by id: Int) -> AnyPublisher<Flower, Never> {
        let urlString = EndpointFactory.buildEndpoint(
            with: .detail,
            keyValue: [
                "serviceKey": apikey,
                "dataNo": String(id)
            ]
        )
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .handleEvents(receiveCompletion: {
                print($0)
            })
            .decode(type: Document.self, decoder: XMLDecoder())
            .map { document -> Flower in
                
                let result = document.root.result.first!
                
                let imageUrls = [result.imgUrl1, result.imgUrl2, result.imgUrl3]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd"
                let dateString = "\(result.fMonth)-\(result.fDay)"
                guard let date = dateFormatter.date(from: dateString) else {
                    fatalError("Failed to convert date: \(dateString)")
                }
                
                return Flower(id: Int(result.dataNo) ?? 0,
                              name: result.flowNm,
                              lang: result.flowLang,
                              content: result.fContent ?? "",
                              type: result.fType ?? "",
                              grow: result.fGrow ?? "",
                              usage: result.fUse ?? "",
                              imageUrlString: imageUrls,
                              date: date)
            }
            .replaceError(with: Flower(id: -1, name: "", lang: "", content: "", type: "", grow: "", usage: "", imageUrlString: [], date: Date()))
            .eraseToAnyPublisher()
    }
    
    
    
    func searchBy(name: String) -> AnyPublisher<[Flower], Never> {
        
        let urlString = EndpointFactory.buildEndpoint(
            with: .list,
            keyValue: [
                "serviceKey": apikey,
                "pageNo": "1",
                "numOfRows": "366",
                "searchType": "1",
                "searchWord": name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            ]
        )
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Document.self, decoder: XMLDecoder())
            .map { document -> [Flower] in
                let results = document.root.result
                return results.map { result -> Flower in
                    // Convert image URLs to Data
                    let imageUrls = [result.imgUrl1, result.imgUrl2, result.imgUrl3]
                    
                    // Convert fMonth and fDay to Date
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd"
                    let dateString = "\(result.fMonth)-\(result.fDay)"
                    guard let date = dateFormatter.date(from: dateString) else {
                        fatalError("Failed to convert date: \(dateString)")
                    }
                    
                    return Flower(id: Int(result.dataNo)!, name: result.flowNm, lang: result.flowLang, content: result.fContent ?? "", type: result.fType ?? "", grow: result.fGrow ?? "", usage: result.fUse ?? "", imageUrlString: imageUrls, date: date)
                }
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    
    
    func searchBy(flowerLang: String) -> AnyPublisher<[Flower], Never> {
        
        let urlString = EndpointFactory.buildEndpoint(
            with: .list,
            keyValue: [
                "serviceKey": apikey,
                "pageNo": "1",
                "numOfRows": "366",
                "searchType": "4",
                "searchWord": flowerLang.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            ]
        )
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .print()
            .decode(type: Document.self, decoder: XMLDecoder())
            .map { document -> [Flower] in
                let results = document.root.result
                return results.map { result -> Flower in
                    // Convert image URLs to Data
                    let imageUrls = [result.imgUrl1, result.imgUrl2, result.imgUrl3]
                    
                    // Convert fMonth and fDay to Date
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd"
                    let dateString = "\(result.fMonth)-\(result.fDay)"
                    guard let date = dateFormatter.date(from: dateString) else {
                        fatalError("Failed to convert date: \(dateString)")
                    }
                    
                    return Flower(id: Int(result.dataNo) ?? 0,
                                  name: result.flowNm,
                                  lang: result.flowLang,
                                  content: result.fContent ?? "",
                                  type: result.fType ?? "",
                                  grow: result.fGrow ?? "",
                                  usage: result.fUse ?? "",
                                  imageUrlString: imageUrls,
                                  date: date)
                }
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    func searchBy(month: String, day: String) -> AnyPublisher<[Flower], Never> {
           let urlString = EndpointFactory.buildEndpoint(
               with: .info,
               keyValue: [
                   "serviceKey": apikey,
                   "pageNo": "1",
                   "numOfRows": "366",
                   "fMonth": month,
                   "fDay": day
               ]
           )
           
           guard let url = URL(string: urlString) else {
               fatalError("Invalid URL")
           }
           
           let flowers = URLSession.shared.dataTaskPublisher(for: url)
               .tryMap() { element -> Data in
                   guard let httpResponse = element.response as? HTTPURLResponse,
                         httpResponse.statusCode == 200 else {
                       throw URLError(.badServerResponse)
                   }
                   return element.data
               }
               .print()
               .decode(type: Document.self, decoder: XMLDecoder())
               .map { document -> Flower in
                   
                   let result = document.root.result.first!
                   
                   let imageUrls = [result.imgUrl1, result.imgUrl2, result.imgUrl3]
                   
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "MM-dd"
                   let dateString = "\(result.fMonth)-\(result.fDay)"
                   guard let date = dateFormatter.date(from: dateString) else {
                       fatalError("Failed to convert date: \(dateString)")
                   }
                   
                   return Flower(id: Int(result.dataNo) ?? 0,
                                 name: result.flowNm,
                                 lang: result.flowLang,
                                 content: result.fContent ?? "",
                                 type: result.fType ?? "",
                                 grow: result.fGrow ?? "",
                                 usage: result.fUse ?? "",
                                 imageUrlString: imageUrls,
                                 date: date)
               }
               .replaceError(with: Flower(id: -1, name: "", lang: "", content: "", type: "", grow: "", usage: "", imageUrlString: [], date: Date()))
               .eraseToAnyPublisher()
           
         let merged = Publishers
             .MergeMany(
                 flowers
             )
         let collectedPublisher = merged.collect()
         let anyPublisher: AnyPublisher<[Flower], Never> = collectedPublisher.eraseToAnyPublisher()
         return anyPublisher
     }
}
