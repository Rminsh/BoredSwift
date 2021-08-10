//
//  APIRequest.swift
//  Core
//
//  Created by armin on 7/22/21.
//

import Foundation

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}
 
extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Result<Resource.ModelType, NetworkingError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let result = try decoder.decode(Resource.ModelType.self, from: data)
            return .success(result)
        } catch {
            print(error)
            return .failure(.errorParse)
        }
    }
    
    func execute(withCompletion completion: @escaping (Result<Resource.ModelType, NetworkingError>) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}
