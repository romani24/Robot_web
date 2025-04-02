*** Settings ***
Library  SeleniumLibrary


*** Variables ***
${user}        Admin
${password}     admin123
@{week}  Domingo  Segunda  Terca  Quarta  Quinta  Sexta  Sabado 
&{login_person}        name=user123  email=user123@gmail.com  mother=mother123


*** Keywords ***
Open Orange site
    Open Browser    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login      chrome    options=add_argument("--start-maximized")    
    Wait Until Element Is Enabled        xpath://input[@name="username"]     20
    Input Text    xpath://input[@name="username"]         ${user} 
    Input Text    xpath://input[@placeholder="Password"]  ${password} 
    Click Button  xpath://button[text()=" Login "]
    Sleep        5
    Page Should Contain Image        //img[@src="/web/images/orange.png?v=1721393199309"]
    Capture Page Screenshot


*** Test Cases ***
Login with correct username and password
    [Tags]  login
    Open Orange site
    Click Link                   //a[@href="/web/index.php/admin/viewAdminModule"]
    Sleep        3
    Element Should Be Visible    //h6[text()="User Management"]
#
#

Analyze Vars
    [Tags]  var    
    Log To Console      ${user} 
    Log To Console      ${week[6]}   
    Log To Console      ${login_person.mother}
    