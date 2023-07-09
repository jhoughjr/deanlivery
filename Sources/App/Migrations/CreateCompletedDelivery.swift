//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension CompletedDelivery {
    ///TODO build schema
    struct CreateCompletedDelivery: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("completed_deliveries")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("completed_deliveries").delete()
        }
    }
    
}
