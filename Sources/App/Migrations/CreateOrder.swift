//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension Order {
    ///TODO build schema
    struct CreateOrder: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("orders")
                .id()
                .field("customer", .uuid, .required, .references("customer",
                                                                 "id"))
                
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("orders").delete()
        }
    }
    
}
