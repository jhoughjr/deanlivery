//
//  ScheduledPaymentController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent
import Vapor

struct ScheduledPaymentController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let scheduledPayments = routes.grouped("scheduled_payments")
        scheduledPayments.get(use: index)
        scheduledPayments.post(use: create)
        scheduledPayments.group(":scheduled_paymentID") { scheduledPayment in
            scheduledPayment.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [ScheduledPayment] {
        try await ScheduledPayment.query(on: req.db).all()
    }

    func create(req: Request) async throws -> ScheduledPayment {
        let scheduledPayment = try req.content.decode(ScheduledPayment.self)
        try await scheduledPayment.save(on: req.db)
        return scheduledPayment
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let scheduledPayment = try await ScheduledPayment.find(req.parameters.get("scheduled_paymentID"),
                                   on: req.db) else {
            throw Abort(.notFound)
        }
        try await scheduledPayment.delete(on: req.db)
        return .noContent
    }
}
