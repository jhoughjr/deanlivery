//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent

extension Location {
    
    struct CreateLocation: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("locations")
                .id()
                .field("title", .string, .required)
                .field("lat", .double, .required)
                .field("lng", .double, .required)
                .field("created_at", .datetime, .required)
                .field("updated_at", .datetime, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("locations").delete()
        }
    }
    
}
