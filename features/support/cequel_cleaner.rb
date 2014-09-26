require 'cequel'
require 'cequel/spec_support'

# Provides very basic cleaning of the Cassandra database

Before do
  Cequel::SpecSupport::Preparation.setup_database(quiet: true)
end
