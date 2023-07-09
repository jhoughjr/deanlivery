import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(configuration: SQLPostgresConfiguration(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    app.migrations.add(CreateTodo())
    
//    app.migrations.add(User.CreateUser())
//    app.migrations.add(Customer.CreateCustomer())
//    app.migrations.add(Marshal.CreateMarshal())
//    app.migrations.add(Supplier.CreateSupplier())

//    app.migrations.add(Location.CreateLocation())
//    
//    app.migrations.add(ProductSource.CreateProductSource())
//    app.migrations.add(Product.CreateProduct())
//    
//    app.migrations.add(Order.CreateOrder())
//    app.migrations.add(ScheduledDelivery.CreateScheduledDelivery())
//    app.migrations.add(CompletedDelivery.CreateCompletedDelivery())
//    app.migrations.add(ScheduledPayment.CreateScheduledPayment())
//    app.migrations.add(CompletedPayment.CreateCompletedPayment())
    
    app.views.use(.leaf)

    // register routes
    try routes(app)
}
