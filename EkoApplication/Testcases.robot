*** Settings ***
Suite Teardown
Library           Selenium2Library
Library           String
Library           Collections
Library           OperatingSystem
Library           Libs/CustomizeLibs.py
Resource          Resource/Common.robot
Resource          Resource/GroupChat.robot
Resource          Resource/DirectAndGroupChat.robot
Resource          Resource/DirectMessage.robot

*** Variables ***
${txt_typeMessage}    id=message
${btn_Send}       xpath =//button[@class='ant-btn sc-dxgOiQ jrlHDk sc-kpOJdX juwvbp ant-btn-primary']

*** Test Cases ***
TC01_Direct_Message_Send_Message
    [Tags]    tc01
    [Setup]    Open Eko Application
    [Template]    Send Message In Direct Message
    dinh@ekoapp.com    password    nguyen    123456    the dog jump over the fox
    [Teardown]    Close All Browsers

TC02_Direct_Message_Edit_Message_Sent
    [Tags]    tc02
    [Setup]    Open Eko Application
    [Template]    Edit Message In Direct Message
    dinh@ekoapp.com    password    nguyen    123456    the originail message    update message
    [Teardown]    Close All Browsers

TC03_Direct_Message_Delete_Message
    [Tags]    tc03
    [Setup]    Open Eko Application
    [Template]    Delete Message In Direct Message
    dinh@ekoapp.com    password    nguyen    123456    test delete message
    [Teardown]    Close All Browsers

TC04_Direct_Message_Act
    [Tags]    tc04
    [Setup]    Open Eko Application
    [Template]    Act Message In Direct Message
    dinh@ekoapp.com    password    nguyen    123456    tutorial
    [Teardown]    Close All Browsers

TC05_GroupChat_Add_Member_To_Open_Group
    [Tags]    tc05
    [Setup]    Open Eko Application
    [Template]    Add Member To Group Chat
    dinh@ekoapp.com    password    nguyen    123456    trinh    123456    1
    ...    GroupABC
    [Teardown]    Close All Browsers

*** Keywords ***
Send Message In Direct Message
    [Arguments]    ${user_name_A}    ${pass_word_A}    ${user_name_B}    ${pass_word_B}    ${message}
    [Documentation]    This keyword is used for checking if function Send Message in Direct Message works correctly.It requires 5 parameters:
    ...    -\ ${user_name_A} : sender.
    ...    -\ ${pass_word_A} : password of sender.
    ...    -\ ${user_name_B} : receiver.
    ...    -\ ${pass_word_B} : password of receiver.
    ...    -\ ${message} : the message is sent.
    ...    Below steps are executed:
    ...    -\ step 1: User A login to application and select contact (user B) to chat.
    ...    -\ step 2: User A send message (${message}) to user B. \ -\ step 3: Check message is sent successfully.
    ...    -\ step 4: User A leave session and log out of application.
    ...    -\ step 5: User B login to application.
    ...    -\ step 6: Select the first item in Recent tab.
    ...    -\ step 7: Check if receive message correctly.
    ...    -\ step 8: leave session and log out of application.
    Login To Eko Application    ${user_name_A}    ${pass_word_A}
    Create New Item    1
    Wait Until Page Contains    Create new chat    30s
    Select Contact To Chat Or Adding To Group    ${user_name_B}
    Then Chat Session Is Created Successfully    ${user_name_B}
    when Send Message    ${message}
    Then Message is sent successfully    ${message}
    Leave Chat or Group Chat
    Then Chat Session Is Removed From Recent Tab    ${user_name_B}
    Log Out Of Application
    Login To Eko Application    ${user_name_B}    ${pass_word_B}
    Check If Receive Message Correct    ${user_name_A}    ${message}
    Leave Chat or Group Chat
    Log Out Of Application

Edit Message In Direct Message
    [Arguments]    ${user_A}    ${password_A}    ${user_B}    ${password_B}    ${message}    ${update_message}
    [Documentation]    This keyword is used for checking if edit message function work correctly. It requires 6 paramaters.
    ...    -\ ${user_A} : the sender
    ...    -\ ${password_A} : the password of the sender.
    ...    -\ ${user_B} : the receiver
    ...    -\ ${password_B} : the password of the receiver.
    ...    -\ ${message} : the message sent at first
    ...    -\ ${update_message} : the udpated message for sending at the second time.
    ...    Below steps are executed:
    ...    -\ \ step 1: User A login to application.
    ...    -\ \ step 2: User A select user B to send message (${message}).
    ...    -\ \ step 3: Check if message sent successfully.
    ...    -\ \ step 4: User A log out of application.
    ...    -\ \ step 5: User B log in to the application and check if receive the message (${message}) correctly. User B log out of application
    ...    -\ \ step 6: User A login to application and select the ${message} and edit to ${update_message}.
    ...    -\ \ step 7: User A leave session and log out of application
    ...    -\ \ step 8: User B login application and check if he receives new updated message correctly.
    Login To Eko Application    ${user_A}    ${password_A}
    Create New Item    1
    Wait Until Page Contains    Create new chat    30s
    Select Contact To Chat Or Adding To Group    ${user_B}
    Then Chat Session Is Created Successfully    ${user_B}
    when Send Message    ${message}
    Then Message is sent successfully    ${message}
    Log Out Of Application
    Login To Eko Application    ${user_B}    ${password_B}
    Check If Receive Message Correct    ${user_A}    ${message}
    Log Out Of Application
    Login To Eko Application    ${user_A}    ${password_A}
    When Edit Message    ${user_B}    ${message}    ${update_message}
    Leave Chat or Group Chat
    Log Out Of Application
    Login To Eko Application    ${user_B}    ${password_B}
    Check If Receive Edit Message Successfully    ${user_A}    ${message}    ${update_message}
    Leave Chat or Group Chat
    Log Out Of Application

