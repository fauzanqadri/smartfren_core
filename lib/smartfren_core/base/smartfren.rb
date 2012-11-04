module SmartfrenCore
  module Base
    
    class Smartfren < Bridge
      
      def reload voucher_code
        login
        data_before = featchInfo
        page = @agent.post("http://data.smartfren.com/index.php/buy_package_connex/index",{:voucher_code => voucher_code, :reload => "Reload"},{"Referer" =>  "http://data.smartfren.com/index.php/user_info","Content-Type" => "application/x-www-form-urlencoded"})
        data_after = featchInfo
        if data_after[:balance] > data_before[:balance]
          puts "Balance Before Reload #{data_before[:balance]} and now your balance is #{data_after[:balance]}"
          logout
          true
        else
          puts "Hey Something Wrong With your voucher code, yeah.. i'm sure that"
          logout
          false
        end
      end
      
      def buy paket
        login
        num = 1 if paket == 'daily'
        num = 2 if paket == 'weekly'
        num = 3 if paket == 'monthly'
        num = 19 if paket == 'reguler'
        data_before = featchInfo
        page = @agent.get(paketUrl(num))
        data_after = featchInfo
        if data_before[:packageExpiry] != data_after[:packageExpiry]
          logout
          puts "Ok, Your Package Expiry is #{data_after[:packageExpiry]}"
          return true
        else
          logout
          puts "emmm.... lets check... #{data_after[:packageExpiry]}... Something error with me"
          return false
        end
        
      end
      
      def info
        login
        data = featchInfo
        logout
        data
      end
      
     
      
      private
      
      def featchInfo
        page = @agent.get("http://data.smartfren.com/index.php/user_info")
        infoRes = Nokogiri::HTML(page.body)
        infoTable = infoRes.css("div#header div#content-details div#content-details-inside-left span.fonthitam table")
        phoneNumber = infoTable[0].css('tr:nth-child(1) td:nth-child(2)').text.gsub("\t",'')[1..-1]
        balance = infoTable[0].css('tr:nth-child(3) td:nth-child(2)').text.gsub("\t",'')[1..-1].to_i
        typeDataPackage = infoTable[1].css('tr:nth-child(1) td:nth-child(2)').text.gsub("\t",'')[1..-1]
        packageExpiry = infoTable[1].css('tr:nth-child(2) td:nth-child(2)').text.gsub("\t",'')[1..-1]
        data = {
          :phoneNumber      => phoneNumber,
          :balance          => balance,
          :typeDataPackage  => typeDataPackage,
          :packageExpiry    => packageExpiry
        }
        data
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
      
      def paketUrl num
        "http://data.smartfren.com/index.php/buy_package_connex/buy/#{num.to_s}"
      end
      
    end
  end
end
