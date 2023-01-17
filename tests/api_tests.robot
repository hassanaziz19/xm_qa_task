*** Settings ***
Library             RequestsLibrary
Library             Collections
Library             Process
Suite Setup         Start Server
Suite Teardown      Stop Server

Variables           ../resources/test_data.py

*** Variables ***
${BASE_URL}         http://localhost:105
${EXP_PEOPLE}       ${expected_result_people}
${EXP_PLANETS}      ${expected_result_planets}
${EXP_STARSHIPS}    ${expected_result_starships}
${EXP_404}          ${expected_404_response}
${SERVER_UP}        ${server_is_up}


*** Test Cases ***
GET /people/
    ${response} =    GET    ${BASE_URL}/people/42/
    Should Be Equal     ${response.status_code}     ${200}
    Should Be Equal     ${response.json()}     ${EXP_PEOPLE}

GET /people/ 404
    ${response} =    GET    ${BASE_URL}/people/422/    expected_status=404
    Dictionary Should Contain Item     ${response.json()}     errorCode     ${404}
    Should Be Equal     ${response.status_code}     ${404}
    Should Be Equal     ${response.json()}     ${EXP_404}

GET /planets/
    ${response} =    GET    ${BASE_URL}/planets/11/
    Should Be Equal     ${response.status_code}     ${200}
    Should Be Equal     ${response.json()}     ${EXP_PLANETS}

GET /planets/ 404
    ${response} =    GET    ${BASE_URL}/people/111/    expected_status=404
    Dictionary Should Contain Item     ${response.json()}     errorCode     ${404}
    Should Be Equal     ${response.status_code}     ${404}
    Should Be Equal     ${response.json()}     ${EXP_404}

GET /starships/
    ${response} =    GET    ${BASE_URL}/starships/8/
    Should Be Equal     ${response.status_code}     ${200}
    Should Be Equal     ${response.json()}     ${EXP_STARSHIPS}

GET /starships/ 404
    ${response} =    GET    ${BASE_URL}/starships/999/    expected_status=404
    Dictionary Should Contain Item     ${response.json()}     errorCode     ${404}
    Should Be Equal     ${response.status_code}     ${404}
    Should Be Equal     ${response.json()}     ${EXP_404}

*** Keywords ***
Start Server
    Run Process    rm ../result/api.log     shell=yes
    ${SERVER} =  Start Process  python3  app.py  105
    Set Suite Variable   ${SERVER}
    Wait Until Keyword Succeeds  5s  1s  Server Is Up

Stop Server
    Terminate Process  ${SERVER}

Server Is Up
    ${response} =    GET    ${BASE_URL}/
    Should Be Equal     ${response.status_code}     ${200}
    Should Be Equal     ${response.json()}     ${SERVER_UP}
