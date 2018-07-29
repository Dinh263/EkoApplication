*** Settings ***
Library           Selenium2Library

*** Keywords ***
Then Chat Session Is Created Successfully
    [Arguments]    ${name}
    [Documentation]    This key word is used for checking if a chat session is created.
    ...    -\ ${name} : name of the person you create a chat session with.
    Wait Until Page Contains Element    xpath = //a[contains(@href,'/recents/group')]//h4[text()='${name}' and @class='sc-esjQYD jJRNsG']    30s
    Page Should Contain Element    xpath = //a[contains(@href,'/recents/group')]//h4[text()='${name}' and @class='sc-esjQYD jJRNsG']

Then Chat Session Is Removed From Recent Tab
    [Arguments]    ${name}
    [Documentation]    This keyword is used for checking it chat session is removed from tab Recent.
    ...    -\ ${name} : is the name of user you created session.
    Page Should Not Contain    xpath = //a[contains(@href,'/recents/group')]//h4[text()='${name}' and @class='sc-esjQYD jJRNsG']
