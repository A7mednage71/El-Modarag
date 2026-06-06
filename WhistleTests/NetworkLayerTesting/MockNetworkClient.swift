//
//  MockNetworkClient.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//


import XCTest
import Alamofire
@testable import Whistle


class MockNetworkClient: NetworkClientProtocol {
    
    var shouldReturnError = false
    var mockData: Data?
    
    
    func fetchData<T: Decodable>(target: URLRequestConvertible, responseType: T.Type, completion: @escaping (Result<T, AFError>) -> Void) {
        
        if shouldReturnError {
            
            let error = AFError.sessionTaskFailed(error: URLError(.notConnectedToInternet))
            completion(.failure(error))
            
        } else if let data = mockData {
            
            do {
                
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
                
            } catch {
                
                let decodingError = AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
                completion(.failure(decodingError))
                
            }
            
        }
    }
}
