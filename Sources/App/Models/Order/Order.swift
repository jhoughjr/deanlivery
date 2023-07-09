//
//  Order.swift
//  
//
//  Created by Jimmy Hough Jr on 7/8/23.
//

import Foundation
import Fluent
import Vapor

final class Order: Model, Content {
    static let schema = "orders"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "orders")
    var customer:Customer
    
    @Field(key: "scheduled_payment")
    var scheduled_payment: ScheduledPayment
    
    @OptionalChild(for: \.$order)
    var scheduled_delivery: ScheduledDelivery?
    
    @OptionalChild(for: \.$order)
    var completed_delivery: CompletedDelivery?

    @OptionalChild(for: \.$order)
    var completed_payment: CompletedPayment?
    
    @Field(key: "products")
    var products:[Product]
    
    @Field(key: "total")
    var total:Decimal
    
    @Field(key: "currency")
    var currency:String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }

    init(id: UUID? = nil,
         customer:Customer,
         products:[Product],
         currency:String,
         total:Decimal) {
        self.id = id
        self.customer = customer
        self.currency = currency
        self.total = total
    }
}

/// An Order has a Customer and Marshal;
///
///  an order shuold have a scheduled payment
///  an order should have a completed payment
///
///  The Customer speccifies a Product and Product Source
///    The customer can schedule the delivery of the product from the product source.
///
///    The marshals can see a list of scheduled deliveries
///        WHen a scheduled delivery is delivered the marshal initialates
///        a completed delivery and the customer confirms this delivery.
///
///
