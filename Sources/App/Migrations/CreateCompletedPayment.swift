//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension CompletedPayment {
    ///TODO build schema
    struct CreateCompletedPayment: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("completed_payments")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("completed_payments").delete()
        }
    }
    
}
