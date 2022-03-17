//
//  File.swift
//  
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import Foundation
import PromiseKit
import Alamofire

public enum ImageService {

    private static let imageCache = NSCache<NSString, NSData>()

    public static func getImageURL(status: String) -> Promise<Data> {
        Promise { seal in
            let url = "https://www.metaweather.com/static/img/weather/png/\(status).png"
            let cacheID = NSString(string: url)
            if let data = imageCache.object(forKey: cacheID) {
                return seal.fulfill(data as Data)
            }

            AF.request(url, method: .get).responseData { response in
                switch response.result {
                case .success(let result):
                    seal.fulfill(result)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

}
