//
//  URLType.swift
//  TodaysFlowers
//
//  Created by mosi on 6/11/24.
//

import Foundation

enum URLType {
    case detail
    case info
    case list
    
    var urlString: String {
        switch self {
            case .detail:
                return "http://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlowerView01"
            case .info:
                return "http://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlower01"
            case .list:
                return "http://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlowerList01"
        }
    }
}
