//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Christian Manzaraz on 01/04/2023.
//

import Foundation
struct PhotoInfo: Codable {
    var title: String,
        description: String,
        url: URL,
        copyright: String?

    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
}
