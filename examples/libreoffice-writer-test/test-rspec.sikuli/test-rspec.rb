require "rspec"

def text_select
  click("1400351083105.png")
  hover(Pattern("1400351083105.png").targetOffset(-23,18))
  mouseDown(Button.LEFT)
  hover(Pattern("1400351093763.png").targetOffset(-29,-23))
  mouseUp(Button.LEFT)
end

def clear
  click("1400320382234.png")
  click("1400320394450.png")
  if exists("1400320449100.png") then
    click("1400320432142.png")
  end
end

def open_test_doc
  click("1400932362080.png")
  hover("1400932378494.png")
  click("1400932390382.png")
end

shared_examples_for "clickable" do |pattern, click_pattern|
  it "should responce to click" do
    click(pattern)
    expect(wait(click_pattern, 5)).to_not raise_exception
  end
end

shared_examples_for "dblclickable" do |pattern, click_pattern|
  it "should responce to double click" do
    doubleClick(pattern)
    expect(wait(click_pattern, 5)).to_not raise_exception
  end
end

shared_examples_for "unchecked checkable" do |pattern, result|
  it "should be checked" do
    click(pattern)
    expect(wait(result, 5)).to_not raise_exception
  end
  it "then unchecked" do
    click(pattern)
    expect(waitVanish(result, 5)).to_not raise_exception
  end
  it "and checked again" do
    click(pattern)
    expect(wait(result, 5)).to_not raise_exception
  end
end

shared_examples_for "checked checkable" do |pattern, result|
  it "should be unchecked" do
    click(pattern)
    expect(waitVanish(result, 5)).to_not raise_exception
  end
  it "and checked again" do
    click(pattern)
    expect(wait(result, 5)).to_not raise_exception
  end
end

shared_examples_for "clickable and hides something" do |pattern, click_pattern|
  it "should responce to click" do
    click(pattern)
    expect(waitVanish(click_pattern, 3)).to_not raise_exception
  end
end

shared_examples_for "text edit field" do |pattern, text, pattern_effect|
  it "should be editable" do
    doubleClick(pattern)
    paste(text)
    expect(find(pattern_effect)).to_not raise_exception
  end
end

shared_context "clickable container" do |pattern|
  before :each, :open => :yes do
    click(pattern)
  end
end

shared_context "window" do |pattern, confirm|
  before :each, :open => :yes do
    click(pattern)
  end
  after :each, :open => :yes do
    click(confirm)
  end
end

shared_context "hoverable menu" do |pattern|
  before :each, :open => :yes do
    hover(pattern)
  end
end

shared_context "text selection" do
  before :each, :text_select => :yes do
    text_select
  end
end

shared_context "self clean" do
  after :all do
    clear
  end
end

shared_context "open document" do
  before :all do
    open_test_doc
  end
end

