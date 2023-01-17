*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           DateTime
Library           ../resources/helpers.py
Library           Process
Suite Setup       Start Server
Suite Teardown    Stop Server

Variables           ../resources/test_data.py

*** Variables ***
${BASE_URL}     http://localhost:106
${SERVER_UP}        ${server_is_up}

*** Test Cases ***
Performance Test
    ${current_date} =    Get Current Date  result_format=%Y-%m-%d %H:%M:%S.%f
    ${current_epoch} =    Convert Date     ${current_date}     epoch
    ${new_date_time} =  Add Time To Date  ${current_date}  60 seconds
    ${new_epoch} =    Convert Date     ${new_date_time}     epoch
    @{time_list} =    Create List

    WHILE    ${current_epoch} < ${new_epoch}
        ${now} =  Get Current Date  result_format=%Y-%m-%d %H:%M:%S.%f
        ${current_epoch} =    Convert Date     ${now}     epoch
        ${response} =    GET    ${BASE_URL}/planets/42/
        ${delay} =     Set Variable    ${response.elapsed}
        ${time} =     Convert Time     ${delay}
        Append To List     ${time_list}     ${time}
    END

    ${mean_value} =     helpers.mean     ${time_list}
    ${st_dev} =     helpers.st_dev     ${time_list}
    Log To Console     Mean Value is = [${mean_value}] secs
    Log To Console     Stdev Value is = [${st_dev}] secs

*** Keywords ***
Start Server
    Run Process    rm ../result/api.log     shell=yes
    ${SERVER} =  Start Process  python3  app.py  106  Y
    Set Suite Variable   ${SERVER}
    Wait Until Keyword Succeeds  5s  1s  Server Is Up

Stop Server
    Terminate Process  ${SERVER}

Server Is Up
    ${response} =    GET    ${BASE_URL}/
    Should Be Equal     ${response.status_code}     ${200}
    Should Be Equal     ${response.json()}     ${SERVER_UP}
