require 'tod'
require 'json'
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
  
# p = PeriodicEvents.new(nil,nil,nil,nil,nil,['thursday', 'night'])
# puts p.satisfies Time.local(2021,3,25,20,10)

def abac()

    # database = msg[:database]
    collection = "inventory"
    op = "find"
    json1 = File.read('/home/eeshan/mongo-proxy/lib/mongo-proxy/user_attributes.json')
    user_attributes = JSON.parse(json1)
    json2 = File.read('/home/eeshan/mongo-proxy/lib/mongo-proxy/object_attributes.json')
    object_attributes = JSON.parse(json2)
    json3 = File.read('/home/eeshan/mongo-proxy/lib/mongo-proxy/policy.json')
    policy = JSON.parse(json3)
    allow = false

    policy.each do |rule|
        puts "Rule 1:\n"
      ua_req = rule['user_attributes']
      oa_req = rule['object_attributes']
      env_req = rule['env']
      satisfy = true
        puts satisfy
      ua_req.keys.each do |key|
        if ua_req[key] != user_attributes[key]
          satisfy = false
        end
      end
      puts satisfy
      puts oa_req
      oa_req.keys.each do |key|
        if oa_req[key] != object_attributes[key]
          satisfy = false
        end
      end
      puts satisfy

      p = PeriodicEvents.new(nil,nil,nil,nil,nil,rule['env']['time'])

      if not p.satisfies(nil)
        satisfy = false
      end
      puts satisfy

      if satisfy
        prms = rule['permissions']
        if prms[collection] and prms[collection].include? op
          allow = true
        end
      end

    end
    return allow
end
puts "fff"
    puts abac