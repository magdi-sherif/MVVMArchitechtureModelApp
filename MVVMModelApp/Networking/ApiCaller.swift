//
//  ApiCaller.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 28/09/2023.
//

import Foundation
import Alamofire


protocol ProductsApiProtocol {
    func getProducts(combletion: @escaping (Result<ProductsModel?, Error>) -> Void)
}

// fetching data
class getProductsApi: BaseApi<ProductsNetworking>, ProductsApiProtocol {

    func getProducts(combletion: @escaping (Result<ProductsModel?, Error>) -> Void) {

        self.fetchData(target: .getProducts, response: ProductsModel.self) { result in
            switch result {

            case .success(let data):
                combletion(.success(data))
            case .failure(let error):
                combletion(.failure(error))
            }
        }
    }


}
