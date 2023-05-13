//
//  Content.swift
//  NetflixStyleSampleApp
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit

struct Content: Decodable {
    let sectionType: sectionType
    let sectionName: String
    let contentItem: [Item]
    
    enum sectionType: String, Decodable {
        case main
        case basic
        case large
        case rank
    }
}

struct Item: Decodable {
    let description: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}
