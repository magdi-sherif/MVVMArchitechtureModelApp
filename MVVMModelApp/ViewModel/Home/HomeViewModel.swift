//
//  HomeViewModel.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 27/09/2023.
//

import UIKit


class HomeViewModel {
    
    
    // get the data 
    func getApiData() {
        let api: ProductsApiProtocol = getProductsApi()
        api.getProducts { result in
            switch result {
            case .success(let success):
                print(success ?? "")
            case .failure(let failure):
                print(failure)
            }
        }
    }
    

    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 10
    }
    
    var products: [ProductsModel]?
    
    
    
    
}

