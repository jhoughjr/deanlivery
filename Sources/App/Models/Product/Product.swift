//
//  Product.swift
//  
//
//  Created by Jimmy Hough Jr on 7/8/23.
//


import Foundation
import Fluent
import Vapor

final class Product: Model, Content {
    static let schema = "products"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "product_source")
    var productSource: ProductSource
    
    @Field(key: "price")
    var price: Decimal
    
    @Field(key:"currency")
    var currency:String
    
    @Field(key: "url")
    var url: String
    
    @Field(key: "title")
    var title: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }

    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
