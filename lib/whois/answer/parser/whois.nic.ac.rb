#
# = Ruby Whois
#
# An intelligent pure Ruby WHOIS client and parser.
#
#
# Category::    Net
# Package::     Whois
# Author::      Simone Carletti <weppos@weppos.net>
# License::     MIT License
#
#--
#
#++


require 'whois/answer/parser/base'


module Whois
  class Answer
    class Parser

      #
      # = whois.nic.ac parser
      #
      # Parser for the whois.nic.ac server.
      #
      class WhoisNicAc < Base

        property_not_supported :disclaimer

        property_supported :domain do
          @domain ||= Proc.new do
            content.to_s =~ /Domain "(.*?)"/
            $1.downcase
          end.call
        end

        property_not_supported :domain_id


        property_supported :status do
          @status ||= if available?
            :available
          else
            :registered
          end
        end

        property_supported :available? do
          @available ||= !(content.to_s =~ /Not available/)
        end

        property_supported :registered? do
          !available?
        end


        property_not_supported :created_on

        property_not_supported :updated_on

        property_not_supported :expires_on


        property_not_supported :registrar

        property_not_supported :registrant

        property_not_supported :admin

        property_not_supported :technical


        property_not_supported :nameservers


        property_supported :changed? do |other|
          !unchanged?(other)
        end

        property_supported :unchanged? do |other|
          self == other ||
          self.content.to_s == other.content.to_s
        end

      end
      
    end
  end
end  