@echo off
setlocal

set ACTION=%1
set USAGE_EMPTY_S3="Usage: run.bat emptyS3 <S3BUCKET> <REGION> <PROFILE>"
set USAGE_UPLOAD_S3="Usage: run.bat uploadS3 <S3BUCKET> <REGION> <PROFILE> <FILE>"
set USAGE_DEPLOY="Usage: run.bat deploy <STACK_NAME> <TEMPLATE_NAME> <PARMS_NAME> <REGION>"
set USAGE_PREVIEW="Usage: run.bat preview <STACK_NAME> <TEMPLATE_NAME> <PARMS_NAME> <REGION>"
set USAGE_DELETE="Usage: run.bat delete <STACK_NAME> <REGION>"

if "%ACTION%"=="emptyS3" (

    set S3BUCKET=%2
    set REGION=%3
    set PROFILE=%4 

    if not defined S3BUCKET (
        echo %USAGE_EMPTY_S3%
        exit /b
    )
    if not defined REGION (
        echo %USAGE_EMPTY_S3%
        exit /b
    )
    if not defined PROFILE (
        echo %USAGE_EMPTY_S3%
        exit /b
    )

    aws s3 rm s3://%S3BUCKET% --recursive --region=%REGION% --profile %PROFILE%

) else if "%ACTION%"=="uploadS3" (

    set S3BUCKET=%2
    set REGION=%3
    set PROFILE=%4
    set FILE=%5

    if not defined S3BUCKET (
        echo %USAGE_UPLOAD_S3%
        exit /b
    )
    if not defined REGION (
        echo %USAGE_UPLOAD_S3%
        exit /b
    )
    if not defined PROFILE (
        echo %USAGE_UPLOAD_S3%
        exit /b
    )
    if not defined FILE (
        echo %USAGE_UPLOAD_S3%
        exit /b
    )

    aws s3 cp %FILE% s3://%S3BUCKET%/ --region=%REGION% --profile %PROFILE%

) else if "%ACTION%"=="deploy" (

    set STACK_NAME=%2
    set TEMPLATE_NAME=%3
    set PARMS_NAME=%4
    set REGION=%5

    if not defined STACK_NAME (
        echo %USAGE_DEPLOY%
        exit /b
    )
    if not defined TEMPLATE_NAME (
        echo %USAGE_DEPLOY%
        exit /b
    )
    if not defined PARMS_NAME (
        echo %USAGE_DEPLOY%
        exit /b
    )
    if not defined REGION (
        echo %USAGE_DEPLOY%
        exit /b
    )

    aws cloudformation deploy --stack-name %STACK_NAME% ^
     --template-file %TEMPLATE_NAME% --parameter-overrides file://%PARMS_NAME% --region=%REGION% --profile %PROFILE% --capabilities CAPABILITY_NAMED_IAM

) else if "%ACTION%"=="delete" (

    set USAGE_DELETE="Usage: run.bat delete <STACK_NAME> <REGION>"

    set STACK_NAME=%2
    set REGION=%3
    set PROFILE=%4

    if not defined STACK_NAME (
        echo %USAGE_DELETE%
        exit /b
    ) else if not defined REGION (
        echo %USAGE_DELETE%
        exit /b
    )

    aws cloudformation delete-stack --stack-name %STACK_NAME% --region=%REGION% --profile %PROFILE%

)if "%ACTION%"=="preview" (

    set STACK_NAME=%2
    set TEMPLATE_NAME=%3
    set PARMS_NAME=%4
    set REGION=%5

    if not defined STACK_NAME (
        echo %USAGE_PREVIEW%
        exit /b
    ) else if not defined TEMPLATE_NAME (
        echo %USAGE_PREVIEW%
        exit /b
    ) else if not defined PARMS_NAME (
        echo %USAGE_PREVIEW%
        exit /b
    ) else if not defined REGION (
        echo %USAGE_PREVIEW%
        exit /b
    )

     aws cloudformation deploy --stack-name %STACK_NAME% ^
     --template-file %TEMPLATE_NAME% --parameter-overrides file://%PARMS_NAME% --region=%REGION% --profile %PROFILE% --capabilities CAPABILITY_NAMED_IAM --no-execute-changeset

)