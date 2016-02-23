require 'thor'
require 'savon'
require 'benchmark'

class WsdlChecker < Thor
  
  class_option :profile, :type => :boolean, banner: "Generate profile"
  class_option :verbose, :type => :boolean, aliases: "-v", banner: "Be verbose"
 
  def self.exit_on_failure?
    true
  end
 
  desc "wsdl address", "Check the wsdl contract and send a request to a operation (optional)"
  method_option :param, type: :hash, default: {}, required: false, aliases: "-p"
  method_option :operation, required: false, aliases: "-o"
  def wsdl(address)
    
    verbose_message "checking wsdl #{address} ..."
    
    time = Benchmark.realtime do
      client = wsdl_contract(address)
      wsdl_call_operation(client, get_operation, get_param)
    end

    profile_message_with time
    
    verbose_message "done checking wsdl #{address}"
    
    puts result.to_yaml
    exit 1 if error?
  end
  
  private
  
  def error?
    not result['HasError'].nil?
  end
  
  def wsdl_contract(address)
    verbose_message "Getting wsdl contract"
    begin
      client = Savon.client(wsdl: address)
      client.service_name
      add_result "Wsdl contract", "Success!"
      
      return client
    rescue Exception => msg  
      add_error "Wsdl contract error", msg
    end
  end
  
  def wsdl_call_operation(client, operation, param)
    return "" if operation.nil?
    
    verbose_message "Calling wsdl operation #{operation}"
    
    begin
      response = client.call(operation.to_sym, message: param)
      verbose_message "Wsdl call '#{operation}' response: #{response.body}"

      add_result "Wsdl call '#{operation}'", "Success!"
    rescue Exception => msg
      add_error "Wsdl call '#{operation}'", msg
    end
      
  end
  
  def get_param
    options[:param] || {}
  end
  
  def get_operation
    options[:operation]
  end
  
  def verbose_message(msg)
    puts "> #{msg}" if options[:verbose] 
  end

  def profile_message_with(time=0)
    add_result "Time elapsed", "#{time} seconds" if options[:profile]
  end

  def add_error(k, v)
    result.merge!({k => v})
    result.merge!({"HasError" => true})
  end
  
  def add_result(k, v)
    result.merge!({k => v}) 
  end
  
  def result
    @result ||= {} 
  end
 
end



