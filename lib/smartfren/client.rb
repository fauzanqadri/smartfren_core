module Smartfren
  class Client
    def initialize phone,password
      @agent = Mechanize.new
      @agent.log = Logger.new(defined?(Rails) == 'constant' ? "./log/smartfren_core.log" : Smartfren.root+"/smartfren_core.log") 
      @login = {
        :smart_no   =>  phone,
        :user_pass  =>  password,
      }
    end
      
    def reload voucher_code
      login
      data_before = featchInfo
      page = @agent.post(Smartfren::URL_EP+"buy_package_connex/index",{:voucher_code => voucher_code, :reload => "Reload"},{"Referer" =>  Smartfren::URL_EP+"user_info","Content-Type" => "application/x-www-form-urlencoded"})
      res = if featchInfo[:balance] > data_before[:balance]
        "Balance Before Reload #{data_before[:balance]} and now your balance is #{featchInfo[:balance]}"
      else
        "Hey Something Wrong With your voucher code, yeah.. i'm sure that"
      end
      logout
      res
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
      res = if featchInfo[:packageExpiry] != data_after[:packageExpiry]
        "Ok, Your Package Expiry is #{featchInfo[:packageExpiry]}"
      else
        "emmm.... lets check... #{featchInfo[:packageExpiry]}... Something error with me"
      end
      logout
      res        
    end
      
    def info
      login
      data = featchInfo
      logout
      data
    end
      
     
      
    #private
      
    def featchInfo
      page = @agent.get(Smartfren::URL_EP+"user_info")
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
      page = @agent.post(Smartfren::URL_EP+"main/index",@login, {"Content-Type" => "application/x-www-form-urlencoded"})
      page.links.each do |li|
        true if li.href == Smartfren::URL_EP+"main/logout"
      end
      false
    end
        
    def logout
      @agent.get Smartfren::URL_EP+"main/logout"
      true
    end
      
    def paketUrl num
      Smartfren::URL_EP+"buy_package_connex/buy/#{num.to_s}"
    end
     
  end
end