//
//  MarshalController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent
import Vapor

struct MarshalController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let marshals = routes.grouped("marshals")
        marshals.get(use: index)
        marshals.post(use: create)
        marshals.group(":marshalID") { marshal in
            marshals.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Marshal] {
        try await Marshal.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Marshal {
        let marshal = try req.content.decode(Marshal.self)
        try await marshal.save(on: req.db)
        return marshal
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let marshal = try await Marshal.find(req.parameters.get("marshalID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await marshal.delete(on: req.db)
        return .noContent
    }
}
