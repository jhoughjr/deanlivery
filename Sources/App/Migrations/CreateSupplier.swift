//
//  CreateSupplier.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Foundation
import Fluent

extension Supplier {
    ///TODO build schema
    struct CreateSupplier: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema("suppliers")
                .id()
                .field("title", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("suppliers").delete()
        }
    }
}
