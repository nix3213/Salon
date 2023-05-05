#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

function f_main {
  echo -e "Welcome to My Salon, how can I help you?\n"
  echo -e "1) cut\n2) color\n3) perm\n4) style\n5) trim"

  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in

    1) 
      echo -e "\n1\n"
      ;;
    2) 
      echo -e "\n2\n"
      ;;
    3) 
      echo -e "\n3\n"
      ;;
    *) 
      echo -e "I could not find that service. What would you like today?\n"
      f_main 
      ;;
  esac
}
if [[ -z "$SERVICE_ID_SELECTED" ]]
then
  echo "MAIN"
  f_main
fi

function data_customer {
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')");
}

echo -e "\nWhat's your phone number?\n"
read CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'");
if [[ -z "$CUSTOMER_NAME" ]]
then
  data_customer
fi 

echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME."
read SERVICE_TIME
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'");
echo -e "\nTHIS IS THE CUSTOMER_ID: $CUSTOMER_ID\n"
APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')"); 

SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED");
echo -e "\nI have put you down for a$SERVICE at $SERVICE_TIME, $CUSTOMER_NAME.\n"

#echo $($PSQL "select * from services");
echo "ENDE"

