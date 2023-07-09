//
//  PaymentMethodController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent
import Vapor

struct PaymentMethodController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let paymentMethods = routes.grouped("payment_methods")
        paymentMethods.get(use: index)
        paymentMethods.post(use: create)
        paymentMethods.group(":payment_methodID") { paymentMethod in
            paymentMethod.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [PaymentMethod] {
        try await PaymentMethod.query(on: req.db).all()
    }

    func create(req: Request) async throws -> PaymentMethod {
        let paymentMethod = try req.content.decode(PaymentMethod.self)
        try await paymentMethod.save(on: req.db)
        return paymentMethod
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let paymentMethod = try await PaymentMethod.find(req.parameters.get("payment_methodID"),
                               on: req.db) else {
            
            throw Abort(.notFound)
        }
        try await paymentMethod.delete(on: req.db)
        return .noContent
    }
}
