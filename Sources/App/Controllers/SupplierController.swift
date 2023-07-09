//
//  SupplierController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent
import Vapor

struct SupplierController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let suppliers = routes.grouped("suppliers")
        suppliers.get(use: index)
        suppliers.post(use: create)
        suppliers.group(":supplierID") { supplier in
            supplier.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Supplier] {
        try await Supplier.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Supplier {
        let supplier = try req.content.decode(Supplier.self)
        try await supplier.save(on: req.db)
        return supplier
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let supplier = try await Supplier.find(req.parameters.get("supplierID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await supplier.delete(on: req.db)
        return .noContent
    }
}
