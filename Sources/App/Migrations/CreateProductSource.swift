//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent

extension ProductSource {
    ///TODO build schema
    struct CreateProductSource: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("product_sources")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("product_sources").delete()
        }
    }
    
}
