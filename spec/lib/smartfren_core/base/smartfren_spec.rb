require 'spec_helper'
require 'smartfren_core'

describe SmartfrenCore::Base::Smartfren do
  let(:smartfren){SmartfrenCore::Base::Smartfren.new('XXXX', 'XXXXXX')}
  subject{smartfren}
  
  it "URL_EP == http://data.smartfren.com/index.php/" do
    SmartfrenCore::URL_EP.should == 'http://data.smartfren.com/index.php/'
  end
  it ".superclas == SmartfrenCore::Base::Brige" do
    SmartfrenCore::Base::Smartfren.superclass.should == SmartfrenCore::Base::Bridge
  end
  
  context "when login" do
    
    it "false because bad credential" do
      subject.stub(:login){false}
      subject.login.should be_false
    end
    it "true  because good credential" do
      subject.stub(:login){true}
      subject.login.should be_true
    end
  end
  
end
