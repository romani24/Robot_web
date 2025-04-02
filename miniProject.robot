*** Settings ***
Library  SeleniumLibrary
Library  DateTime

*** Variables ***
${login}        standard_user
${password}     secret_sauce

*** Test Cases ***
Fill out the form
    Open Browser    https://testautomationpractice.blogspot.com    chrome
    Input text    //input[@id="name"]    Noesis Academy   
    Input text    //input[@id="email"]    noesis@academy.pt
    Input text    //input[@id="phone"]    911111111
