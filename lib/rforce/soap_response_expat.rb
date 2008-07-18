require 'xml/parser'
require 'rforce/soap_pullable'

module RForce
  class SoapResponseExpat
    include MethodKeys
    include SoapPullable

    def initialize(content)
      @current_value = nil
      @stack = []
      @parsed = {}
      @done = false
      @namespaces = []
      
      XML::Parser.new.parse(content) do |type, name, data|
        case type
        when XML::Parser::START_ELEM
          tag_start name, data
        when XML::Parser::CDATA
          text data
        when XML::Parser::END_ELEM
          tag_end name
        end
          
        break if @done
      end

      self
    end

    def [](key)
      @parsed[key.to_sym]
    end
  end
end
