 @echo off
    setlocal enabledelayedexpansion
    set OUTPUT_FILE=Output.csv

    >nul copy nul %OUTPUT_FILE%
    echo HOSTNAME,LONGNAME,IPADDRESS,STATE >%OUTPUT_FILE%
    for /f %%i in (list.txt) do (
  	ping %%i | find /i "TTL" >NUL 
  		if errorlevel 1 (
    		set SERVER_STATE=FAILED
  		) else (
    		set SERVER_STATE=OK
  		)
        set SERVER_ADDRESS_I=UNRESOLVED
        set SERVER_ADDRESS_L=UNRESOLVED
        for /f "tokens=1,2,3" %%x in ('ping -n 1 -a %%i') do (
        if %%x==Pinging set SERVER_ADDRESS_L=%%y
        if %%x==Pinging set SERVER_ADDRESS_I=%%z
	)
        echo %%i [!SERVER_ADDRESS_L::=!] !SERVER_ADDRESS_I::=! is !SERVER_STATE!
        echo %%i,!SERVER_ADDRESS_L::=!,!SERVER_ADDRESS_I::=!,!SERVER_STATE! >>%OUTPUT_FILE%
    )