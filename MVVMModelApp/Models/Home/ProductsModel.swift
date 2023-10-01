//
//  ProductsModel.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 28/09/2023.
//

import Foundation

//// MARK: - ProductsModel
//struct ProductsModel: Codable {
//    let products: [Product]
//    let total, skip, limit: Int
//}
//
//// MARK: - Product
//struct Product: Codable {
//    let id: Int
//    let title, description: String
//    let price: Int
//    let discountPercentage, rating: Double
//    let stock: Int
//    let brand, category, thumbnail: String
//    let images: [String]
//}


struct ProductsModel: Codable {
    var products: [Products]?
}


struct Products: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var price: Int?
    var brand: String?
    var category: String?
    var stock: Int?
    var rating: Double?
    var discountPercentage: Double?
    var thumbnail: String?
    var images: [String]?
}
