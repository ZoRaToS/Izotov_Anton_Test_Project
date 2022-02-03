*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Resource    res/TC_Keywords.robot

*** Test Cases ***

E2E Testing for Restful-Broker
    ${TOKEN}    Send POST request for authorization and getting token
    ${RESULT_ID}    POST request for creation booking
    GET request for checking creation booking    ${RESULT_ID}
    DELETE request for delete creation booking    ${RESULT_ID}    ${TOKEN}
    GET request for checking delete booking    ${RESULT_ID}
