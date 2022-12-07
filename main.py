import psycopg2
from psycopg2 import Error
import warnings
import pandas as pd
import os

#gets rid of pandas deprecated warning
warnings.simplefilter(action="ignore", category=UserWarning)

#clear console for readability 
clear_console = lambda: os.system("cls" if os.name == "nt" else "clear")

#user menu
def menu():
    menu = "\n-- Creche CLI --\n\n"
    menu += "1. Update Guardian Phone Number\n"
    menu += "2. Add Staff Member\n"
    menu += "3. Insert a session log\n"
    menu += "4. End Program"
    print(menu)

#input validation for menu
def menu_choice():
    while True:
        user = input("\nEnter: ")
        
        if user.isdigit() and int(user) > 0 and int(user) < 5:
            return int(user)
        
        print("\nInvalid input!")

#input validation for update_guadian_phone function
def update_guadian_phone():
    while True:
        g_id = input("\nEnter Guardian ID: ")
        new_phone = input("Enter Phone Number: ")
        
        if g_id.isdigit() and new_phone.isdigit():
            return int(g_id), new_phone
        
        print("\nMake sure guradian ID and phone number is valid!")

#input validation for add_staff_member function
def add_staff_member():
    while True:
        staff_name = input("\nName: ")
        staff_num = input("Phone Number: ")
        staff_email = input("Email: ")
        
        if "@" in staff_email and staff_num.isdigit():
                return staff_name, staff_num, staff_email
            
        print("\nMake sure email includes an '@' symbol!")

#inputing a session error checking
def session_log():
    while True:
        hours_slept = input("\nHours Selpt: ")
        food = input("Food Ate: ")
        well_being = input("Well Being: ")
        staff_id = input("Your Staff ID: ")
        child_id = input("Child ID: ")
        room_number = input("Room Number: ")
        date = input("Date (YYYY-MM-DD): ")
        
        if staff_id.isdigit() and hours_slept.isdigit and child_id.isdigit() and room_number.isdigit:
            return int(hours_slept), food, well_being, int(staff_id), int(child_id), room_number, date
        
        print("\nMake sure inputs are valid!")

#main function
def main():
    while True:
        clear_console()
        menu()
        choice = menu_choice()
        
        if choice == 4:
            print("\nGoodbye!\n")
            break
        
        try:
            with psycopg2.connect(database="...",
                                  user="...",
                                  password="...",
                                  host="localhost",
                                  port=5432) as connection:
                
                #creating curson for db operations
                cursor = connection.cursor()
                
                #updating guardian phone number
                if choice == 1:
                    #calling update_guadian_phone() and then sql function
                    update_phone_details = update_guadian_phone()
                    cursor.callproc("update_guardian_phone_number", (update_phone_details[0], update_phone_details[1]))
                    connection.commit()

                    sql_query = f"SELECT * FROM guardian WHERE guardian_id = {update_phone_details[0]}"
                    df = pd.read_sql_query(sql_query, connection)
                    
                    #if user gives an invalid id, the dataframe would be empty
                    if df.empty:
                        print("\nInvalid Guardian ID")
                        
                    else:
                        print(f"\nUpdated Details:\n{df}")
                
                
                #adding staff member
                elif choice == 2:
                    #calling add_staff function
                    values = add_staff_member()
                    sql_query = f"INSERT INTO staff VALUES (DEFAULT, '{values[0]}', '{values[1]}', '{values[2]}')"
                    cursor.execute(sql_query)
                    
                    #displaying updated details
                    sql_query = f"SELECT * FROM staff"
                    df = pd.read_sql_query(sql_query, connection)
                    print(f"\nUpdated Details:\n{df}")
                
                
                #inserting a session log
                elif choice == 3:
                    values = session_log()
                    sql_query = f"INSERT INTO session VALUES (DEFAULT, {values[0]}, '{values[1]}', '{values[2]}', {values[3]}, {values[4]}, '{values[5]}', '{values[6]}')"
                    cursor.execute(sql_query)
                    
                    #prints notices
                    for notice in connection.notices:
                        print(f"\n\033[1;31;40m{notice}\033[0m", end="")
                    
                    #prints last row
                    sql_query = f"SELECT * FROM session WHERE child_id = {values[4]}"
                    df = pd.read_sql_query(sql_query, connection)
                    print(f"\nUpdated Details:\n{df.iloc[-1:]}")
                    
                    
        #display errors 
        except (Exception, Error) as error:
            print(f"\nError while connecting to PostgreSQL: \033[1;31;40m{error}\033[0m")
        
        #ending connection
        if (connection):
            connection.close()
            print("\nPostgreSQL connection is closed")
        else:
            print("\nTerminating")
            
        input("\nClick Enter...")

#calling main()
if __name__ == "__main__":
    main()


