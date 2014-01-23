class Environment
  def self.database_connection(environment = "production")
    @connection ||= SQLite3::Database.new("db/critic_#{environment}.db")
  end
end