//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension ScheduledPayment {
    ///TODO build schema
    struct CreateScheduledPayment: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("scheduled_payments")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("scheduled_payments").delete()
        }
    }
    
}

