//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension Marshal {
    ///TODO build schema
    struct CreateMarshal: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("marshals")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("marshals").delete()
        }
    }
    
}
