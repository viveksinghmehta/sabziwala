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
    hostname: "ec2-34-200-101-236.compute-1.amazonaws.com",
    port: 5432,
    username: "jiiaciwpjgkaha",
    database: "d9r4ru5lbre9mh",
    password: "e18a3fdc3ab262d9435871a4b95901341fdaa4cd0c40dcd2f8c80662581ee880")

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
