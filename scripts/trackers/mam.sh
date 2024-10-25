#!/bin/bash

# After creating dynamic seedbox session put mam_id here
mam_id=$MAM_ID

# Put the global path to the appdata folder of the docker container
docker_appdata_global_path="/config" # This may or may not be correct

# Only rename if your container name is different to the appdata folder name ^^^
container_name="qbittorrentvpn"

#--------------------------------------------------------------------------------

if [ -z "$container_name" ]; then
container_name=$(basename "$docker_appdata_global_path")
fi

docker_appdata_global_path="${docker_appdata_global_path}/mam-script"
mkdir -p "$docker_appdata_global_path"
script_path="/config/mam-script"

# Gets the mam session cookie
echo "Getting cookie from mam:"
response=$(docker exec "$container_name" curl -c ${script_path}/mam.cookies -b "mam_id=$mam_id" https://t.myanonamouse.net/json/dynamicSeedbox.php)
msg=$(echo "$response" | jq -r '.msg')
if [ "$msg" != "Completed" ] && [ "$msg" != "No change" ]; then
# Print the entire response for debugging purposes
echo "Response from mam:"
echo "$response"
echo "Something went wrong. Check the response above and refer to: https://www.myanonamouse.net/api/endpoint.php/3/json/dynamicSeedbox.php"
exit 1
fi
echo "Message from mam: \"$msg\""

# Saves the update mam ip script inside the docker persistent path
echo "Creating script."
echo '#!/bin/bash

script_path="'$script_path'"
last_ip_file="${script_path}/last_ip.txt"
current_time=$(date +%s)
update_interval=$((60 * 60)) # Set the update interval to 1 hour (in seconds)

# Get the current IP address
current_ip=$(curl -s ifconfig.io)
# Exit if invalid IP
if [[ ! $current_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ && ! $current_ip =~ ^[0-9a-fA-F:]+:[0-9a-fA-F:]+$ ]]; then
echo "Invalid IP: \"$current_ip\" - exiting."
exit 1
fi

# Check if the last_ip_file exists and read the content
if [ -f "$last_ip_file" ]; then
last_ip=$(head -n 1 "$last_ip_file")
last_update_time=$(tail -n 1 "$last_ip_file")
fi

if [ "$current_ip" != "$last_ip" ]; then
# Check if the update was done in the last hour
if [ -n "$last_update_time" ]; then
time_elapsed=$((current_time - last_update_time))
if [ $time_elapsed -lt $update_interval ]; then
echo "Update already done in the last hour. Skipping..."
exit 0
fi
fi

# Update IP address and get the status directly
msg=$(curl -s -c ${script_path}/mam.cookies -b ${script_path}/mam.cookies https://t.myanonamouse.net/json/dynamicSeedbox.php | jq -r '\''.msg'\'')
echo "Message from api: $msg"

if [ "$msg" = "Completed" ] || [ "$msg" = "No change" ]; then
# Store the new IP address and update time in the last_ip_file
echo "IP address ($current_ip) updated at $current_time"
printf "%s\n%s" "$current_ip" "$current_time" > "$last_ip_file"
fi
else
echo "IP address hasn'\''t changed. Do nothing..."
fi' > ${docker_appdata_global_path}/update_ip
echo "Script saved to: ${docker_appdata_global_path}/update_ip"

# Makes the script executable
chmod +x "${docker_appdata_global_path}/update_ip"

# Prints out the docker execcute script
echo "
All done! Now create a cron schedule to run the following as often as you would like (5 - 10 mins recommended).
Note: #!/bin/bash must start on line 1 of the script.
-------Option-1--Unraid-User-Script-----------------------------------------------------------------------------
#!/bin/bash

container_name=\"$container_name\"
script_path=\"$script_path/update_ip\"

# Execute the update_ip script inside the Docker container
docker exec \"\$container_name\" \"\$script_path\"

-------Option-2--Direct-Crontab-Entry---------------------------------------------------------------------------
*/10 * * * * docker exec \"$container_name\" \"$script_path/update_ip\" >> /tmp/mam-script.log 2>&1"
