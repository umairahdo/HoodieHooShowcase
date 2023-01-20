//
//  MockNetworkingAPI.swift
//  HoodieHooShowcaseTests
//
//  Created by Umair Ahmad on 20/01/23.
//

import Foundation
import RxSwift
@testable import HoodieHooShowcase

class MockNetworkingAPI: NetworkingService {
    
    func getImagesFromJson(_ api: ImagesAPI) -> [String] {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        switch api {
        case .getImageList:
            return bundle!.decode([String].self, from: "ImageList.json")
        }
    }
    
    func request(_ api: ImagesAPI) -> Single<[String]> {
        return Single.just(getImagesFromJson(api))
    }
}
