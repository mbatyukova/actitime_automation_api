Given /^Hide not assigned Users option is turned (on|off)$/ do |state|
  if $hide_users_option != state
    login 'admin', 'manager'
    visit $config['actitime_url'] + SYSTEM_SETTINGS_PAGE_URL
    sleep 3
    within(find('span.label ', text: HIDE_USERS_OPTION).first(:xpath, './/..')) do
      if state == 'on'
        find(SYSTEM_OPTIONS_CHECKBOX).check
      else
        find(SYSTEM_OPTIONS_CHECKBOX).uncheck
      end
    end
    click_button SAVE_SETTINGS
    sleep 3
    $hide_users_option = state
  end
end