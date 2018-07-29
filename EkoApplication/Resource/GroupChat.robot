*** Settings ***
Library           Selenium2Library

*** Keywords ***
Can Add Member To Group
    [Documentation]    This keyword is used for checking if user have right to add memeber to group
    Page Should Contain    Add a member    10s

Can Not Add Member To Group
    [Documentation]    This keyword is used for checking if user dont have right to add memeber to group
    Page Should Not Contain    Add a member    10s

Create New Group
    [Arguments]    ${group_type}    ${group_name}
    [Documentation]    this keyword is used for creating a group with type and name. it requires 2 parameters:
    ...    -\ ${group_type} : type of group :1 - open and 2 - private.
    ...    -\ ${group_name} : name of group you want to name.
    ...    Below steps are executed:
    ...    -\ step1: Click next button
    ...    -\ step 2 : check page should contain 'Create new group chat'
    ...    -\ step 3: dont select any people and click Next button.
    ...    -\ step 4: create group type
    ...    -\ step 5 : click create button
    Wait Until Element Is Enabled    xpath = //span[text()='Next']/..    10s
    Page Should Contain    Create new group chat
    Click Element    xpath = //span[text()='Next']/..
    Wait Until Page Contains Element    xpath = //span[text()='Open Group']    10s
    Page Should Contain    Anyone will be able to add or remove users and edit the details of the chat
    Run Keyword If    ${group_type} == 2    Run Keywords    Click Element    xpath = //span[text()='Open Group']
    ...    AND    Wait Until Page Contains    10s
    ...    AND    Page Should Contain    Only you will be allowed to add or remove users and edit the details of the chat    # group type = 1 is open. group type =2 is private.
    Input Text    xpath = //input[@id='name']    ${group_name}
    Click Element    xpath = //span[text()='Create']/..

Then User Is Added To Group Successfully
    [Arguments]    ${username}    ${password}    ${group_name}
    Login To Eko Application    ${username}    ${password}
    Select The Recent Chat Or Group Chat
    Wait Until Page Contains Element    xpath = //span[@class='sc-iQNlJl jnKIMS']    10s
    ${group}=    Get Text    xpath = //span[@class='sc-iQNlJl jnKIMS']
    Should Be True    '${group_name}'=='${group}'
    Leave Chat or Group Chat
    Log Out Of Application

When Add Member To Group Chat
    [Arguments]    ${username}
    [Documentation]    This keyword is used for Adding an user to group. It requires 1 parameter:
    ...    -\ ${username} : user to be added to group
    Wait Until Page Contains    Add a member    10s
    Click Element    xpath = //div[text()='Add a member']
    Wait Until Page Contains    Add a member    10s
    Select Contact To Chat Or Adding To Group    ${username}

Select The Recent Chat Or Group Chat
    [Documentation]    This keyword is used for select the most recent group chat or direct chat.
    Wait Until Page Contains    Recents
    Wait Until Element Is Visible    xpath = //a[contains(@href, '/recents/group')][1]    30s
    Click Element    xpath = //a[contains(@href, '/recents/group')][1]
