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
    out_html = 'report.html'
    args = [
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

    [FEATURE_DIR, STEP_DEFS_DIR, SUPPORT_DIR].each do |dir|
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

SikuliX_Cucumber do |t|

# ---------------------------   features declaration ---------------------------
t.feature 'libre_office_test_example', <<-FEATURE
Feature: Change text properties
  As a user
  I want to change properties of selected text
  In order to make my text less or more readable

  Background:
    Given text fragment selected
    And menu opened by click on "1400188760887.png"

  Scenario Outline: user changes the case
    Given submenu opened by hover "1400350284909.png"
    When I click on <click img>
    Then I should see <effect img>
  Examples:
    |click img        |effect img       |
    |"1400350576310.png"|"1401096088583.png"|
    |"1400350598717.png"|"1401096113685.png"|
    |"1400350631803.png"|"1401096139905.png"|
    |"1400350699565.png"|"1401096155359.png"|
    |"1400350736464.png"|"1401096173233.png"|

  Scenario Outline: user chooses garniture and size by filling
    Given window opened by click on "1401098332746.png"
    And tab opened by click on "1401098400242.png"
    When I fill in <field> with <string>
    And confirm window by click on "1401098439831.png"
    Then I should see <effect img>
  Examples:
    |field            |string      |effect img       |
    |Pattern("1401098705948.png").targetOffset(-25,25)|Segoe Script|"1401099021597.png"|
    |Pattern("1401098838926.png").targetOffset(-25,25)|20          |"1401099724885.png"|

  Scenario Outline: user chooses garniture, style and size by clicking
    Given window opened by click on "1401098332746.png"
    And tab opened by click on "1401098400242.png"
    And <element> is found by scrolling <area header>
    When I click on <element>
    And confirm window by click on "1401098439831.png"
    Then I should see <effect img>
  Examples:
    |element|area header|effect img|
    |"1401102135075.png"|"1401098705948.png"|"1401102171776.png"|
    |"1401103280364.png"|"1401098705948.png"|"1401103293396.png"|
    |"1401103430270.png"|"1401103481633.png"|"1401103437794.png"|
    |"1401103547582.png"|"1401098838926.png"|"1401103558898.png"|
FEATURE
# ---------------------- end of feature declaration ----------------------------

# ==========================  steps declaration ================================
t.step_definition 'libre_office_test_example', <<-STEP


CAPTURE_PATTERN = Transform /("[0-9]+\.png"|Pattern.*)/ do |pattern|
  eval pattern
end

Given /click on (\#{CAPTURE_PATTERN})$/ do |img|
  wait(img, 3)
  click(img)
end

Given /opened by hover (\#{CAPTURE_PATTERN})$/ do |img|
  hover(img)
end

Given /^I should see (\#{CAPTURE_PATTERN})$/ do |img|
  expect(wait(img,4)).to_not raise_exception
end

Given /^I should not see (\#{CAPTURE_PATTERN})$/ do |img|
  expect(waitVanish(img,4)).to_not raise_exception
end

Given /^I fill in (\#{CAPTURE_PATTERN}) with (.+)$/ do |field, text|
  doubleClick(field)
  type(text)
end

Given /^(\#{CAPTURE_PATTERN}) is found by scrolling (\#{CAPTURE_PATTERN})$/ do |element, area|
  el = Pattern(element).similar(0.85)
  pattern = Pattern(area).targetOffset(-20 ,45)
  wheel(pattern, Button.WHEEL_UP, 100)
  i = 0
  while !exists(el, 0) && i <= 100
    wheel(pattern, Button.WHEEL_DOWN, 3)
    i += 1
  end
end

Given /^text fragment selected$/ do
  click("1400351083105.png")
  hover(Pattern("1400351083105.png").targetOffset(-23,18))
  mouseDown(Button.LEFT)
  hover(Pattern("1400351093763.png").targetOffset(-29,-23))
  mouseUp(Button.LEFT)
end
STEP

t.support 'hooks', <<-HOOKS
def on_start
  $SIKULI_SCREEN.click("1400320382234.png")
  $SIKULI_SCREEN.hover("1400932378494.png")
  $SIKULI_SCREEN.click("1400932390382.png")
end

After do
  $SIKULI_SCREEN.click("1400320382234.png")
  $SIKULI_SCREEN.click("1400320394450.png")
  if $SIKULI_SCREEN.exists("1400320449100.png") then
    $SIKULI_SCREEN.click("1400320432142.png")
  end
end

on_start
HOOKS
# ==========================  end of steps declaration =========================

end
# ************************ end of cucumber test ********************************
