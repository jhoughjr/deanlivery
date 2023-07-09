//
//  CreateUser.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent

extension User {
    ///TODO build schema
    struct CreateUser: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("users")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("users").delete()
        }
    }
}
