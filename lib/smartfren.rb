require "mechanize"
require "logger"
module Smartfren
  URL_EP = 'http://data.smartfren.com/index.php/'
  # Your code goes here...
  def self.root
   File.expand_path '../', __FILE__
  end
end
require "smartfren/version"
require "smartfren/error"
require "smartfren/client"