*** Settings ***
Library           Selenium2Library

*** Variables ***
${eko_url}        https://stagingekos.ekoapp.com

*** Keywords ***
Open Eko Application
    [Documentation]    This key word is used for login to Eko application. It requires 1 arguments:
    ...
    ...    -\ ${eko_url} : url Eko application.
    Open Browser    ${eko_url}    ff
    Maximize Browser Window

Create New Item
    [Arguments]    ${item}
    [Documentation]    This keyword is used for creating 1 of following items:
    ...
    ...    -\ DirectMessage.
    ...
    ...    -\ Group chat.
    ...
    ...    -\ Form.
    ...
    ...    -\ Task.
    ...
    ...
    ...    It requires 1 argument ${item}. The set of values for ${item} are:
    ...
    ...    -\ 1. if you want to create Direct Message.
    ...
    ...    -\ 2. if you want to create Group chat.
    ...
    ...    -\ 3. if you want to create Form.
    ...
    ...    -\ 4. if you want to create Task.
    Wait Until Element Is Enabled    xpath=//div[@class='sc-VigVT kSEtIG']/button
    Click Element    xpath=//div[@class='sc-VigVT kSEtIG']/button
    Click Element    xpath=//ul[@class='ant-menu ant-menu-vertical sc-doWzTn izBRft ant-menu-light ant-menu-root']/li[${item}]/a

Login To Eko Application
    [Arguments]    ${user_name}    ${pass_word}
    [Documentation]    This keyword is used for log in to the Application. It requires 2 parameters:
    ...    -\ ${user_name} : user name to login.
    ...    -\ ${pass_word}: password to login.
    Wait Until Element Is Enabled    id=username    30s
    Input Text    id=username    ${user_name}
    Wait Until Element Is Enabled    id=password    30s
    Input Password    id=password    ${pass_word}
    Submit Form
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Skip    5s
    Run Keyword If    ${status}    Click Link    link=Skip    # click skip pop up at the first when you login to application.

Wait Until Ajax Complete
    [Documentation]    This keyword is used for wait until the Ajax completed.
    : FOR    ${INDEX}    IN RANGE    1    5000
    \    ${isAjaxComplete}    Execute Javascript    return window.jQuery!=undefined && jQuery.active==0
    \    Log    ${INDEX}
    \    Run Keyword If    ${isAjaxComplete} == True    Exit For Loop

Leave Chat or Group Chat
    [Documentation]    This key word is used for leaving a chat or group chat. Below steps are executed:
    ...    -\ step1. Click the option button next to the video button.
    ...    -\ step2. Click the 'leave' option.
    ...    -\ step3. Wait until the pop up confirm leave appear.
    ...    -\ step4. Click Ok button.
    Click Element    xpath = //div[@class='sc-hZSUBg bHECWA']/span[2]/button
    Wait Until Page Contains    leave    30s
    Click Element    xpath = //span[@class='sc-jlyJG dYNDxg' and text()='leave']
    Wait Until Page Contains    Are you sure you want to leave the chat?    30s
    Page Should Contain    Are you sure you want to leave the chat?
    Wait Until Page Contains    leave    30s
    Page Should Contain    leave
    Wait Until Page Contains    OK
    Click Element    xpath = //div[@class='ant-confirm-btns']/button[2]

Close Pop Up
    [Documentation]    This keyword is used for closing pop up
    Wait Until Page Contains Element    xpath = //button[@aria-label='Close']    10s
    Click Element    xpath = //button[@aria-label='Close']

Log Out Of Application
    [Documentation]    This keyword is used for log out of Eko Application. Below steps are executed:
    ...    -\ step1: Click on the button setting on the top of the right side.
    ...    -\ step2: Click Log out button
    ...    -\ step3: Check if Log out successfully.
    Wait Until Element Is Enabled    xpath = //button[@class='ant-dropdown-trigger sc-fVHxE kXBRzd']    30s
    Click Element    xpath = //button[@class='ant-dropdown-trigger sc-fVHxE kXBRzd']
    Wait Until Page Contains Element    xpath = //li[text()='Log out']    30s
    Click Element    xpath = //li[text()='Log out']
    Page Should Contain    Sign in

Go To Tab
    [Arguments]    ${tab_name}
    [Documentation]    this key word is used for navigate to tab. It requires 1 keyword:
    ...    -\ ${tab_name} : the name of tab you want to click (we many tab: topic, members, ....)
    Wait Until Page Contains    ${tab_name}    10s
    Wait Until Element Is Visible    xpath = //span[text()='${tab_name}']/..    10s
    Click Element    xpath = //span[text()='${tab_name}']/..
