*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Resource    TC2_test_Create_Booking.robot
Resource    TC1_test_authorization.robot
Resource    TC2_test_Create_Booking.robot
*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
${DELETE_ENDPOINT}    /booking
*** Keywords ***
