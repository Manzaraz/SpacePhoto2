//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Christian Manzaraz on 01/04/2023.
//

import Foundation
import UIKit

class PhotoInfoController {
    enum PhotoInfoError: Error, LocalizedError {
        case itenNotFound
        case imageDataMissing
    }

    func fetchPhotoInfo() async throws -> PhotoInfo {
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        urlComponents.queryItems = [
            "api_key" : "DEMO_KEY"
        ].map{ URLQueryItem(name: $0.key, value: $0.value) }

        let (data, response) = try await URLSession.shared.data(from:
           urlComponents.url!)

        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else { throw PhotoInfoError.itenNotFound
        }
        
        let jsonDecoder = JSONDecoder()
        let photoInfo = try jsonDecoder.decode(PhotoInfo.self, from: data)
        return (photoInfo)
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents!.url!)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else { throw PhotoInfoError.imageDataMissing }
        
        guard
            let image = UIImage(data: data)
        else { throw PhotoInfoError.imageDataMissing }
        
        return image
    }
}
