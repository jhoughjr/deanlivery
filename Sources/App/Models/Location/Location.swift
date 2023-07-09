//
//  Location.swift
//
//
//  Created by Jimmy Hough Jr on 7/9/23.
//

import Foundation
import Fluent
import Vapor

final class Location: Model, Content {
    static let schema = "locations"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "lat")
    var lat:Double?
    
    @Field(key: "lng")
    var lng:Double?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }

    init(id: UUID? = nil,
         title: String,
         lat: Double,
         lng: Double) {
        self.id = id
        self.title = title
        self.lat = lat
        self.lng = lng
    }
}
    
