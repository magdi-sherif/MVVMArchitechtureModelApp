//
//  BaseApi.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 27/09/2023.
//

import Foundation
import Alamofire


class BaseApi<T: TargetType> {
    
    
    func fetchData<M: Codable> (target: T, response: M.Type, combletion: @escaping (Result<M?, Error>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:] )
        let params = buildParams(body: target.body)
        
        AF.request(target.baseUrl + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { response in
            
            // get the status code
            guard let statusCode = response.response?.statusCode else {
                let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.statusCode])
                combletion(.failure(error))
                return
            }
            
            // check the status code is right
            if statusCode == 200 {
                
                // if status code is right get the json response
                guard let jsonResponse = try? response.result.get() else {
                    let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.urlError])
                    combletion(.failure(error))
                    return
                }
                
                // arrive to json serialization using json response
                guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.NnJsonData])
                    combletion(.failure(error))
                    return
                }
                
                // decoding json data that u arrived
                guard let responseObject = try? JSONDecoder().decode(M.self, from: jsonData) else {
                    let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.canNotParsingData])
                    combletion(.failure(error))
                    return
                }
            
                combletion(.success(responseObject))
                
                // in case bad request
            } else {
                
                // show the error from backend
                let message = "show error message from backend"
                let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: message])
                combletion(.failure(error))
            }
        }
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
