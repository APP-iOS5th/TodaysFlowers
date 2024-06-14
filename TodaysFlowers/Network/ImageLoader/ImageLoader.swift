//
//  ImageLoader.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/13/24.
//

import UIKit
import os

protocol Cachable {
    associatedtype Content: AnyObject
    var memoryCache: NSCache<NSString, Content> { get }
    
    func loadData(with key: String) async -> Content?
}

extension Cachable {
    func checkCache(with key: String) -> Content? {
        memoryCache.object(forKey: key as NSString)
    }
    
    func save(object: Content, for key: String) {
        memoryCache.setObject(object, forKey: key as NSString)
    }
}

final class ImageLoader: Cachable {
    static let shared = ImageLoader()
    
    private let session: URLSession
    private let logger: Logger
    var memoryCache: NSCache<NSString, UIImage>
    
    private init(
        session: URLSession = .shared,
        logger: Logger = .init(.default),
        memoryCache: NSCache<NSString, UIImage> = .init()
    ) {
        self.session = session
        self.logger = logger
        self.memoryCache = memoryCache
    }
    
    func loadData(with key: String) async -> UIImage? {
        if let image = checkCache(with: key) {
            logger.debug("Image Hit for \(key)")
            return image
        }
        
        guard let url = URL(string: key) else {
            return nil
        }
        
        do {
            let (data, _) = try await session.data(from: url)
            guard let image = UIImage(data: data) else {
                logger.debug("Image data does not valid: \(key)")
                return nil
            }
            save(object: image, for: key)
            
            return image
        } catch {
            return nil
        }
    }
}
