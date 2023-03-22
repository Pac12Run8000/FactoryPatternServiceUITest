//
//  AcronymObject.swift
//  FactoryPatternServiceUITest
//
//  Created by Michelle Grover on 3/21/23.
//

import Foundation

struct AcronymElement:Codable, Equatable {
    
    var sf:String
    var lfs:[LF]
    
    static func == (lhs: AcronymElement, rhs: AcronymElement) -> Bool {
        return lhs.lfs == rhs.lfs
    }
}

struct LF:Codable, Equatable {
     let lf: String
     let freq: Int
     let since: Int
     let vars: [LF]?
}

typealias AcronymObject = [AcronymElement]
