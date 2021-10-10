require 'em-proxy'
require 'logger'
require 'json'
require 'pp'
require 'socket'
require 'timeout'
require 'tod'
require 'openssl'
require 'base64'

class PeriodicEvents
  def initialize(validity, time_of_day_range, days_of_week_range, dates_of_month_range, months_of_year_range, special_keywords)
    @validity = validity
    @time_of_day_range = time_of_day_range
    @days_of_week_range = days_of_week_range
    @dates_of_month_range = dates_of_month_range
    @months_of_year_range = months_of_year_range
    @special_keywords = special_keywords

    if @special_keywords.include? 'any day' or @special_keywords.include? 'full week'
      if @days_of_week_range
        @days_of_week_range += [0,1,2,3,4,5,6]
      else
        @days_of_week_range = [0,1,2,3,4,5,6]
      end
    end
    if @special_keywords.include? 'weekdays' or @special_keywords.include? 'weekday'
      if @days_of_week_range
        @days_of_week_range += [1,2,3,4,5]
      else
        @days_of_week_range = [1,2,3,4,5]
      end
    end
    if @special_keywords.include? 'weekend' or @special_keywords.include? 'weekends'
      if @days_of_week_range
        @days_of_week_range += [0,6]
      else
        @days_of_week_range = [0,6]
      end    
    end
    if @special_keywords.include? 'monday' or @special_keywords.include? 'mondays' 
      if @days_of_week_range
        @days_of_week_range += [1]
      else
        @days_of_week_range = [1]
      end
    end
    if @special_keywords.include? 'tuesday' or @special_keywords.include? 'tuesdays' 
      if @days_of_week_range
        @days_of_week_range += [2]
      else
        @days_of_week_range = [2]
      end
    end
    if @special_keywords.include? 'wednesday' or @special_keywords.include? 'wednesdays' 
      if @days_of_week_range
        @days_of_week_range += [3]
      else
        @days_of_week_range = [3]
      end
    end
    if @special_keywords.include? 'thursday' or @special_keywords.include? 'thursdays' 
      if @days_of_week_range
        @days_of_week_range += [4]
      else
        @days_of_week_range = [4]
      end
    end
    if @special_keywords.include? 'friday' or @special_keywords.include? 'fridays' 
      if @days_of_week_range
        @days_of_week_range += [5]
      else
        @days_of_week_range = [5]
      end
    end
    if @special_keywords.include? 'saturday' or @special_keywords.include? 'saturdays' 
      if @days_of_week_range
        @days_of_week_range += [6]
      else
        @days_of_week_range = [6]
      end
    end
    if @special_keywords.include? 'sunday' or @special_keywords.include? 'sundays' 
      if @days_of_week_range
        @days_of_week_range += [0]
      else
        @days_of_week_range = [0]
      end
    end
    t1 = Tod::TimeOfDay.parse "8am"
    t2 = Tod::TimeOfDay.parse "noon"
    t3 = Tod::TimeOfDay.parse "4pm"
    t4 = Tod::TimeOfDay.parse "7pm"
    t5 = Tod::TimeOfDay.parse "6am"
    t6 = Tod::TimeOfDay.parse "6pm"
    t7 = Tod::TimeOfDay.parse "9am"
    t8 = Tod::TimeOfDay.parse "5pm" 
    if @special_keywords.include? 'morning' or @special_keywords.include? 'mornings'
      if not @time_of_day_range
          @time_of_day_range = []
      end
      @time_of_day_range.append([t1,t2])
    end
    if @special_keywords.include? 'evening' or @special_keywords.include? 'evenings'
      if not @time_of_day_range
          @time_of_day_range = []
      end
      @time_of_day_range.append([t3,t4])
    end
    if @special_keywords.include? 'day' or @special_keywords.include? 'days'
      if not @time_of_day_range
        @time_of_day_range = []
      end
      @time_of_day_range.append([t5,t6])
    end
    if @special_keywords.include? 'night' or @special_keywords.include? 'nights'
      if not @time_of_day_range
          @time_of_day_range = []
      end
      @time_of_day_range.append([t6,t5])
    end
    if @special_keywords.include? 'office' or @special_keywords.include? 'mornings'
      if not @time_of_day_range
          @time_of_day_range = []
      end
      @time_of_day_range.append([t7,t8])
    end
    if @special_keywords.include? 'january'
      if @months_of_year_range
        @months_of_year_range += [1]
      else
        @months_of_year_range = [1]
      end
    end
    if @special_keywords.include? 'february'
      if @months_of_year_range
        @months_of_year_range += [2]
      else
        @months_of_year_range = [2]
      end
    end
    if @special_keywords.include? 'march'
      if @months_of_year_range
        @months_of_year_range += [3]
      else
        @months_of_year_range = [3]
      end
    end
    if @special_keywords.include? 'april'
      if @months_of_year_range
        @months_of_year_range += [4]
      else
        @months_of_year_range = [4]
      end
    end
    if @special_keywords.include? 'may'
      if @months_of_year_range
        @months_of_year_range += [5]
      else
        @months_of_year_range = [5]
      end
    end
    if @special_keywords.include? 'june'
      if @months_of_year_range
        @months_of_year_range += [6]
      else
        @months_of_year_range = [6]
      end
    end
    if @special_keywords.include? 'july'
      if @months_of_year_range
        @months_of_year_range += [7]
      else
        @months_of_year_range = [7]
      end
    end
    if @special_keywords.include? 'august'
      if @months_of_year_range
        @months_of_year_range += [8]
      else
        @months_of_year_range = [8]
      end
    end
    if @special_keywords.include? 'september'
      if @months_of_year_range
        @months_of_year_range += [9]
      else
        @months_of_year_range = [9]
      end
    end
    if @special_keywords.include? 'october'
      if @months_of_year_range
        @months_of_year_range += [10]
      else
        @months_of_year_range = [10]
      end
    end
    if @special_keywords.include? 'november'
      if @months_of_year_range
        @months_of_year_range += [11]
      else
        @months_of_year_range = [11]
      end
    end
    if @special_keywords.include? 'december'
      if @months_of_year_range
        @months_of_year_range += [12]
      else
        @months_of_year_range = [12]
      end
    end
  end

  def satisfies(t)
    if not t
      t = Time.now
    end

    if not @special_keywords
      return true
    end

    if @validity and (t < @validity[0] or t > @validity[1])
      return false
    end

    if @special_keywords and @special_keywords.include? 'all'
      return true
    end

    if @days_of_week_range and not @days_of_week_range.include? t.wday
      return false
    end

    if @dates_of_month_range and not @dates_of_month_range.include? t.day
      return false
    end

    if @months_of_year_range and not @months_of_year_range.include? t.month
      return false
    end

    time_of_day = Tod::TimeOfDay.new(t.hour, t.min, t.sec)
    valid = true
    if @time_of_day_range
      valid = false
      @time_of_day_range.each do |x|
      st = x[0]
      en = x[1]
      if st <= en
        if time_of_day >= st and time_of_day <= en
            valid = true
        end
      else
        if time_of_day >= st or time_of_day <= en
            valid = true
        end
      end
    end
    end
    return valid
  end

