//
//  NetworkClient.swift
//  Whistle
//
//  Created by Ahmed Nageh on 31/05/2026.
//

import Foundation
import Alamofire

protocol NetworkClientProtocol {
    func fetchData<T: Decodable>(
        target: URLRequestConvertible,
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    )
}

class NetworkClient: NetworkClientProtocol {
    
    private let apiKey = "6359a35b4316575e15b09c3c170780c5614f625690e1d3c76ed70a9521498f82"
    private let session = AF
    
    init() {}
    
    func fetchData<T: Decodable>(
        target: URLRequestConvertible,
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        do {
            var urlRequest: URLRequest = try target.asURLRequest()
            
            if let url = urlRequest.url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                var queryItems = urlComponents.queryItems ?? []
                queryItems.append(URLQueryItem(name: "APIkey", value: apiKey))
                urlComponents.queryItems = queryItems
                urlRequest.url = urlComponents.url
            }
            
            session.request(urlRequest)
                .cURLDescription { description in
                    print("🖥️ cURL Command: \(description)")
                }.validate()
                .responseDecodable(of: T.self) { response in
                    completion(response.result)
                    
                switch response.result {
                    case .success(let fixtures):
                        print("Success: \(fixtures)")
                    case .failure(let error):
                        print("❌ Decoding Failed: \(error.localizedDescription)")
                        if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                            print("🌐 RAW API RESPONSE: \n\(jsonString)")
                        }
                }
            }
                
        } catch {
            print("❌ Error building request: \(error)")
            let buildError = AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            completion(.failure(buildError))
        }
    }
}
