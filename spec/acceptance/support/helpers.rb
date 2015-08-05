module HelperMethods

  def self.included(klass)
    klass.let(:login_user) { User.create!(email: 'user@example.com', password: 'password') }
  end

  def login(user = user)
    visit '/'
    login_as(login_user, :scope => :user, :run_callbacks => false)
  end

  def use_selenium
    Capybara.current_driver = Capybara.javascript_driver
  end

  def time_travel(string_date)
    Timecop.travel(DateTime.strptime(string_date, "%m/%d/%Y"))
  end

  def time_travel_back
    Timecop.return
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
