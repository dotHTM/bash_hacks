# Terminal Reference

Use wget with authentication without logging password in .bash_history

	wget -mp -np https://WEBSITE_DOMAIN_AND_PATH/ -R "*?*" --http-user=YOUR_USERNAME --http-password=`read -s thePassword; echo $thePassword` --no-check-certificate -e robots=off

	