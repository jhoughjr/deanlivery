//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension Customer {
    ///TODO build schema
    struct CreateCustomer: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("customers")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("customers").delete()
        }
    }
    
}
