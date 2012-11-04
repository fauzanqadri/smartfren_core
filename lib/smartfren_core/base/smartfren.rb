module SmartfrenCore
  module Base
    
    class Smartfren < Bridge
      
      def reload voucher_code
        page = @agent.post("http://data.smartfren.com/index.php/buy_package_connex/index",{:voucher_code => voucher_code, :reload => "Reload"},{"Referer" =>  "http://data.smartfren.com/index.php/user_info","Content-Type" => "application/x-www-form-urlencoded"})
        puts page.body
      end
      
      def buy
        premium = "http://data.smartfren.com/index.php/buy_package_connex/buy/1"
        reguler = "http://data.smartfren.com/index.php/buy_package_connex/buy/19"
        
      end
      
      def info
        page = @agent.get("http://data.smartfren.com/index.php/user_info")
        puts page.body
      end
      
      def login
        @login.merge! :login => "Login"
        page = @agent.post("http://data.smartfren.com/index.php/main/index",@login, {"Content-Type" => "application/x-www-form-urlencoded"})
        page.links.each do |li|
          return true if li.href == "http://data.smartfren.com/index.php/main/logout"
        end
        return false
      end
        
      def logout
        @agent.get "http://data.smartfren.com/index.php/main/logout"
        true
      end
      
    end
  end
end
