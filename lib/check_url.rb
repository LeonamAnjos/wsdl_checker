require 'thor'

class CheckUrl < Thor
  
  #:banner: The short description of the option, printed out in the usage description. By default, this is the upcase version of the flag (from=FROM).
  #:default: The default value of this option if it is not provided. An option cannot be both :required and have a :default.
  #:type: :string, :hash, :array, :numeric, or :boolean
  #:aliases: A list of aliases for this option. Typically, you would use aliases to provide short versions of the option.
  #options :from => :required, :yell => :boolean
  
  class_option :verbose, :type => :boolean
 
  desc "url address", "send a request to the URL specified"
  def url(address)
    puts "> send get to #{address}" if options[:verbose]
    puts "> done sending get to #{address}" if options[:verbose]
  end
 
end

CheckUrl.start(ARGV)
