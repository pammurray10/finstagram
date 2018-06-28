configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    set :database, {
    adapter: "sqlite3",
    database: "db/db.sqlite3"
    }
  else
      db = URI.parse(ENV['DATABASE_URL'] || 'postgres://rtwltjhekvugfg:3cc6fe74cf222e4c610c0303b64efc1e6a6017aa52a50340284564b6b45b1391@ec2-54-227-247-225.compute-1.amazonaws.com:5432/danejf40uiglkh
')
  set :database, {
  adapter: "postgresql",
  host: db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: "utf8"
  }
  
  end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