end

# This class uses em-proxy to help listen to MongoDB traffic, with some
# parsing and filtering capabilities that allow you to enforce a read-only
# mode, or use your own arbitrary logic.
class MongoABAC
  VERSION = '1.0.1'

  def initialize(config = nil)
    # default config values
    @config = {
      :client_host => '127.0.0.1', # Set the host to bind the proxy socket on.
      :client_port => 29017,       # Set the port to bind the proxy socket on.
      :server_host => '127.0.0.1', # Set the backend host which we proxy.
      :server_port => 27017,       # Set the backend port which we proxy.
      :motd => nil,                # Set a message-of-the-day to display to clients when they connect. nil for none.
      :read_only => false,         # Prevent any traffic that writes to the database.
      :verbose => false,           # Print out MongoDB wire traffic.
      :logger => nil,              # Use this object as the logger instead of creating one.
      :debug => false              # Print log lines in a more human-readible format.
    }
    @front_callbacks = []
    @back_callbacks = []
    @flag = false
    @recent = nil
    @user = nil 
    # apply argument config to the default values
    (config || []).each do |k, v|
      if @config.include?(k)
        @config[k] = v
      else
        raise "Unrecognized configuration value: #{k}"
      end
    end

    # debug implies verbose
    @config[:verbose] = true if @config[:debug]

    # Set up the logger for mongo proxy. Users can also pass their own
    # logger in with the :logger config value.
    unless @config[:logger]
      @config[:logger] = Logger.new(STDOUT)
      @config[:logger].level = (@config[:verbose] ? Logger::DEBUG : Logger::WARN)

      if @config[:debug]
        @config[:logger].formatter = proc do |_, _, _, msg|
          if msg.is_a?(Hash)
            "#{JSON::pretty_generate(msg)}\n\n"
          else
            "#{msg}\n\n"
          end
        end
      end
    end

    unless port_open?(@config[:server_host], @config[:server_port])
      raise "Could not connect to MongoDB server at #{@config[:server_host]}.#{@config[:server_port]}"
    end

    @log = @config[:logger]
    @auth = AuthMongo.new(@config)
  end

  def start
    # em proxy launches a thread, this is the error handler for it
    EM.error_handler do |e|
      @log.error [e.inspect, e.backtrace.first]
      raise e
    end

    # kick off em-proxy
    Proxy.start({
        :host => @config[:client_host],
        :port => @config[:client_port],
        :debug => false
      },
      &method(:callbacks))
  end

  def add_callback_to_front(&block)
    @front_callbacks.insert(0, block)
  end

  def add_callback_to_back(&block)
    @back_callbacks << block
  end

  private

  def verify_certificate(certificate_raw, public_key_raw) 

    certificate = OpenSSL::X509::Certificate.new certificate_raw
    public_key = OpenSSL::PKey::RSA.new public_key_raw

    return certificate.verify(public_key)
  end

  def decrypt(encrypted, key, iv)
  

    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt

    decipher.key = Base64.decode64(key)
    decipher.iv = Base64.decode64(iv)

    raw = decipher.update(Base64.decode64(encrypted)) + decipher.final

    return raw
    
  end
  

  def abac(msg, user_name, ip)
    nil 
    nil 
    nil 
    days = {0 => "Sunday",
            1 => "Monday", 
            2 => "Tuesday",
            3 => "Wednesday",
            4 => "Thursday",
            5 => "Friday",
            6 => "Saturday"}

    nil 
    database = msg[:database]
    collection = msg[:collection]
    op = nil
    opcode = msg[:header][:opCode].to_s
    # user = "test"

    json1 = File.read('/home/eeshan/mongo-proxy/lib/mongo-proxy/user_attributes.json')
    user_attributes_all = JSON.parse(json1)
    # ua found in file
    user_attributes = user_attributes_all.filter_map{|ua| ua[user_name]}.first

    # ua obtained from encypted file
    if not user_attributes

      nil 
      encrypted = File.read "/home/eeshan/mongo-proxy/lib/mongo-proxy/encrypted_ua.txt"
      key = File.read "/home/eeshan/mongo-proxy/lib/mongo-proxy/encrypted_key.txt"
      iv = File.read "/home/eeshan/mongo-proxy/lib/mongo-proxy/encrypted_iv.txt"

      decoded_ua = decrypt(encrypted, key, iv)
      decoded_ua_json = JSON.parse(decoded_ua)

      certificate = decoded_ua_json['cert']
      public_key = decoded_ua_json['pk']

      if verify_certificate(certificate, public_key)

        user_attributes = decoded_ua_json['ua']
        certificate = OpenSSL::X509::Certificate.new certificate
        nil 
      else
        nil 
        return false
      end

    end

    json2 = File.read('/home/eeshan/mongo-proxy/lib/mongo-proxy/object_attributes.json')
    object_attributes = JSON.parse(json2)
    
    json3 = File.read('/home/eeshan/mongo-proxy/lib/mongo-proxy/policy.json')
    policy = JSON.parse(json3)

    json4 = File.read('/home/eeshan/mongo-proxy/lib/mongo-proxy/config.json')
    config = JSON.parse(json4)
    
    if database == "admin"
      return true
    end
    nil 
    nil 

    if opcode != "query"
      # nil 
      op = opcode
    else      
      if collection != "$cmd"
        op = "find"
      else
        if msg[:query].keys.include? "forShell"
          return true
        else
          op = msg[:query].keys[0]
          collection = msg[:query][op]
        end
      end
  
    end
    nil
    nil
    nil
    
    allow = false

    num_rules = config['rules']
    num_attrs = config['attrs']

    (3..num_rules).each do |n|
      policy.append(policy[0])
    end

    nil

    policy.each do |rule|
      nil
      ua_req = rule['user_attributes']
      oa_req = rule['object_attributes']
      env_req = rule['env']
      satisfy = true
      
      ua_req.keys.each do |key|
        if ua_req[key] != user_attributes[key]
          satisfy = false
        end
      end



      oa_req.keys.each do |key|
        if oa_req[key] != object_attributes[key]
          satisfy = false
        end
      end

      if not satisfy
        nil 
      elsif
        nil 
      end
      p = PeriodicEvents.new(nil,nil,nil,nil,nil,rule['env']['time'])

      if not p.satisfies(nil)
        satisfy = false
        nil 
      elsif
        nil 
      end



      ip_req = rule['env']['ip']
      ip_found = false
      ip_req.each do |ip_check|
        ip_regex = Regexp.new ip_check 
        if (ip_regex =~ ip)
          ip_found = true
          nil 
        elsif
          nil 
        end
      end
      
      if not ip_found
        satisfy = false
      end

      if satisfy
        prms = rule['permissions']
        # nil 
        # nil 
        # nil 
        if prms[collection] and prms[collection].include? op
          nil 
          allow = true
        elsif
          nil 
        end
      end

    end
    if not allow
      nil 
    end
    nil 
    return allow

    # user_attributes = {:position=>"Manager", :region=>"WestCoast"}
    # object_attributes = {:region=>"WestCoast", :recordof=>"Customer"}
    # policy = {[{:position=>"Manager", :region=>"WestCoast"}, {:region=>"WestCoast", :recordof=>"Customer"}]=>["find", "insert"], [{:position=>"Associate", :region=>"WestCoast"}, {:region=>"WestCoast", :recordof=>"Customer"}]=>["find"]}
    # attributes = [user_attributes, object_attributes]
    # if policy.keys.include? attributes
    #   prms = policy[attributes]
    #   allow = prms.include? op
    # end

    # return allow


  end

