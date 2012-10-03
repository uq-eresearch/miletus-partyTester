# OAI Record provider.
#
# Copyright (C) 2012, The University of Queensland.
#----------------------------------------------------------------

require 'oai'
require 'partyTester/output/oaipmh/record'
require 'partyTester/output/oaipmh/rifcs_format'

module PartyTester
  module Output
    module OAIPMH

      # TODO: refactor this code to merge it with the Ruby on Rails
      # created model in app/models/party_record.rb

      class RecordProvider < OAI::Provider::Base
        
        # Obtain the email address to use as the adminEmail.  Either
        # from the ADMIN_EMAIL environment variable, or derive it from
        # the current user and hostname.

        def self.get_admin_email

          if ENV.has_key? 'ADMIN_EMAIL'
            # Use environment variable
            email = ENV['ADMIN_EMAIL']

          else
            # Derive from username and host

            require 'etc'
            require 'socket'

            host = Socket.gethostname
            if host =~ /^\w+$/
              host = host + '.example.com'
            end

            email = '%s@%s' % [Etc.getlogin, host]
          end

          # Check syntax is correct according to OAI-PMH.
          # adminEmail must match this XML Schema regex: \S+@(\S+\.)+\S+"
          # where \S means any non-whitespace character (space, tab, cr, lf)

          if email !~ /^\S+@(\S+\.)+\S+$/
            if ENV.has_key? 'ADMIN_EMAIL'
              raise "Error: $ADMIN_EMAIL format incorrect: #{email}"
            else
              raise "Error: $ADMIN_EMAIL env variable not set: #{email}"
              end
          end

          email
        end
        
        #----
        # Configuring the default provider

        repository_name 'PartyTester'
        admin_email get_admin_email

        rclass = PartyTester::Output::OAIPMH::Record
        source_model OAI::Provider::ActiveRecordWrapper.new(rclass)

        register_format(RifcsFormat.instance)

        def self.prefix
          "oai:%s" % URI.parse(self.url).host
        end

      end # class RecordProvider

    end
  end
end
