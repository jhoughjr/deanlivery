//
//  ProductSoruceController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent
import Vapor

struct ProductSourceController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let productSources = routes.grouped("product_sources")
        productSources.get(use: index)
        productSources.post(use: create)
        productSources.group(":product_sourceID") { productSource in
            productSource.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [ProductSource] {
        try await ProductSource.query(on: req.db).all()
    }

    func create(req: Request) async throws -> ProductSource {
        let productSource = try req.content.decode(ProductSource.self)
        try await productSource.save(on: req.db)
        return productSource
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let productSource = try await ProductSource.find(req.parameters.get("product_sourceID"),
                               on: req.db) else {
            throw Abort(.notFound)
        }
        try await productSource.delete(on: req.db)
        return .noContent
    }
}
