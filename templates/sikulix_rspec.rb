require 'rspec'

# ************************** RSpec test example ********************************
# describe 'Image' do
#   it 'finds an image' do
#     paste(Pattern("1398279958253.png").similar(0.67), 'print test string')
#     find("1392484064243.png").should_not raise_exception
#   end
#   it 'check output' do
#     1.should eql 1
#   end
# end
# *********************** end of RSpec test example ****************************

# ******************** code for running RSpec from IDE *************************
RSpec::Core::Runner.instance_variable_set '@autorun_disabled', true

config_options = RSpec::Core::ConfigurationOptions.new [
  '--format', 'j', '--out', 'rspec_result.json',
  '--format', 'h', '--out', 'rspec_result.html',
  '--format', 'progress'
]

config_options.parse_options
RSpec::Core::CommandLine.new(config_options, RSpec.configuration, RSpec.world).run(STDERR, STDOUT)
