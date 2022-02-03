*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
${AUTH_ENDPOINT}    /auth
${CREATE_ENDPOINT}    /booking

*** Keywords ***
Send POST request for authorization and getting token
    ${REQUEST_BODY}    load json from file    res/auth_data.json
    ${HEADERS}    create dictionary    Content-Type=application/json

    create session    auth_ses    ${BASE_URL}
    ${RESPONSE}    post on session    auth_ses    ${AUTH_ENDPOINT}    json=${REQUEST_BODY}    headers=${HEADERS}
    ${TOKEN}    get value from json    ${RESPONSE.json()}    $.token
    log to console    ${TOKEN[0]}
    ${STATUS_CODE}    convert to string    ${RESPONSE.status_code}
    log to console    ${STATUS_CODE}
    return from keyword    ${TOKEN[0]}

POST request for creation booking

    ${REQUEST_BODY}    load json from file    res/create_booking_data.json
    ${HEADERS}    load json from file    res/headers.json

    create session    create_ses    ${BASE_URL}
    ${RESPONSE}    post on session    create_ses    ${CREATE_ENDPOINT}    json=${REQUEST_BODY}    headers=${HEADERS}
    ${BOOKING_ID}   get value from json    ${RESPONSE.json()}    $.bookingid
    ${ID}    get from list    ${BOOKING_ID}    0
    log to console    ${ID}
    ${STATUS_CODE}    convert to string    ${RESPONSE.status_code}
    log to console    ${STATUS_CODE}
    should be equal    ${STATUS_CODE}    200
    return from keyword    ${ID}

GET request for checking creation booking
     [Arguments]    ${ID}
     ${CHECKING_CREATE_ENDPOINT}    set variable    ${CREATE_ENDPOINT}/${ID}
     create session    check_create_ses    ${BASE_URL}
     ${RESPONSE}    get on session    check_create_ses    ${CHECKING_CREATE_ENDPOINT}
     ${FIRST_NAME}   get value from json    ${RESPONSE.json()}    $.firstname
     ${F_NAME}    get from list    ${FIRST_NAME}    0
     should be equal    ${F_NAME}    Jim
     log to console   ${F_NAME}
     ${STATUS_CODE}    convert to string    ${RESPONSE.status_code}
     log to console    ${STATUS_CODE}
     should be equal    ${STATUS_CODE}    200

DELETE request for delete creation booking
    [Arguments]    ${ID}    ${TOKEN}
    ${COOKIE}    create dictionary    token=${TOKEN}
    ${HEADERS}    create dictionary    Content-Type=application/json
    ${CHECKING_DELETE_ENDPOINT}    set variable    ${CREATE_ENDPOINT}/${ID}
    create session    delete_ses    ${BASE_URL}
    ${RESPONSE}    delete on session     delete_ses    ${CHECKING_DELETE_ENDPOINT}    headers=${HEADERS}    cookies=${COOKIE}
    ${STATUS_CODE}    convert to string    ${RESPONSE.status_code}
    log to console    ${STATUS_CODE}
    should be equal    ${STATUS_CODE}    201

GET request for checking delete booking
     [Arguments]    ${ID}

     ${CHECKING_DELETE_ENDPOINT}    set variable    ${CREATE_ENDPOINT}/${ID}
     create session    check_delete_ses    ${BASE_URL}
     ${RESPONSE}    get on session    check_delete_ses    ${CHECKING_DELETE_ENDPOINT}    expected_status=any

     ${STATUS_CODE}    convert to string    ${RESPONSE.status_code}
     log to console    ${STATUS_CODE}
     should be equal    ${STATUS_CODE}    404