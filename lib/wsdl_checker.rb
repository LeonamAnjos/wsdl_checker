require 'thor'
require 'savon'
require 'benchmark'

class WsdlChecker < Thor
  
  class_option :profile, :type => :boolean, banner: "Generate profile"
  class_option :verbose, :type => :boolean, aliases: "-v", banner: "Be verbose"
 
  def self.exit_on_failure?
    true
  end
 
  desc "wsdl address", "send a request to the wsdl operation specified"
  method_option :param, type: :hash, default: {}, required: false, aliases: "-p"
  def wsdl(address)
    
    verbose_message "checking wsdl #{address} ..."
    
    time = Benchmark.realtime do
      show_result wsdl_contract(address) 
    end

    profile_message_with time
    
    verbose_message "done checking wsdl #{address}"
    
    puts result.to_yaml
  end
  
  private
  
  def wsdl_contract(address)
    begin
      client = Savon.client(wsdl: address)
      response = client.call(:calc_preco_prazo, message: get_param)
      
      verbose_message "Response: #{response.body}"
      response.success?
    rescue Exception => msg  
      show_error msg
      false
    end
  end
  
  def get_param
    options[:param] || {}
  end
  
  def verbose_message(msg)
    puts "> #{msg}" if options[:verbose] 
  end

  def show_error(msg)
    add_result "Error", msg
  end
  
  def show_result(success)
    add_result "Result", success ? "Success!" : "Fail!"
  end
  
  def profile_message_with(time=0)
    add_result "Time elapsed", "#{time} seconds" if options[:profile]
  end
  
  def add_result(k, v)
    result.merge!({k => v}) 
  end
  
  def result
    @result ||= {} 
  end
 
end



