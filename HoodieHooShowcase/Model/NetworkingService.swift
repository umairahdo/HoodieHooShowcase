//
//  NetworkingService.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import Foundation
import RxSwift

protocol NetworkingService {
    func request(_ api: ImagesAPI) -> Single<[String]>
}

enum NetworkingError: Error {
    case error(String)
    case defaultError
    
    var message: String {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "Please retry later."
        }
    }
}

final class NetworkingAPI: NetworkingService {
    private let session = URLSession.shared
    
    private func setRequest(_ api: ImagesAPI) -> URLRequest {
        var url = api.baseURL + api.path
        if api.querys != nil {
            url += "?"
            for query in api.querys! {
                url += query.key + "=" + query.value
            }
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = api.method
        return request
    }
    
    func request(_ api: ImagesAPI) -> Single<[String]> {
        return Single<[String]>.create { single in
            let response = self.session.rx.response(request: self.setRequest(api))
            
            return response.subscribe(onNext: { response, data in
                if 200..<300 ~= response.statusCode {
                    guard let images = try? JSONDecoder().decode([String].self, from: data) else {
                        return single(.error(NetworkingError.error("\(api.path) \(AppMessages.jsonDecodingError)")))
                    }
                    
                    return single(.success(images))
                }
            }, onError: { error in
                return single(.error(NetworkingError.defaultError))
            })
        }
    }
}

