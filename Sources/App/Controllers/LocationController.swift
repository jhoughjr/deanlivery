//
//  LocationController.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//


import Fluent
import Vapor

struct LocationController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let locations = routes.grouped("locations")
        locations.get(use: index)
        locations.post(use: create)
        locations.group(":locationID") { location in
            location.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Location] {
        try await Location.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Location {
        let location = try req.content.decode(Location.self)
        try await location.save(on: req.db)
        return location
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let location = try await Marshal.find(req.parameters.get("locationID"),
                         on: req.db) else {
            
            throw Abort(.notFound)
        }
        try await location.delete(on: req.db)
        return .noContent
    }
}
