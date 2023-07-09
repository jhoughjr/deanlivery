//
//  CompletedPayment.swift
//  
//
//  Created by Jimmy Hough Jr on 7/8/23.
//


import Foundation
import Fluent
import Vapor

final class CompletedPayment: Model, Content {
    static let schema = "completed_payments"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key:"completed_payment")
    var order: Order
    
    @Field(key: "title")
    var title: String

    @Field(key: "location")
    var location: String
    
    @Field(key: "method")
    var method: PaymentMethod
    
    @Field(key: "amount")
    var amount: Decimal
    
    @Field(key:"currency")
    var currency:String
   
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
