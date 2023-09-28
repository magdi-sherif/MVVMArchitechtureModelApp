//
//  Constant.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 27/09/2023.
//

import Foundation
import Alamofire

enum ErrorMessage: Error {
    
    case urlError
    case canNotParsingData
    case NnJsonData
    case statusCode
    
}

enum ProductsNetworking {
    
    case getProducts
    // add any cases available like get categories ...
    
}

extension ProductsNetworking: TargetType {
    
    var baseUrl: String {
        switch self {
            
        case .getProducts:
            return "https://dummyjson.com"
        }
    }
    
    var path: String {
        switch self {
        case.getProducts:
            return "/products"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .getProducts:
            return .get
        }
    }
    
    var body: Body {
        switch self {
            
        case .getProducts:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    

}
