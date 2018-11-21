# ActiTIME API QA Automation

## Getting Started
* Install Ruby v2.5 or higher
* From project directory in Ruby command line run:

    ```
    gem install bundler
    ```

    ```
    bundle install
    ```

* Config your environment in config.json: actiTIME server location, api version

* To run one cucumber feature:

    ```
    cucumber features/users_endpoint/users_list.feature
    ```
    
* Find report in results/test_report.html     