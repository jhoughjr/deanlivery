//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension ScheduledDelivery {
    ///TODO build schema
    struct CreateScheduledDelivery: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("scheduled_deliveries")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("scheduled_deliveries").delete()
        }
    }
    
}
