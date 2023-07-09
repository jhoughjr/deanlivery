//
//  CompletedPaymentController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//



import Fluent
import Vapor

struct CompletedPaymentController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let completedPayments = routes.grouped("completed_payments")
        completedPayments.get(use: index)
        completedPayments.post(use: create)
        completedPayments.group(":completed_paymentID") { completedPayment in
            completedPayment.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [CompletedPayment] {
        try await CompletedPayment.query(on: req.db).all()
    }

    func create(req: Request) async throws -> CompletedPayment {
        let completedPayment = try req.content.decode(CompletedPayment.self)
        try await completedPayment.save(on: req.db)
        return completedPayment
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let completedPayment = try await CompletedPayment.find(req.parameters.get("completed_paymentID"),
                                   on: req.db) else {
            throw Abort(.notFound)
        }
        try await completedPayment.delete(on: req.db)
        return .noContent
    }
}
