//
//  OrderController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Fluent
import Vapor

struct OrderController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let orders = routes.grouped("orders")
        orders.get(use: index)
        orders.post(use: create)
        orders.group(":orderID") { order in
            order.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Order] {
        try await Order.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Order {
        let order = try req.content.decode(Order.self)
        try await order.save(on: req.db)
        return order
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let order = try await Order.find(req.parameters.get("orderID"),
                                               on: req.db) else {
            throw Abort(.notFound)
        }
        try await order.delete(on: req.db)
        return .noContent
    }
}
