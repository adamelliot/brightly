module Brightly
  module Provider
    autoload :Base, "brightly/provider/base"
    
    autoload :Config, "brightly/provider/config"
    autoload :Exec, "brightly/provider/exec"
  end
  
  autoload :Consumer, "brightly/consumer"
end
