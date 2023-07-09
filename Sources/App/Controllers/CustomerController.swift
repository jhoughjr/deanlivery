//
//  CustomerController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent
import Vapor

struct CustomerController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let customers = routes.grouped("customers")
        customers.get(use: index)
        customers.post(use: create)
        customers.group(":customerID") { customer in
            customer.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Customer] {
        try await Customer.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Customer {
        let customer = try req.content.decode(Customer.self)
        try await customer.save(on: req.db)
        return customer
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let customer = try await Customer.find(req.parameters.get("customerID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await customer.delete(on: req.db)
        return .noContent
    }
}
