require "sqlite3"

class Database < SQLite3::Database
  def self.connection(environment)
    @connection ||= Database.new("db/critic_#{environment}.db")
  end

  def execute(statement)
    Environment.logger.info("Executing: " + statement)
    super(statement)
  end
end