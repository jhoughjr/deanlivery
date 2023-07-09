//
//  ProductSource.swift
//  
//
//  Created by Jimmy Hough Jr on 7/8/23.
//


import Foundation
import Fluent
import Vapor

final class ProductSource: Model, Content {
    static let schema = "product_sources"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String

    @Field(key: "location")
    var location:Location
    
    @Parent(key:"supplier")
    var supplier:Supplier
    
    @Children(for:\.$productSource)
    var products:[Product]
    
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

///
/// A product source should accept a scheduled delivery or a completed delivery and maintain a scheduled inventory and a real inventory of products.
/// produvt sources have location info so marshals can find them
/// product sources may have other info for customers.
/// 
