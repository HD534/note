*** Settings ***
Library    com.demo.selenium.GeneralActivity
Library    com.demo.selenium.util.RobotListener
Library    com.demo.selenium.keywords.login.Login


*** Keywords ***
Init Test Case
     Capture Test Case Name    ${SUITE NAME}    ${TEST NAME}
     Capture Out PutFolder     ${OUTPUT DIR}  
     Reset Step Number
     Verify Parent Case Status   ${ParentCaseName}

Close Test Case
	Capture Test Case Status        ${TEST STATUS}
	Capture Screen Shot For Error
#    Close Application

