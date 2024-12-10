//
//  PoketData.swift
//  pokeTel
//
//  Created by 김석준 on 12/9/24.
//

import UIKit

// JSON 응답에 맞는 모델 정의
struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    
    struct Sprites: Decodable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case sprites
    }
}
