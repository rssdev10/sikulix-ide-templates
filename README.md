sikulix-ide-templates
=====================

This project is devoted to using of Ruby based DSLs for GUI testing with [SikuliX](https://github.com/RaiMan/SikuliX-2014).

Previously it was possible to use DSL like Rspec or Cucumber with Sikuli but only in batch mode. The main purpose of this project is a development of use cases for testing frameworks based on Ruby specifically for SikuliX IDE with new Ruby API. DSL support for successful use cases is planed to realize with native IDE support.

You can use our templates for:
* [RSpec](templates/sikulix_rspec.rb) or
* [Cucumber](templates/sikulix_cucumber.rb)

Or look at simple examples of SikuliX project for testing LibreOffice Writer with:
*[RSpec](examples/libreoffice-writer-test/test-rspec.sikuli)
![RSpec](doc/pics/rspec_example.png)
*[Cucumber](examples/libreoffice-writer-test/test-cucumber.sikuli)
![Cucumber](doc/pics/cucumber_example.png)

SikuliX with an integrated rspec and cucumber gems support is available in the [Ruby development repository](https://github.com/rssdev10/SikuliX-2014/tree/ruby) or [use assembled jars](https://drive.google.com/folderview?id=0Bwx0cbtdU5K6STg2T0l5UWlIRXc&usp=drive_web).

We are welcome to develop any other DSL use cases or it SikuliX IDE native support development.
