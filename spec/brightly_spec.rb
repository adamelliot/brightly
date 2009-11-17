require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Brightly::Provider do
  it "returns html processed by markdown" do
    post '/brighten', {:markdown => File.read(File.dirname(__FILE__) + '/data/simple.markdown'), :theme => 'blackboard'}
    last_response.body.should == File.read(File.dirname(__FILE__) + '/data/simple.html')
  end

  it "returns html processed by markdown with ruby highlighted" do
    post '/brighten', {:markdown => File.read(File.dirname(__FILE__) + '/data/code.markdown'), :theme => 'blackboard'}
    last_response.body.should == File.read(File.dirname(__FILE__) + '/data/code.html')
  end

  it "returns html processed by markdown with html highlighted when there are nested <code> tags" do
    post '/brighten', {:markdown => File.read(File.dirname(__FILE__) + '/data/nested.markdown'), :theme => 'blackboard'}
    last_response.body.should == File.read(File.dirname(__FILE__) + '/data/nested.html')
  end

  it "returns html processed by markdown with embed javascript" do
    post '/brighten', {:markdown => File.read(File.dirname(__FILE__) + '/data/javascript.markdown'), :theme => 'blackboard'}
    last_response.body.should == File.read(File.dirname(__FILE__) + '/data/javascript.html')
  end
end
