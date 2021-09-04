//
//  NetworkRequest.swift
//  Core
//
//  Created by armin on 7/22/21.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> Result<ModelType, NetworkingError>
    func execute(withCompletion completion: @escaping (Result<ModelType, NetworkingError>) -> Void)
}


extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (Result<ModelType, NetworkingError>)-> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _ , _) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(.failure(.badNetworkingRequest)) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
}
