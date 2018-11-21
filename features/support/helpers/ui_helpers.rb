module UIActions
  def login(username, password)
    visit $config['actitime_url']
    if page.has_css?(LOGOUT_LINK, wait: 0)
      find(USER_PROFILE_LINK).click
      sleep 3
      unless find(USERNAME)[:value] == username
        logout
        login_with_credentials username, password
      end
      find('#closeUserProfilePopupButton').click
    else
      login_with_credentials username, password
    end
  end

  def login_with_credentials(username, password)
    fill_in USERNAME_FIELD, with: username
    fill_in PASSWORD_FIELD, with: password
    click_link LOGIN_BUTTON
    sleep 3
  end

  def logout
    click_link LOGOUT_LINK
    sleep 3
  end

  def get_all_system_users
    login 'admin', 'manager'
    find('a.content.users').click
    sleep 3
    all('span.userNameSpan').each do |item|
      $all_system_users << item.text
    end
  end

  def get_all_assigned_users(user)
    login user, user
    find('a.content.users').click
    sleep 3
    all('span.userNameSpan').each do |item|
      $assigned_users << item.text
    end
  end
end
World(UIActions)