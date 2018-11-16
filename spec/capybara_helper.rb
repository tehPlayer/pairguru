require 'billy/capybara/rspec'

# Setting up headless version requires changes in system:
# - for webkit_billy we need Qt
# - for headless chrome it requires to add a certificate to store manually
# more info on https://github.com/oesmith/puffing-billy
# just because its recruitment task, I kept using normal Chrome
Capybara.javascript_driver = :selenium_chrome_billy
Capybara.server = :webrick
