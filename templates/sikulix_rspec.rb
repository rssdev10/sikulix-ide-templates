require 'rspec'
# Code for using methods such as 'describe'
# in global scope
RSpec.configure do |c|
  c.expose_dsl_globally = true
end

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

config_options = RSpec::Core::ConfigurationOptions.new [
  '--format', 'j', '--out', 'rspec_result.json',
  '--format', 'h', '--out', 'rspec_result.html',
  '--format', 'progress',
]

RSpec::Core::Runner.new(config_options).run(STDERR, STDOUT)
