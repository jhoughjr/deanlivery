//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension Product {
    ///TODO build schema
    struct CreateProduct: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("products")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("products").delete()
        }
    }
    
}
