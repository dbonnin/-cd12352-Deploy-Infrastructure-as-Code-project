rem login.bat

set PROFILE=%1

rem add your aws access key
aws configure set aws_access_key_id <<access_key_id>>   --profile %PROFILE%
rem add your aws secret access key
aws configure set aws_secret_access_key <<secret_access_key>>    --profile %PROFILE%
rem add your aws session token
aws configure set aws_session_token "<<session_token>>"   --profile %PROFILE%
rem add your aws region
aws configure set region us-east-1 --profile %PROFILE%
rem add your aws access key
aws configure set output json --profile %PROFILE%
