//
//  NetworkService.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 09.11.2022.
//

import Foundation

enum Test {
    case test1
    case test2
}

class NetworkService {
    
    // MARK: Private Properties
    
    private lazy var baseURL: URL? = {
        return URL(string: "https://data.messari.io/api/v1")
    }()
    
    private let session: URLSession
    
    // MARK: Initializer
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: Public Functions
    
    func getCoin(with request: CoinRequest, completion: @escaping (Result<Response, DataResponseError>) -> Void) {
        guard let baseURL = baseURL else { return }
        let urlRequest = URLRequest(url: baseURL.appending(path: request.path))
        
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let htttpResponse = response as? HTTPURLResponse,
                  htttpResponse.hasSuccessStatusCode, let data = data else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            completion(Result.success(decodedResponse))
        }).resume()
    }
}