#  client -> proxy-server -> MongoDB -> proxy-server ( ABAC ) -> client


  def callbacks(conn)
    conn.server(:srv, {
      :host => @config[:server_host],
      :port => @config[:server_port]})
    conn.on_data do |data|
      # parse the raw binary message
      @flag = false
      # nil 
      raw_msg, msg = WireMongo.receive(data)
      @recent = msg
      # nil 
      # nil 
      # nil 
      nil 
      user_name = "Alice"
      if abac(msg, user_name, "127.0.0.1")
        @flag = true
      end

      # nil 
      # nil 
      @log.info 'from client'
      @log.info msg

      if raw_msg == nil
        @log.info "Client disconnected"
        # nil 
        return
      end

      @front_callbacks.each do |cb|
        msg = cb.call(conn, msg)
        break unless msg
      end
      next unless msg

      # get auth response about client query
      authed = (@config[:read_only] == true ? @auth.wire_auth(conn, msg) : true)
      r = nil

      if authed == true # auth succeeded
        @back_callbacks.each do |cb|
          msg = cb.call(conn, msg)
          break unless msg
        end
        next unless msg
        # nil 
        r = WireMongo::write(msg)
    
      elsif authed.is_a?(Hash) # auth had a direct response
        response = WireMongo::write(authed)
        # nil 
        conn.send_data(response)

      else # otherwise drop the message
        @log.info 'dropping message'

      end
      # nil 
      r
    end

    # messages back from the server
    conn.on_response do |backend, resp|

      if @config[:verbose]
        _, msg = WireMongo::receive(resp)
        # nil 
        # nil 
        # nil 
        @log.info 'from server'
        @log.info msg
      end
      _, msg = WireMongo::receive(resp)
      # if flag
      # nil 
      if not @flag
        @flag = false
        msg[:responseFlags] = 2
        msg[:cursorId] = 0
        msg[:numberReturned] = 1
        msg[:documents] =  [{"$err"=>"UnauthorizedError: not authorized to execute command #{@recent[:header][:opCode]} on collection #{@recent[:collection]} of database #{@recent[:database]}", "code"=>13}]
        resp = WireMongo::write(msg)
      end
      resp
    end

    conn.on_finish do |backend, name|
      @log.info "closing client connection #{name}"
    end
  end

  # http://stackoverflow.com/questions/517219/ruby-see-if-a-port-is-open
  def port_open?(ip, port, seconds=1)
    Timeout::timeout(seconds) do
      begin
        TCPSocket.new(ip, port).close
        true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        false
      end
    end
  rescue Timeout::Error
    false
  end
end

