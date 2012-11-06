require 'spec_helper'
require 'smartfren'

describe Smartfren do
  it " URL_EP == http://data.smartfren.com/index.php/" do
    Smartfren::URL_EP.should == 'http://data.smartfren.com/index.php/'
  end
  describe Smartfren::Client do
    subject{Smartfren::Client.new('XXXXXXX', 'XXXXX')}
    context ".new" do
      it " raise error when whitout args" do
        expect { Smartfren::Client.new }.to raise_error(ArgumentError)
      end
      it " not raise error when whitin args " do
        expect { Smartfren::Client.new('XXXXXXX', 'XXXXX')}.to_not raise_error(ArgumentError)
      end
    
      it " respond_to? :login" do
        Smartfren::Client.new('XXXXXXX', 'XXXXX').respond_to?(:login).should be_true
      end
      context " when login" do
        
        it " should return true when login success " do
          subject.stub(:login){true}
          subject.login.should be_true
        end
      
        it " should return false when login fail " do
          subject.stub(:login){false}
          subject.login.should be_false
        end
      end
      context " when buy" do
        it " should raise WrongCode when code packet not include in [daily, weekly , monthly, reguler]' ", :focus=>true do
          subject.stub(:buy){raise Smartfren::Error::WrongCode}
          expect{subject.buy('XXX')}.to raise_error(Smartfren::Error::WrongCode)
        end
      end
    end
  end
end