Delete Message In Direct Message
    [Arguments]    ${user_A}    ${password_A}    ${user_B}    ${password_B}    ${message}
    [Documentation]    This keyword is used for checking 'Delete' Function in Direct Message works correctly.
    ...    It requires 5 parameters:
    ...    -\ ${user_A}: the user who sent the message at first.
    ...    -\ ${password_A} : password of the user A.
    ...    -\ ${user_B}: the user who receive the message.
    ...    -\ ${password_B} : password of the user B.
    ...    Below steps are executed:
    ...    -\ step 1: User A login to Application
    ...    -\ step 2: Select user B to start chating and send a message. Log out of application.
    ...    -\ step 3: User B login and check if receive a message correctly. Log out of application.
    ...    -\ step 4: User A login to Application and delete the message which is already sent at step 2. Leave session and Log out application.
    ...    -\ step 5: Check if message is deleted from user A successfully.
    ...    -\ step 6: User B login to application and check if the message is also deleted.
    ...    -\ step 7: leave session and log out application
    Login To Eko Application    ${user_A}    ${password_A}
    Create New Item    1
    Wait Until Page Contains    Create new chat    30s
    Select Contact To Chat Or Adding To Group    ${user_B}
    Then Chat Session Is Created Successfully    ${user_B}
    when Send Message    ${message}
    Then Message is sent successfully    ${message}
    Log Out Of Application
    Login To Eko Application    ${user_B}    ${password_B}
    Check If Receive Message Correct    ${user_A}    ${message}
    Log Out Of Application
    Login To Eko Application    ${user_A}    ${password_A}
    When Delete Message    ${user_B}    ${message}
    Log Out Of Application
    Login To Eko Application    ${user_B}    ${password_B}
    Check If Deleted Message Is Updated Successfully    ${user_A}    ${message}
    Leave Chat or Group Chat
    Log Out Of Application

Add Member To Group Chat
    [Arguments]    ${user_A}    ${password_A}    ${user_B}    ${password_B}    ${user_C}    ${password_C}
    ...    ${group_type}    ${group_name}
    [Documentation]    This keyword is used for checking if user (owner group) can add other poeple to group.
    ...    -\ ${user_A} : is the ownser of group
    ...    -\ ${password_A} : password of user A
    ...    -\ ${user_B} : user B
    ...    -\ ${password_B} : password of user B
    ...    Below steps are executed:
    ...    -\ step 1 : user A (owner) login to application.
    ...    -\ step 2 : create new group which is open type. and input the name and dont add any poeple.
    ...    -\ step 3: Go to tab member.
    ...    -\ step 4: check if can add other poeple.
    ...    -\ step 5: add user B to group
    ...    -\ step 6 : leave group and log out off application.
    ...    -\ step 7 : user B login to application
    ...    -\ step 8: click on the recent group and check the group name is correct.
    ...    -\ step 9 : leave group and log out off application.
    Login To Eko Application    ${user_A}    ${password_A}
    Create New Item    2
    Create New Group    1    ${group_name}    # create open group, so that other people can add other to group
    Go To Tab    Members
    When Add Member To Group Chat    ${user_B}
    Wait Until Page Contains    ${user_B}
    Page Should Contain    ${user_B}
    Leave Chat or Group Chat
    Log Out Of Application    # user A log out of application.
    Then User Is Added To Group Successfully    ${user_B}    ${password_B}    ${group_name}

Act Message In Direct Message
    [Arguments]    ${user_name_A}    ${pass_word_A}    ${user_name_B}    ${pass_word_B}    ${message}
    [Documentation]    This keyword is used for checking act function if it works correct or not.
    Login To Eko Application    ${user_name_A}    ${pass_word_A}
    Create New Item    1
    Wait Until Page Contains    Create new chat    30s
    Select Contact To Chat Or Adding To Group    ${user_name_B}
    Then Chat Session Is Created Successfully    ${user_name_B}
    when Send Message    ${message}
    Then Message is sent successfully    ${message}
    When Act The Message    ${message}    1
    Check Detail Ack    ${message}
    Then Act Detail Should Be Update Correctly    1
    Close Pop Up
    Sleep    2s
    Leave Chat or Group Chat
    Log Out Of Application
    Login To Eko Application    ${user_name_B}    ${pass_word_B}
    When Act The Message    ${message}    2
    Check Detail Ack    ${message}
    Then Act Detail Should Be Update Correctly    2
    Close Pop Up
    Sleep    2s
    Leave Chat or Group Chat
    Log Out Of Application
