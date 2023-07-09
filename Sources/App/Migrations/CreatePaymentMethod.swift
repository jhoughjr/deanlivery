//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension PaymentMethod {
    ///TODO build schema
    struct CreatePaymentMethod: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("payment_methods")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("payment_methods").delete()
        }
    }
    
}

