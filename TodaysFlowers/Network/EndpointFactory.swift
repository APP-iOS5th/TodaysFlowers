//
//  EndpointFactory.swift
//  TodaysFlowers
//
//  Created by mosi on 6/12/24.
//

import Foundation


struct EndpointFactory {
    static func buildEndpoint(with urlType: URLType, keyValue: [String: String]) -> String {
        let queryString = keyValue
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        
        return "\(urlType.urlString)?\(queryString)"
    }
}
