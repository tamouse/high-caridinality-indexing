# The typical cleaning strategies employed in rails testing don't work with cequel.
# Happily, cequel provides for this.

require 'cequel'
require 'cequel/spec_support'

RSpec.configure do |config|
  config.before do
    Cequel::SpecSupport::Preparation.setup_database(quiet: true)
  end
end
