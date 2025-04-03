*** Settings ***
Library  SeleniumLibrary
Library  DateTime

Documentation  Pontos a considerar na resolução do desafio
...    Apagar as linhas nos testes que tem escrito "No operation"
...    Documentação da biblioteca do Selenium: https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Input%20Text"
...    Keywords que podems ser usadas: Input Text / Select Checkbox / Select From List By Index / Select From List By Label
...                                    Select From List By Value / Click Button / Click Element / Click Link / Choose File
...                                    Element Should Be Visible / Element Should Contain / Element Text Should Be

*** Variables ***
${login}        standard_user
${password}     secret_sauce

*** Keywords ***
Validate Difference Between Dates
   [Arguments]         ${start_date}    ${end_date}

    ${start}   Convert Date    ${start_date}    result_format=%Y-%m-%d
    ${end}     Convert Date    ${end_date}      result_format=%Y-%m-%d
    ${diff}    Subtract Date From Date    ${end}    ${start}

    ${num}   Evaluate    ${diff}/ 86400
    ${num}   Convert To Integer   ${num}
    ${num}   Convert To String    ${num}
    RETURN   ${num}

Open App
    Open Browser    https://www.saucedemo.com/     chrome    options=add_argument("--start-maximized")    
    Input Text    xpath://input[@data-test="username"]   ${login} 
    Input Text    xpath://input[@data-test="password"]   ${password} 
    Click Button  xpath://input[@id="login-button"]
    Sleep        5
    Page Should Contain Element        //div[text()="Swag Labs"]
    Capture Page Screenshot

*** Test Cases ***
Fill Form
    [Tags]  form
     Open Browser   https://testautomationpractice.blogspot.com/   chrome
     Input Text     xpath=//input[@id="name"]          Noesis Academy                #Name
     Input Text     xpath=//input[@id="email"]         Noesis@Academy.pt             #Email
     Input Text     xpath=//input[@id="phone"]         911111111                     #Phone
     Input Text     xpath=//textarea[@id="textarea"]   AVENIDA MARCOS PORTUGAL       #Address

     Select Radio Button   gender  female    #Gender
     
     Select Checkbox   //input[@id="sunday"]     #Days
     Select Checkbox   //input[@id="saturday"]   #Days

     Select From List By Value   //select[@id="country"]    canada          #Country
     Select From List By Index   //select[@id="colors"]     2   3           #Colors
     Select From List By Label   //select[@id="animals"]    Deer  Elephant  #Sorted List

     Input Text     //input[@id="datepicker"]         02/04/2025    #Date Picker 1
     
     Click Element                //input[@name="SelectedDate"]                 #Date Picker 2
     Select From List By Value   //select[@data-handler="selectMonth"]   5      #Date Picker 2
     Select From List By Value   //select[@data-handler="selectYear"]    2015   #Date Picker 2
     Click Element               //a[@data-date="30"]                           #Date Picker 2

     Input Text     //input[@id="start-date"]      03/12/2020    #Date Picker 3 (Data Inicio)
     Input Text     //input[@id="end-date"]        03/22/2020    #Date Picker 3 (Data Fim)

     Click Button   //button[@class="submit-btn"]                #Date Picker 3  (Clicar no Submit)   
     ${result}   Get Text   //div[@id="result"]                  #Date Picker 3   (Pegar o texto gerado)

     ${num_dias}    Validate Difference Between Dates   2020/03/12  2020/03/22    #Validar se a diferenca da data no texto é igual das diferenças das datas
     Should Contain    ${result}    ${num_dias}                               #Validar se a diferenca da data no texto é igual das diferenças das datas

     # Pegar da data corrente do sistema
     ${TODAY}      Get Current Date            result_format=%m/%d/%Y
     
      Choose File   //input[@id="singleFileInput"]    ${EXECDIR}\\Solidario.png    # Upload de ficheiro


Add a product to the basket
     [Tags]  add_basket
     Open App
     Click Button    //button[@id="add-to-cart-sauce-labs-backpack"]   #Adiciona o item ao carrinho
     Click Link      //a[@data-test="shopping-cart-link"]              #Entra no carrinho   
     Page Should Contain Element  //div[text()="Sauce Labs Backpack"]  #Valida se o item esta no carrinho


Delete a product from the basket
     [Tags]  delete_basket
     Open App
     Click Button    //button[@id="add-to-cart-sauce-labs-backpack"]     #Adiciona o item ao carrinho
     Click Button    //button[@id="add-to-cart-sauce-labs-bike-light"]   #Adiciona o item ao carrinho
     Click Link      //a[@data-test="shopping-cart-link"]                #Entra no carrinho 

     ${existe_item}  Run Keyword And Return Status    Page Should Contain Element   xpath=//div[@data-test="inventory-item"]    #Valida se o item esta no carrinho

     WHILE  ${existe_item}    # Loop = Enquando existir item no carrinho ele ira apagar o primeiro item
        Click Element    //div[@data-test="inventory-item"][1]//button   #Exclui o item no carrinho
        ${existe_item}  Run Keyword And Return Status    Page Should Contain Element   xpath=//div[@data-test="inventory-item"]   #Valida se o item esta no carrinho
     END 


Validate if the basket is empty
     [Tags]  existe_item
     Open App   
     Click Link      //a[@data-test="shopping-cart-link"]   #Entra no carrinho   
     Page Should Not Contain Element    //div[@data-test="inventory-item"]  #Exclui o item no carrinho