rem login.bat

set PROFILE=%1

rem add your aws access key
aws configure set aws_access_key_id    --profile %PROFILE%
rem add your aws secret access key
aws configure set aws_secret_access_key Y3QvvIWOL0yQLjNE5A76RsN0QMekwvXwhafJylKe   --profile %PROFILE%
rem add your aws session token
aws configure set aws_session_token "FwoGZXIvYXdzEHMaDEARqx4tthcHZ1yQUyK7AU9wfbSdIV7FsAsreiCmktxyzed+p+sLpc1ChJDgTzvdlQ9VBd6pLEJu0pW6BC+8SA/JP84wssA4mnVB2qzeYjCamSf5q7Tbq5B84jmYSzsYmfMfGKp+kvyLidS1cNETtbtBEI7rr3KmZZWYAipjAFUb4E8BXeA+/hAJgyMoaSoEPRV0ZdwnJ9ZcACKrFKrFeRMItgcIsgz1NgI4etj2itz28B5H8sCxn/m+UauvnDGjfPKHa8GD7bR3jPko2YCwrQYyLXZm3WaPP3sEkej16PjmNAQirq1/qah+GOzgZUWIo53sRSt9m6cazWDzkZYXJQ=="   --profile %PROFILE%
rem add your aws region
aws configure set region us-east-1 --profile %PROFILE%
rem add your aws access key
aws configure set output json --profile %PROFILE%
