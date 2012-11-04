module SmartfrenCore
  module Base
    
    class Bridge
      
      def initialize phone,password
        @agent = Mechanize.new
        @agent.log = Logger.new "./log/smartfren_core.log"
        @login = {
          :smart_no   =>  phone,
          :user_pass  =>  password,
        }
      end
      
    end
    
  end
end