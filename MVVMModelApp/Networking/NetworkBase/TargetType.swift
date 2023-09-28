//
//  TargetType.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 27/09/2023.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
    case delete = "DELETE"

}

enum Body {
    case requestPlain
    case requestParametars(Parameters: [String : Any], encoding: ParameterEncoding)
}

protocol TargetType {
    var baseUrl: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var body: Body {get}
    var headers: [String: String]? {get}
}
