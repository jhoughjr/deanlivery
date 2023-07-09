//
//  ScheduledDeliveryController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent
import Vapor

struct ScheduledDeliveryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let scheduledDeliveries = routes.grouped("scheduled_deliveries")
        scheduledDeliveries.get(use: index)
        scheduledDeliveries.post(use: create)
        scheduledDeliveries.group(":scheduled_deliveryID") { scheduledDelivery in
            scheduledDelivery.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [ScheduledDelivery] {
        try await ScheduledDelivery.query(on: req.db).all()
    }

    func create(req: Request) async throws -> ScheduledDelivery {
        let scheduledDelivery = try req.content.decode(ScheduledDelivery.self)
        try await scheduledDelivery.save(on: req.db)
        return scheduledDelivery
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let scheduledDelivery = try await ScheduledDelivery.find(req.parameters.get("scheduled_deliveryID"),
                                   on: req.db) else {
            throw Abort(.notFound)
        }
        try await scheduledDelivery.delete(on: req.db)
        return .noContent
    }
}

