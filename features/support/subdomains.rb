Before('@with_subdomain') do
  @app_host = Capybara.app_host
  @default_host = Capybara.default_host
end

After("@with_subdomain") do
  Capybara.app_host = @app_host
  Capybara.default_host = @default_host
end
