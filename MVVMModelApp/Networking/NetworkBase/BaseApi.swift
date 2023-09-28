//
//  BaseApi.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 27/09/2023.
//

import Foundation
import Alamofire


class BaseApi<T: TargetType> {
    
    func fetchData<M: Decodable> (target:T, response: M.Type) async throws -> M? {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(body: target.body)
        
        return try await withCheckedThrowingContinuation({ continuation in
            
            AF.request(target.baseUrl + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseData { response in
                
                guard let statusCode = response.response?.statusCode else {
                    let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.statusCode])
                    continuation.resume(with: .failure(error))
                    return
                }
                
                if statusCode >= 200 && statusCode <= 299 {
                    
                    // if status code is rigtht
                    guard let jsonResponse = try? response.result.get() else {
                        let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.urlError])
                        continuation.resume(with: .failure(error))
                        return
                    }
                    
                    // arrive and found json data
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                        let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.NnJsonData])
                        continuation.resume(with: .failure(error))
                        return
                    }
                    
                    // parsing json data that found
                    guard let responseObject = try? JSONDecoder().decode(M.self, from: jsonData) else {
                        let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.canNotParsingData])
                        continuation.resume(with: .failure(error))
                        return
                    }
                    
                    continuation.resume(with: .success(responseObject))
                    
                }else {
                    
                    let errorMessage = "a message error from backend"
                    continuation.resume(with: .failure(errorMessage as! Error))
                }
            }
        })
    }
    
    
    private func buildParams(body: Body) -> ([String:Any], ParameterEncoding) {
        switch body {
            
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParametars(Parameters: let Parameters, encoding: let encoding):
            return (Parameters, encoding)
        }
    }
    
    
    
}
