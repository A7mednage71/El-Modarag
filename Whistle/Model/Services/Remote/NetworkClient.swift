//
//  NetworkClient.swift
//  Whistle
//
//  Created by Ahmed Nageh on 31/05/2026.
//

import Foundation
import Alamofire

class NetworkClient {
    
    private static let apiKey = "60c5aa9f6eb50c6ad42456cdcb5902b99eb71120a683d5d79da9a63da254f7de"
    private static let session = AF
    
    private init() {}
    
    static func fetchData<T: Decodable>(
        target: URLRequestConvertible,
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        do {
            var urlRequest :URLRequest = try target.asURLRequest()
            
            if let url = urlRequest.url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                var queryItems = urlComponents.queryItems ?? []
                queryItems.append(URLQueryItem(name: "APIkey", value: apiKey))
                urlComponents.queryItems = queryItems
                urlRequest.url = urlComponents.url
            }
            
            session.request(urlRequest)
                .validate() // check server status is 200
                .responseDecodable(of: T.self) { response in
                    print("🌐 --- RAW JSON RESPONSE START ---")
                    print(response)
                    print("🌐 --- RAW JSON RESPONSE END ---")
                    completion(response.result)
                }
                
        } catch {
            print("❌ Error building request: \(error)")
            // Failed to include parameters in URL
            let buildError = AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            completion(.failure(buildError))
        }
    }
}
