AfterConfiguration do
  $hide_users_option = 'not set'
  $all_system_users = []
  $assigned_users = []
end

After do |scenario|
  if scenario.failed?
    file_name = format('results/screenshots/failure.png')
    save_screenshot(file_name)
    embed(file_name, 'image/png')
  end
end
