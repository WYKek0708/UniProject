# KEK WON YANG
# TP063869
import os.path
import d

def new_patient_registration():
    vaccine_centre = input("Please select a centre for vaccine administration.(Please enter VC1 or VC2)\n").upper()
    while vaccine_centre != "VC1" and vaccine_centre != "VC2":
        vaccine_centre = input("Please enter VC1 or VC2!\n").upper()
    patient_name = input("Please enter your full name\n")
    age = (input("Please enter your age.\n"))
    vaccine_choice = None
    while not age.isnumeric():
        age = (input("Please enter your age.\n"))
    if 12 <= int(age) < 18:
        vaccine_list = ["AF", "CZ", "DM"]
        vaccine_choice = input(f"Please choose a vaccine from the list: {vaccine_list} \n").upper()
        while vaccine_choice not in vaccine_list:
            print("Invalid vaccine code!")
            vaccine_choice = input(f"Please choose a vaccine from the list: {vaccine_list} \n").upper()
    elif 18 <= int(age) <= 45:
        vaccine_list = ["AF", "BV", "CZ", "DM", "EC"]
        vaccine_choice = input(f"Please choose a vaccine from the list: {vaccine_list} \n").upper()
        while vaccine_choice not in vaccine_list:
            print("Invalid vaccine code!")
            vaccine_choice = input(f"Please choose a vaccine from the list: {vaccine_list} \n").upper()
    elif 45 < int(age) < 120:
        vaccine_list = ["AF", "BV", "DM", "EC"]
        vaccine_choice = input(f"Please choose a vaccine from the list: {vaccine_list} \n").upper()
        while vaccine_choice not in vaccine_list:
            print("Invalid vaccine code!")
            vaccine_choice = input(f"Please choose a vaccine from the list: {vaccine_list} \n").upper()
    else:
        print("You are not at the age to have vaccine.")
        menu()

    patient_phone_number = input("Please enter your phone number(do not space):\n")
    while not patient_phone_number.isnumeric():
        print("Your phone number is invalid!")
        patient_phone_number = input("Please enter your phone number(do not space):\n")
    while len(patient_phone_number) < 10 or len(patient_phone_number) > 11:
        print("Your phone number is wrong!")
        patient_phone_number = input("Please enter your phone number(do not space):\n")

    patient_email = input("Please enter your email address(if you have):\n")
    while "@" not in patient_email or ".com" not in patient_email:
        if patient_email == "":
            break
        else:
            print("Your email address is wrong.")
            patient_email = input("Please enter your email address(if you have):\n")


    patient_id = patient_id_generated()
    print(f"Your patient id is {patient_id}.\nThanks for your registration!")
    patients_file = open("patients.txt","a")

    patients_file.write(str(patient_id) + ", " + vaccine_centre + ", " + patient_name + ", " + str(
        age) + ", " + vaccine_choice + ", " + patient_phone_number + ", " + patient_email + "\n")

    patients_file.close()
    time.sleep(4)
    menu()

def patient_id_generated():

    patient_id = 100000
    if os.path.isfile("patients.txt"):
        patients_file = open("patients.txt")
        for line in patients_file:
            pass
            last_line = line.split(",")
            if len(last_line) == 0 or len(last_line) == 1:
                patient_id = 100000
            else:
                patient_id = int(last_line[0]) + 1
    return patient_id

def vaccine_administration():
    vaccine_list = ["AF", "BV", "CZ", "DM", "EC"]
    patient_id = input("Please enter your patient id:\n")
    while len(patient_id) != 6:
        patient_id = input("This patient id is incorrect, please enter again\n")

    vaccine_choice = input("What is your selected vaccine?(Enter 'AF', 'BV', 'CZ', 'DM' or 'EC')\n").upper()
    while vaccine_choice not in vaccine_list:
        vaccine_choice = input("Please enter 'AF', 'BV', 'DM' or 'EC'\n").upper()

    dose_number = input("It is dose 1 or dose 2?(Enter 'D1'/'D2')\n").upper()
    while dose_number != "D1" and dose_number != "D2":
        dose_number = input("Please enter 'D1' or 'D2' \n").upper()

    if dose_number == "D1":
        if vaccine_choice == "AF":
            print(f"You have had your first dose of {vaccine_choice} vaccine,please come again for dose 2 after 14 days(two weeks)")
        elif vaccine_choice == "BV" or vaccine_choice == "CZ":
            print(f"You have had your first dose of {vaccine_choice} vaccine,please come again for dose 2 after 21 days(three weeks)")
        elif vaccine_choice == "DM":
            print(f"You have had your first dose of {vaccine_choice} vaccine,please come again for dose 2 after 28 days(four weeks)")
        elif vaccine_choice == "EC":
            print(f"After this dose your vaccination is done,congratulations!")
        elif dose_number == "D2":
            print("After this dose your vaccination is done,congratulations!")
    patients_file = open("patients.txt", "r+")
    for line in enumerate(patients_file):
        if patient_id in line:
            patient_id_line = line
            patient_id_line[7] = dose_number + "completed"
    patients_file.close()

def menu():
    now = datetime.now
    date_and_time = now.strftime("%y/%m/%d %h:/%m:/%s")
    print(date_and_time)
    print("---------Main Menu---------")
    print("Option 1--------New patient registration")
    print("Option 2--------Vaccine administration")
    print("Option 3--------Search patient record")
    print("Option 4--------Statistical information")
    print("Option 0--------Exit system")
    user_option = (input("\nPlease choose an option:\n"))
    user_option_list = ["0", "1", "2", "3", "4"]
    if user_option == "1":
        new_patient_registration()
    elif user_option == "2":
        vaccine_administration()
    elif user_option == "3":
        pass
    elif user_option == "4":
        pass
    elif user_option == "0":
        print("Thanks for your registration!")
    while user_option not in user_option_list:
        print("Please enter a valid option!")
        menu()
        break

menu()
