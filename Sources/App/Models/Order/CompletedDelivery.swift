//
//  CompletedDelivery.swift
//
//
//  Created by Jimmy Hough Jr on 7/8/23.
//


import Foundation
import Fluent
import Vapor

final class CompletedDelivery: Model, Content {
    static let schema = "completed_deliveries"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "order")
    var order:Order
    
    @Field(key: "title")
    var title: String

    @Field(key: "time")
    var time:Date
    
    @Field(key: "loc")
    var location:Location
    
    @Field(key: "marshal")
    var marshal: Marshal
    
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
