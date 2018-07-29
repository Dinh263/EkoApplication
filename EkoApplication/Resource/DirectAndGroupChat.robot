*** Keywords ***
Select Contact To Chat Or Adding To Group
    [Arguments]    ${name}
    [Documentation]    This key word is used for select a contact / name to start chat. It requires ${name}. ${name} is the name of person you want to chat
    Wait Until Page Contains Element    xpath = //input[@placeholder='Enter name or email addresses...']    # wait until the text box search is visible
    Input Text    xpath = //input[@placeholder='Enter name or email addresses...']    ${name}
    Wait Until Page Contains    ${name}
    Wait Until Element Is Visible    xpath = //h4[@class='sc-esjQYD jJRNsG' and text()='${name}']    # type name in the text box search
    Click Element    xpath = //h4[@class='sc-esjQYD jJRNsG' and text()='${name}']

when Send Message
    [Arguments]    ${message}
    [Documentation]    This keyword is used for sending a message to chat or group chat.
    ...    -\ ${message} : is the message you send to chat or group chat.
    Wait Until Element Is Enabled    ${txt_typeMessage}    # wait until the text box typing message is enable.
    Input Text    ${txt_typeMessage}    ${message}
    Click Element    ${btn_Send}

Check If Deleted Message Is Updated Successfully
    [Arguments]    ${from_user}    ${delete_message}
    [Documentation]    This keyword is used for checking if a message is deleted successfully
    Select The Recent Chat Or Group Chat
    Check Message Is Deleted    ${delete_message}

Check Message Is Deleted
    [Arguments]    ${message_to_delete}
    [Documentation]    This keyword is used for checking if a message is deleted. It requires 1 parameter:
    ...    -\ ${message_to_delete} : the message is check if deleted.
    Page Should Not Contain    ${message_to_delete}
    Wait Until Page Contains    Message    10s
    Wait Until Page Contains    deleted on    10s
    Page Should Contain    Message
    Page Should Contain    deleted on
    Page Should Contain    Today,

Then Message is sent successfully
    [Arguments]    ${message}
    [Documentation]    This key word is used for checking if you send message successfully.
    ...    -\ ${message} : is the message you want to check if sent successfully.
    Wait Until Page Contains    Sent    30s
    Page Should Contain    Sent
    Wait Until Page Contains    ${message}    30s
    Page Should Contain    ${message}

When Delete Message
    [Arguments]    ${from_user}    ${message_to_delete}
    [Documentation]    This keyword is used for deleting a message. It requires 2 parameters:
    ...    -\ ${from_user} : the user who sent the message.
    ...    -\ ${message_to_delete} : the message will be deleted.
    ...    Below steps are executed:
    ...    -\ step 1: User already login to Application.
    ...    -\ step 2: Click the first item on Recent tab.
    ...    -\ step 3: Click on the message which want to delete.
    ...    -\ step 4: Click the option and select delete option.
    ...    -\ step 5: Check if message is deleted.
    ...    -\ step 6: Leave session chat.
    Wait Until Page Contains    Recents
    Click Element    xpath = //a[contains(@href, '/recents/group')][1]
    Wait Until Element Is Enabled    xpath = *//span[text()='${message_to_delete}']/..//button[@type='button']    30s
    Click Element    xpath = *//span[text()='${message_to_delete}']/..//button[@type='button']
    Wait Until Element Is Visible    xpath = *//ul[@class='sc-gojNiO cHWQWK']/ul/li[3]    10s    # wait the button edit is visible
    Click Element    xpath = *//ul[@class='sc-gojNiO cHWQWK']/ul/li[4]    # click the button delete
    Check Message Is Deleted    ${message_to_delete}
    Leave Chat or Group Chat

When Act The Message
    [Arguments]    ${message}    ${total_like}
    [Documentation]    This keyword is used for act a message.
    Wait Until Page Contains    Recents
    Click Element    xpath = //a[contains(@href, '/recents/group')][1]
    Wait Until Element Is Enabled    xpath = *//span[text()='${message}']/..//button[@type='button']    30s
    Click Element    xpath = *//span[text()='${message}']/..//button[@type='button']
    Wait Until Element Is Visible    xpath = *//ul[@class='sc-gojNiO cHWQWK']/ul/li[3]    10s    # wait the button act is visible
    Click Element    xpath = *//ul[@class='sc-gojNiO cHWQWK']/ul/li[1]    # click the button act
    Wait Until Page Contains Element    xpath = *//div[@class='ackByOther ackByMe sc-bXGyLb iGsuHJ']//span    30s
    ${count} =    Get Text    xpath = *//div[@class='ackByOther ackByMe sc-bXGyLb iGsuHJ']//span
    Should Be True    ${count} == ${total_like}

Then Act Detail Should Be Update Correctly
    [Arguments]    ${number_of_Act}
    [Documentation]    This keyword is used for to check total number Act must be correct. It requires 1 parameter:
    ...    -\ ${number_of_Act} : number of Act for validation
    ...    Below steps are executed:
    ...    -\ step 1 : Click Act detail and wait for Acknowledgement pop up appear.
    ...    -\ step 2 : Get the total number Act
    ...    -\ step 3 : compare the total at step 2 with inputted total number. they must be the same.
    Wait Until Page Contains    Acknowledgement    10s
    Wait Until Page Contains Element    xpath = //div[starts-with(text(),'Ack (')]    10s
    ${txt_like}=    Get Text    xpath = //div[starts-with(text(),'Ack (')]
    ${ind01} =    Get Index Of Substring    ${txt_like}    )
    ${num_like}=    Get Substring    ${txt_like}    5    ${ind01}
    Should Be True    ${num_like} == ${number_of_Act}

