//
//  Marshal.swift
//  
//
//  Created by Jimmy Hough Jr on 7/8/23.
//

import Fluent
import Vapor


/// Marshals accept scheduled delivery from customers for products from product sources.
///  The scheduled order provides the location of delivery and the product and source.
final class Marshal: Model, Content {
    static let schema = "marshals"
    
    @ID(key: .id)
    var id: UUID?

    @Parent(key:"user")
    var user: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }

    init(id: UUID? = nil,
         user: User) {
        self.id = id
        self.user = user
    }
}
