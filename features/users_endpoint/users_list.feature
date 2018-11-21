Feature: GET /users

  Scenario: GET /users list response schema
    When I send GET API request for users list and get response as manage_ap user
    Then I should get 200 response code
    And Request body json should match users schema

  Scenario Outline: GET /users list when 'Hide not assigned Users' on
    Given Hide not assigned Users option is turned on
    When I send GET API request for users list and get response as <User> user
    Then I should get 200 response code
    And <User> should get list of <Available> Users

    Examples:
      | User               | Available |
      | manage_ap          | all       |
      | modify_userstt     | assigned  |
      | manage_sw          | assigned  |
      | manage_cb          | assigned  |
      | enter_tt           | current   |
      | lock_tt            | current   |
      | manage_pto         | all       |
      | manage_ss          | current   |
      | modify_userstt_dar | all       |
      | manage_sw_dar      | all       |
      | manage_cb_dar      | all       |
      | enter_tt_dar       | all       |
      | lock_tt_dar        | all       |
      | manage_pto_dar     | all       |
      | manage_ss_dar      | all       |

  #ATAPI-12
  Scenario Outline: GET /users list when 'Hide not assigned Users' off
    Given Hide not assigned Users option is turned off
    When I send GET API request for users list and get response as <User> user
    Then I should get 200 response code
    And <User> should get list of all Users

    Examples:
      | User           |
      | manage_ap      |
      | modify_userstt |
      | manage_sw      |
      | manage_cb      |
      | enter_tt       |
      | lock_tt        |
      | manage_pto     |
      | manage_ss      |

  Scenario Outline: GET /users list with offset
    When I send GET API request for users list with offset <Offset>, limit 1000 and get response as manage_ap user
    Then I should get 200 response code
    And Users list length in response should be <Offset> less

    Examples:
      | Offset |
      | 0      |
      | 3      |
      | all    |
      | 1000   |

  Scenario Outline: GET /users list with limit
    When I send GET API request for users list with offset 0, limit <Limit> and get response as manage_ap user
    Then I should get 200 response code
    And Users list length in response should be limited with <Limit>

    Examples:
      | Limit |
      | 0     |
      | 3     |
      | all   |
      | 1000  |