describe "Format menu", :open => :yes, :text_select => :yes do
  include_context "open document"
  include_context "text selection"
  include_context "clickable container", "1400188760887.png"

  describe "case selector submenu" do
    include_context "self clean"
    include_context "hoverable menu", "1400350284909.png"
    describe "sentense case" do
      it_behaves_like "clickable", "1400350576310.png", Pattern("1400350587604.png").similar(0.90)
    end
    describe "lower case" do
      it_behaves_like "clickable and hides something", "1400350598717.png", Pattern("1400350587604.png").similar(0.90)
    end
    describe "upper case" do
      it_behaves_like "clickable", "1400350631803.png", Pattern("1400350647136.png").similar(0.90)
    end
    describe "camel case" do
      it_behaves_like "clickable", "1400350699565.png", Pattern("1400350710782.png").similar(0.90)
    end
    describe "switch case" do
      it_behaves_like "clickable", "1400350736464.png", Pattern("1400350754096.png").similar(0.90)
    end
  end
  
  describe "simbols window" do
    include_context "window", "1400762365333.png", "1400349553242.png"
    describe "font tab" do
      include_context "self clean"
      include_context "clickable container", Pattern("1400385571315.png").similar(0.94)
      describe "garniture edit" do
        it_behaves_like "text edit field", Pattern("1400347937983.png").targetOffset(-14,24), "Segoe script", "1400353143824.png"
      end
      describe "style edit" do
        it_behaves_like "text edit field", Pattern("1400352817689.png").targetOffset(-25,24), "asd", "1400352832445.png"
      end
      describe "size edit" do
        it_behaves_like "text edit field", Pattern("1400353420994.png").targetOffset(-12,20), "20", "1400353896891.png"
      end
      context "after all changes", :open => :no, :text_select => :no do
        it "should be different" do
          expect(wait("1400358194577.png", 2)).to_not raise_exception
        end
      end
    end
    describe "font effects tab" do
      include_context "self clean"
      include_context "clickable container", "1400404561637.png"
      context "until any line choosed", :text_select => :no do
        it "should not enable color selection" do
          click("1400404582783.png")
          expect(waitVanish("1400404617207.png", 1)).to_not raise_exception
        end
        it "should not enable words only checkbox" do
          click("1400405546024.png")
          expect(waitVanish(Pattern("1400405555220.png").similar(0.90), 1)).to_not raise_exception
        end
      end
      describe "overline" do
        include_context "clickable container", Pattern("1400404644331.png").targetOffset(-61,22)
        describe "dashed" do
          it_behaves_like "clickable", "1400404722331.png", Pattern("1400405097035.png").similar(0.91)
        end
      end
      describe "overline color" do
        include_context "clickable container", Pattern("1400404770312.png").targetOffset(-46,22)
        describe "select white" do
          it_behaves_like "clickable and hides something", "1400404981010.png", Pattern("1400405097035.png").similar(0.91)
        end
        describe "select red" do
          it_behaves_like "clickable", Pattern("1400405040158.png").exact(), Pattern("1400405097035.png").similar(0.91)
        end
      end
      describe "strike" do
        include_context "clickable container", Pattern("1400405253316.png").targetOffset(-30,26)
        describe "select double line" do
          it_behaves_like "clickable", "1400405309925.png", Pattern("1400405318523.png").similar(0.90)
        end
      end
      describe "outline" do
        it_behaves_like "unchecked checkable", Pattern("1400406597388.png").targetOffset(-33,0), Pattern("1400405448844.png").similar(0.90)
      end
      describe "words only" do
        it_behaves_like "unchecked checkable", Pattern("1400406659650.png").targetOffset(-49,-1), Pattern("1400405667185.png").similar(0.90)
      end
      context "after all changes", :text_select => :no, :open => :no do
        it "should be different" do
          expect(wait(Pattern("1400408991058.png").similar(0.95), 1)).to_not raise_exception
        end
      end
    end
  end

  describe "styles and formatting window" do
    include_context "self clean"
    include_context "window", "1400863994602.png", "1400864011387.png"
    describe "paragraph styles" do
      include_context "clickable container", Pattern("1400864031746.png").similar(0.87)
      describe "note" do
        it_behaves_like "dblclickable", "1400918532728.png", Pattern("1400918545130.png").similar(0.88)
      end
      describe "basic" do
        describe "header group" do
          include_context "clickable container", Pattern("1400918460644.png").similar(0.97).targetOffset(-30,1) 
          describe "header_4" do
            it_behaves_like "dblclickable", Pattern("1400918483824.png").similar(0.96), Pattern("1400918510738.png").similar(0.84)
          end          
        end
      end
      describe "tint" do
        it "should change cursor" do
          click("1400918584857.png")
          click("1400918923034.png")
          click("1400918629910.png")
          expect(find("1400918702955.png")).to_not raise_exception
        end
      end
    end
  end
end

# ****************** code for rspec running **************
RSpec::Core::Runner.instance_variable_set "@autorun_disabled", true
config_options = RSpec::Core::ConfigurationOptions.new [
                                                           "--format", "j", "--out", "rspec_result.json",
                                                           "--format", "h", "--out", "rspec_result.html",
                                                           "--format", "progress"
                                                       ]
config_options.parse_options
RSpec::Core::CommandLine.new(config_options, RSpec.configuration, RSpec.world).run(STDERR, STDOUT)
# *********************************************************** 