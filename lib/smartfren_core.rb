require "mechanize"
require "logger"
require "smartfren_core/version"
require "smartfren_core/base"
require "smartfren_core/base/smartfren"

module SmartfrenCore
  # Your code goes here...
  def self.root
     File.expand_path '../', __FILE__
   end
end
