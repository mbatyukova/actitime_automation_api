When /^I send GET API request for (.*?) list and get response as (.*?) user$/ do |endpoint, user|

  @response = RestClient.get($config['actitime_url'] + $config['api_version'] + '/' + endpoint,
                             :'x-api-key' => user, :content_type => 'application/json; charset=UTF-8', :accept => 'application/json; charset=UTF-8')
  @result = JSON.parse(@response.body)
end

When /^I send GET API request for (.*?) list with offset (.*?), limit (.*?) and get response as (.*?) user$/ do |endpoint, offset, limit, user|
  if offset == 'all'
    if $all_system_users.length == 0
      get_all_system_users
    end
    offset = $all_system_users.length
  end
  if limit == 'all'
    if $all_system_users.length == 0
      get_all_system_users
    end
    limit = $all_system_users.length
  end
  @response = RestClient.get($config['actitime_url'] + $config['api_version'] + '/' + endpoint,
                             :params => {:offset => offset,
                                         :limit => limit},
                             :'x-api-key' => user, :content_type => 'application/json; charset=UTF-8', :accept => 'application/json; charset=UTF-8')
  @result = JSON.parse(@response.body)
end

Then /^I should get (\d+) response code$/ do |response_code|
  expect(@response.code).to eq response_code.to_i
end

Then /^Request body json should match (.*?) schema$/ do |endpoint_item|
  expect(@response).to match_response_schema(endpoint_item)
end

Then /^(.*?) should get list of (assigned|all|current) Users$/ do |user, scope|
  case scope
  when 'all'
    if $all_system_users.length == 0
      get_all_system_users
    end
    expect(@result['items'].length).to eq $all_system_users.length
    @result['items'].each do |item|
      expect($all_system_users).to include item['lastName'] + ', ' + item['firstName'] or item['lastName'] + ', ' + item['firstName'] + ' ' + item['middleName'] + '.'
    end
  when 'assigned'
    get_all_assigned_users user
    expect(@result['items'].length).to eq $assigned_users.length
    @result['items'].each do |item|
      expect($assigned_users).to include item['lastName'] + ', ' + item['firstName'] or item['lastName'] + ', ' + item['firstName'] + ' ' + item['middleName'] + '.'
    end
    $assigned_users =[]
  when 'current'
    expect(@result['items'].length).to eq 1
    expect(@result['items'][0]['username']).to eq user
  else
    put "Failed"
  end
end

Then /^Users list length in response should be (.*?) less$/ do |offset|
  if $all_system_users.length == 0
    get_all_system_users
  end
  if offset == 'all'
    offset = $all_system_users.length
  end
  expect(@result['offset']).to eq offset.to_i
  if $all_system_users.length <= offset.to_i
    expect(@result['items'].length).to eq 0
  else
    expect(@result['items'].length).to eq $all_system_users.length-offset.to_i
  end
end

Then /^Users list length in response should be limited with (.*?)$/ do |limit|
  if $all_system_users.length == 0
    get_all_system_users
  end
  if limit == 'all'
    limit = $all_system_users.length
  end
  expect(@result['limit']).to eq limit.to_i
  if $all_system_users.length >= limit.to_i
    expect(@result['items'].length).to eq limit.to_i
  else
    expect(@result['items'].length).to eq $all_system_users.length
  end
end