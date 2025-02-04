@echo off
setlocal enabledelayedexpansion

:: Get IP from user
set /p ip="Enter IP address: "

:: Use curl to get location data
curl -s "http://ip-api.com/json/%ip%" > temp.json

:: Extract and display relevant info using jq
for /f "delims=" %%A in ('jq -r ".city" temp.json') do set city=%%A
for /f "delims=" %%A in ('jq -r ".regionName" temp.json') do set region=%%A
for /f "delims=" %%A in ('jq -r ".country" temp.json') do set country=%%A
for /f "delims=" %%A in ('jq -r ".timezone" temp.json') do set timezone=%%A
for /f "delims=" %%A in ('jq -r ".isp" temp.json') do set isp=%%A
for /f "delims=" %%A in ('jq -r ".lat" temp.json') do set latitude=%%A
for /f "delims=" %%A in ('jq -r ".lon" temp.json') do set longitude=%%A
for /f "delims=" %%A in ('jq -r ".zip" temp.json') do set zipcode=%%A
for /f "delims=" %%A in ('jq -r ".org" temp.json') do set organization=%%A
for /f "delims=" %%A in ('jq -r ".as" temp.json') do set as_number=%%A
for /f "delims=" %%A in ('jq -r ".countryCode" temp.json') do set country_code=%%A
for /f "delims=" %%A in ('jq -r ".regionCode" temp.json') do set region_code=%%A

:: Display gathered information
echo.
echo IP Information:
echo ----------------------------
echo City: %city%
echo Region: %region%
echo Country: %country%
echo Country Code: %country_code%
echo Region Code: %region_code%
echo Timezone: %timezone%
echo ISP: %isp%
echo Organization: %organization%
echo Autonomous System: %as_number%
echo Latitude: %latitude%
echo Longitude: %longitude%
echo Zipcode: %zipcode%
echo ----------------------------

:: Clean up temp file
del temp.json

:: Show menu options
:menu
echo.
echo Select an option:
echo 1: Open Google Maps location
echo 2: Check if any websites are run on the ISP
echo 3: Check if the IP has been shown in any data breaches
echo 4: Check IP Reputation
echo 5: Exit
set /p choice="Enter your choice: "

:: Process user selection
if "%choice%"=="1" start "" "https://www.google.com/maps/search/%latitude%,%longitude%" && goto menu
if "%choice%"=="2" start "" "https://viewdns.info/reverseip/?host=%ip%" && goto menu
if "%choice%"=="3" start "" "https://haveibeenpwned.com/PwnedWebsites" && goto menu
if "%choice%"=="4" start "" "https://www.abuseipdb.com/check/%ip%" && goto menu
if "%choice%"=="5" exit

:: Invalid input, ask again
echo Invalid option. Try again.
goto menu
