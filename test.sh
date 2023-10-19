
timezone=$(curl --fail https://ipapi.co/timezone)
echo -ne "------------------------------------------------------------------------------------------ \n"

timezone () {
echo -ne "\n Your timezone is '$timezone' , is that right ? (y/n) : \n"
read -r timezone_answer 

if [[ "$timezone_answer" == "y" ]] ; then
  echo -ne "Setting your time zone to '$timezone' "
  # ln -sf /usr/share/zoneinfo/"$timezone" /etc/localtime 

  elif [[ "$timezone_answer" == "n" ]]; then
  
  sure () {
    echo -ne "Please write your time zone ( Ex: Asia/Kuwait ) : \n"
    read -r TIMEZONE 

    echo -ne "Your timezone will be set to '$TIMEZONE' \n Continue ? (y/n) : \n"
    read -r continue

    if [[ "${continue}" == "y" ]]; then
      echo -ne "Setting your timezone to $TIMEZONE"
      # ln -sf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime
      else
        sure
    fi

  }

    sure
  else
    echo -ne "\n Please select (y/n) \n"
    timezone
fi 
}
timezone
