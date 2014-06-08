# Wrapper-class for cucumber-structure generation
class SikulixCucumber
  FEATURE_DIR = 'features'
  STEP_DEFS_DIR = FEATURE_DIR + '/step_definitions'
  SUPPORT_DIR = FEATURE_DIR + '/support'

  def write_file(name, dir, code)
    fn = @tmpdir + dir  + '/' + name
    File.open(fn, 'w') { |file| file.puts code }
  end

  def feature(name, code)
    write_file(name + '.feature', FEATURE_DIR, code)
  end

  def step_definition(name, code)
    write_file(name + '_steps.rb', STEP_DEFS_DIR, code)
  end

  def support(name, code)
    write_file(name + '.rb', SUPPORT_DIR, code)
  end

  def start_cucumber
    out_html = 'cucumber_result.html'
    args = [
      '--format', 'pretty',
      '--format', 'html',
      '--out', out_html
    ]
    require 'cucumber/rspec/disable_option_parser'
    require 'cucumber/cli/main'
    Cucumber::Cli::Main.new(args).execute!
    # File.open(out_html, 'w') { |out| Cucumber::Cli::Main.new(args, STDIN, out).execute! }

    # system out_html
  end

  def cucumber_test
    require 'tmpdir'
    @tmpdir = Dir.mktmpdir + '/'

    puts 'cucumber tmpdir: ' + @tmpdir

    [FEATURE_DIR, STEP_DEFS_DIR].each do |dir|
      Dir.mkdir @tmpdir + dir unless Dir.exist? @tmpdir + dir
    end

    yield self

    Dir.chdir @tmpdir
    start_cucumber
    # FileUtils.remove_entry @tmpdir
  end
end

def SikulixCucumber(&block)
  SikulixCucumber.new.cucumber_test(&block)
end

# ************************ cucumber test **************************************
# *****************************************************************************
#
#  Example from "The RSpec Book: Behaviour-Driven Development with RSpec,
#                Cucumber, and Friends"
#

SikulixCucumber do |t|

  # -------------------------   features declaration ---------------------------
  t.feature 'test1', <<-FEATURE
Feature: code-breaker starts game

  As a code-breaker
  I want to start a game
  So that I can break the code

  Scenario: start game
    Given I am not yet playing
    When I start a new game
    Then I should see "Welcome to Codebreaker!"
    And I should see "Enter guess:"
FEATURE
  # -------------------- end of feature declaration ----------------------------

  # ========================  steps declaration ================================
  t.step_definition 'test1', <<-STEP
Given(/^I am not yet playing$/) do
  pending # express the regexp above with the code you wish you had
  #p find("1401798324089.png")
end

When(/^I start a new game$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
STEP
  # ========================  end of steps declaration =========================

end
# ******************************************************************************
# ************************ end of cucumber test ********************************
