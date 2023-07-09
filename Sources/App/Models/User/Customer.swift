//
//  Customer.swift
//  
//
//  Created by Jimmy Hough Jr on 7/8/23.
//

import Foundation
import Fluent
import Vapor

final class Customer: Model, Content {
    static let schema = "customers"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user")
    var user: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }

    init(id: UUID? = nil, user: User) {
        self.id = id
        self.user = user
    }
}
