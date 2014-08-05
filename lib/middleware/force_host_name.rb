class ForceHostName
  def initialize(app, host)
    raise "host required" if host.blank?
    @app = app
    @host = host
    puts "Canonical host name is #{host.inspect}"
  end

  def call(env)
    env['REMOTE_HOST'] = env['SERVER_NAME'] = env['HTTP_HOST'] = @host
    env['REQUEST_URI'] = env['REQUEST_URI'].gsub %r_://[^/]+_, "://#{@host}"
    @app.call(env)
  end
end
