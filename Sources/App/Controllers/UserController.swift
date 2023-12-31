//
//  UserController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent
import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("users")
        todos.get(use: index)
        todos.post(use: create)
        todos.group(":userID") { todo in
            todo.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [User] {
        try await User.query(on: req.db).all()
    }

    func create(req: Request) async throws -> User {
        let user = try req.content.decode(User.self)
        try await user.save(on: req.db)
        return user
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db)
        return .noContent
    }
}
