//
//  FlowerData.swift
//  TodaysFlowers
//
//  Created by mosi on 6/12/24.
//

import Foundation
struct Document: Codable {
    let root: Root
}
struct Root: Codable {
    let resultCode: String
    let resultMsg: String
    let repcategory: String
    let result: [Result]
}

struct Result: Codable {
    let dataNo: String
    let fMonth: String
    let fDay: String
    let flowNm: String
    let fSctNm: String?
    let fEngNm: String?
    let flowLang: String
    let fContent: String?
    let fUse: String?
    let fGrow: String?
    let fType: String?
    let imgUrl1: String
    let imgUrl2: String
    let imgUrl3: String
}
