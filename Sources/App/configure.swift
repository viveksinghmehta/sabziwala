import Vapor
import Leaf
import FluentPostgreSQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    middlewares.use(FileMiddleware.self)
    services.register(middlewares)

    // Configure a PostgreSQL database
    let postgreDatabaseConfig = PostgreSQLDatabaseConfig(
    hostname: "drona.db.elephantsql.com",
    port: 5432,
    username: "jlvyhmal",
    database: "jlvyhmal",
    password: "yvjcZ9gqrSLHeHBaYTVK9gR9DFGS1zDy")

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    let postgreDatabase = PostgreSQLDatabase(config: postgreDatabaseConfig)
    databases.add(database: postgreDatabase, as: .psql)
    services.register(databases)
    
    

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: HospitalModel.self, database: .psql)
    migrations.add(model: AddressModel.self, database: .psql)
    migrations.add(model: PhoneNumberModel.self, database: .psql)
    services.register(migrations)
}
