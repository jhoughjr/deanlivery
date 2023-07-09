//
//  CompletedDeliveryController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent
import Vapor

struct CompletedDeliveryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let completedDeliveries = routes.grouped("completed_deliveries")
        completedDeliveries.get(use: index)
        completedDeliveries.post(use: create)
        completedDeliveries.group(":completed_deliveryID") { completedDelivery in
            completedDelivery.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [CompletedDelivery] {
        try await CompletedDelivery.query(on: req.db).all()
    }

    func create(req: Request) async throws -> CompletedDelivery {
        let completedDelivery = try req.content.decode(CompletedDelivery.self)
        try await completedDelivery.save(on: req.db)
        return completedDelivery
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let completedDelivery = try await CompletedDelivery.find(req.parameters.get("completed_deliveryID"),
                                   on: req.db) else {
            throw Abort(.notFound)
        }
        try await completedDelivery.delete(on: req.db)
        return .noContent
    }
}