Check Detail Ack
    [Arguments]    ${message}
    [Documentation]    This keyword is used for check the Act Detail. It requires 1 paramater:
    ...    -\ ${message} : the message is checked with Act.
    ...    Below steps are executed:
    ...    -\ step 1 : Click the first item in tab Recent.
    ...    -\ step 2: Click the option button
    ...    -\ step 3: Clic Act detail button to check detail.
    Wait Until Page Contains    Recents
    Click Element    xpath = //a[contains(@href, '/recents/group')][1]
    Wait Until Element Is Enabled    xpath = *//span[text()='${message}']/..//button[@type='button']    30s
    Click Element    xpath = *//span[text()='${message}']/..//button[@type='button']
    Wait Until Element Is Visible    xpath = *//ul[@class='sc-gojNiO cHWQWK']/ul/li[1]    10s    # wait the button detail act \ is visible
    Click Element    xpath = *//ul[@class='sc-gojNiO cHWQWK']/ul/li[1]    # click the button detail act

When Edit Message
    [Arguments]    ${to_user}    ${old_message}    ${new_message}
    [Documentation]    This keyword is used for edit the message which is already sent.it requires 3 parameters:
    ...    -\ ${to_user} : the user you already sent the message.
    ...    -\ ${old_message} : the message already sent before.
    ...    -\ ${new_message} : the update message.
    ...    Below steps are executed:
    ...    -\ step 1: After login to Application. Click the first session in Recent tab.
    ...    -\ step 2: Select the message you want to edit.
    ...    -\ step 3: Wait until pop up 'Edit Message' appears.
    ...    -\ step 4: Check the current text must be the same with the message sent before.
    ...    -\ step 5: Clear the text box.
    ...    -\ step 6: Input new message.
    ...    -\ step 7: Click Ok button.
    Select The Recent Chat Or Group Chat
    Click Element    xpath = *//span[text()='${old_message}']/..//button[@type='button']
    Wait Until Element Is Visible    xpath = *//ul[@class='sc-gojNiO cHWQWK']/ul/li[3]    10s    # wait the button edit is visible
    Click Element    xpath = *//ul[@class='sc-gojNiO cHWQWK']/ul/li[3]    # click the button edit
    Wait Until Page Contains    Edit Message    10s    # wait window edit button appear
    Wait Until Element Is Visible    xpath = *// textarea[@id='data']    # wait the text box is visible.
    ${original_message} =    Get Text    xpath = *// textarea[@id='data']
    Should Be True    '${original_message}' == '${old_message}'
    Clear Element Text    xpath = *// textarea[@id='data']
    Input Text    xpath = *// textarea[@id='data']    ${new_message}
    Click Element    xpath = *//span[text()='OK']/..
    Wait Until Page Contains    ${new_message}    10s

Check If Receive Edit Message Successfully
    [Arguments]    ${from_user}    ${old_message}    ${new_message}
    [Documentation]    This keyword is used for checking If a user receive updated message correctly.It requires 3 parameters:
    ...    -\ ${from_user} : the person who sent the message.
    ...    -\ ${old_message} : the message already received before.
    ...    -\ ${new_message} : the updated message will receive.
    ...    Below steps are executed:
    ...    -\ step 1: When user already log in the Application. Click the first session in 'Recent' tab.
    ...    -\ step 2: Check the send must be the same with ${from_user}.
    ...    -\ step 3: Check page should not contain the old message.
    ...    -\ step 4 : Check page should contain the new message.
    Select The Recent Chat Or Group Chat
    Wait Until Page Contains Element    xpath = //span[@class='sc-gqPbQI hUflwo']    30s
    ${sender}=    Get Text    xpath = //span[@class='sc-gqPbQI hUflwo']    # check the sender
    Should Be True    '${sender}' == '${from_user}'
    Page Should Not Contain    ${old_message}
    Page Should Contain    ${new_message}

Check If Receive Message Correct
    [Arguments]    ${from_user}    ${receive_message}
    [Documentation]    This keyword is used for checking if a user receive a message successfully or not.
    ...    -\ ${from_user}: the user who sent the message.
    ...    -\ ${receive_message} : the message is sent.
    ...    Below steps are executed:
    ...    -\ step1. Check if page contains any user who sent the message.
    ...    -\ step2. Check if page contains any message sent by ${from_user}
    Select The Recent Chat Or Group Chat
    Wait Until Page Contains Element    xpath = //span[@class='sc-gqPbQI hUflwo']    30s
    ${sender}=    Get Text    xpath = //span[@class='sc-gqPbQI hUflwo']
    Should Be True    '${sender}' == '${from_user}'
    ${actual_receive_message} =    Get Text    xpath = //p[@class='sc-gHboQg gKEtKl']/span
    Should Be True    '${actual_receive_message}' == '${receive_message}'
