#KEK WON YANG
#TP063869

#Packages
library(ggplot2)
library(data.table)
library(dplyr)
library(patchwork)


#Data Import
raw_employee_File = read.table(file="C:\\Users\\user\\Desktop\\Uni\\Year 2\\Sem 1\\PFDA\\Assignment\\employee_attrition.csv",header = TRUE, sep = ",")


#Data Cleaning
#Create a new file to store the data after eliminating redundant data from raw_employee_file.
employee_File =  
  raw_employee_File %>% 
  arrange(desc(length_of_service)) %>% 
  distinct(EmployeeID,.keep_all = TRUE)


#Data Pre-processing
#Correction of the wrong words.
employee_File["termreason_desc"][employee_File["termreason_desc"] == "Resignaton"] <- "Resignation"
employee_File["city_name"][employee_File["city_name"] == "New Westminister"] <- "New Westminster"
employee_File["job_title"][employee_File["job_title"] == "CHief Information Officer"] <- "Chief Information Officer"

#Rename the columns
colnames(employee_File)[which(names(employee_File) == "BUSINESS_UNIT")] <- "business_unit"
colnames(employee_File)[which(names(employee_File) == "STATUS")] <- "status"
colnames(employee_File)[which(names(employee_File) == "STATUS_YEAR")] <- "status_year"

#Remove unnecessary column
employee_File <- subset (employee_File, select = -gender_short)


#Data Transformation
employee_File$business_unit = 
  factor(employee_File$business_unit, levels = c("HEADOFFICE", "STORES"),labels = c(1,2))

employee_File = employee_File %>%
  mutate(hire_year = format(as.Date(employee_File$orighiredate_key, format="%m/%d/%Y"),"%Y"))

employee_File = employee_File %>%
  mutate(birth_year = format(as.Date(employee_File$birthdate_key, format="%m/%d/%Y"),"%Y"))


#Data Exploration
summary(employee_File)
count(employee_File, city_name)
count(employee_File, department_name)
count(employee_File, job_title)
count(employee_File, gender_short)
count(employee_File, gender_full)
count(employee_File, termreason_desc)
count(employee_File, termtype_desc)
count(employee_File, status)
count(employee_File, business_unit)
nrow(employee_File)

sum(duplicated(employee_File))
any(is.na(employee_File))


#Question 1: Why employees leave the company?

#Analysis 1.1: The relationship between departments, gender and voluntary termination.
employee_File %>%
  group_by(department_name) %>%
  filter(n() > 100) %>%
  filter(termtype_desc == "Voluntary") %>%
  ggplot(aes(department_name, fill = gender_full)) +
  geom_bar(position = "dodge",
           cex.axis = 3) +
  labs(title = "Bar Chart",
      subtitle = "The relationship between departments, gender and voluntary termination.",
      x = "Departments",
      y = "Number of people") +
  theme(text = element_text(size = 16)) +
  theme_bw() +
  geom_text(stat = "count", aes(label = ..count..), size = 3,
            vjust = -.5, position = position_dodge(.9))

#Analysis 1.2: The relationship between job age of each gender and voluntary termination.
employee_File %>%
  filter(termtype_desc == "Voluntary") %>%
  ggplot(aes(length_of_service, fill = gender_full)) +
  geom_bar(position = "dodge", color = "black") +
  labs(title="Bar chart",
       subtitle="The relationship between length of service of each gender and voluntary termination.",
       x = "Length of Service",
       y = "Number of Employee") +
  geom_text(stat = "count", aes(label = ..count..), size = 3,
            vjust = -.5, position = position_dodge(.9)) +
  theme_minimal()  +
  theme(text = element_text(size = 16))

employee_File %>%
  filter(termtype_desc == "Voluntary", length_of_service %in% c(1,5,8,13)) %>%
  ggplot(aes(x = reorder(length_of_service, +length_of_service), fill = gender_full)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  geom_text(stat = "count", aes(label = ..count..), size = 3,
            vjust = -.5, position = position_dodge(.9)) +
  facet_wrap(~termreason_desc) +
  labs(title="Bar chart",
       subtitle="The relationship between length of service of each gender and voluntary termination.",
       x = "Length of service",
       y = "Number of Employee") +
  theme(text = element_text(size = 16))


#Analysis 1.3: The relationship between year, employees’ gender and termination reason.
employee_File %>%
  filter(status == "TERMINATED") %>%
  ggplot(aes(status_year, fill = gender_full)) +
  geom_density(alpha = 0.5) +
  facet_wrap(~termreason_desc) +
  theme_minimal() +
  labs(title="Density Plot",
       subtitle="The relationship between year, employees’ gender and termination reason.",
       x = "Year",
       y = "Density") +
  theme(text = element_text(size = 16))


#Analysis 1.4: The relationship between birth year, gender and termination reason.
employee_File %>%
  group_by(birth_year, termreason_desc) %>%
  filter(termreason_desc %in% c("Resignation", "Layoff"), 
         n() > 10) %>%
  ggplot(aes(x = birth_year, fill = gender_full)) +
  geom_bar(position = "dodge", color = "black") +
  theme_dark() +
  geom_text(stat = "count", aes(label = ..count..), size = 5,
            vjust = 1.5, position = position_dodge(.9), color = "white") +
  facet_wrap(~termreason_desc) +
  labs(title="Bar chart",
       subtitle="The relationship between employees' birth year, gender and termination reason.",
       x = "Employees' Birth Year",
       y = "Number of Employee",
       fill = "Gender") +
  theme(text = element_text(size = 20))


#Analysis 1.5: The relationship between city, employees’ gender and termination reason.
employee_File %>%
  group_by(city_name, termreason_desc) %>%
  filter(termreason_desc %in% c("Resignation", "Layoff"), n() > 15) %>%
  ggplot(aes(y = city_name, fill = gender_full)) +
  geom_bar(position = "dodge", color = "black") +
  theme_test() +
  geom_text(stat = "count", aes(label = ..count..), size = 5,
            vjust = 0, position = position_dodge(.9)) +
  facet_wrap(~termreason_desc) +
  labs(title="Bar chart",
       subtitle="The relationship between city, employees’ gender and termination reason.",
       x = "Number of Employee",
       y = "City",
       fill = "Gender") +
  theme(text = element_text(size = 20))


#Analysis 1.6: The resignation of employees' position in Vancouver and Victoria.
employee_File %>%
  group_by(city_name, termreason_desc) %>%
  filter(termreason_desc == "Resignation", 
         city_name %in% c("Vancouver", "Victoria")) %>%
  ggplot(aes(x = job_title, fill = gender_full)) +
  geom_bar(position = "dodge", color = "black", size = 0.8) +
  theme_test() +
  geom_text(stat = "count", aes(label = ..count..), size = 5,
            vjust = -.5, position = position_dodge(.9)) +
  facet_wrap(~city_name) +
  labs(title="Bar chart",
       subtitle="The resignation of employees' position in Vancouver and Victoria.",
       x = "Number of Employee",
       y = "Job Title",
       fill = "Gender") +
  theme(text = element_text(size = 20),
        axis.text.x = element_text(angle=45, vjust=0.6)) 


#Question 2: Is there any issue within different business unit?

#Analysis 2.1: The relationship between business unit and employees' voluntary termination reason.
employee_File %>%
  filter(termreason_desc %in% c("Resignation", "Retirement")) %>%
  ggplot(aes(x = business_unit, fill = business_unit)) +
  geom_density(size = 1, alpha = 0.5) +
  theme_minimal() +
  labs(title="Density Plot",
       subtitle="The relationship between business unit and employees' voluntary termination reason.",
       x = "Business Unit",
       y = "Density") +
  facet_wrap(~termreason_desc) +
  theme(text = element_text(size = 16))


#Analysis 2.2: The relationship between business unit and employees' service time.
employee_File %>%
  ggplot(aes(x = business_unit, y = length_of_service, fill = gender_full)) +
  geom_violin(size = 0.5, alpha = 0.7) +
  theme_minimal() +
  labs(title="Violin Plot",
       subtitle="The relationship between business unit and employees' service time.",
       x = "Business Unit",
       y = "Length of Service") +
  theme(text = element_text(size = 20))


#Analysis 2.3: The relationship between business unit, gender and employees' age.
employee_File %>%
  ggplot(aes(x = business_unit, y = age, fill = gender_full)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title="Box Plot",
       subtitle="The relationship between business unit, gender and employees' age.",
       x = "Business unit",
       y = "Employees' age") +
  theme(text = element_text(size = 20))


#Question 3: Which departments should be concerned before issues happen in the company?
  
#Analysis 3.1: The proportion of gender in each department.
overall_Department =
  employee_File %>%
  ggplot(aes(y = department_name, fill = gender_full)) +
  geom_bar(position = "dodge", color = "black") +
  facet_wrap(~status) +
  geom_text(stat = "count", aes(label = ..count..), size = 4,
            position = position_dodge(.9)) + theme_minimal() +
  labs(title="Bar chart",
       subtitle="The proportion of gender in each department.",
       x = "Number of Employee",
       y = "Deparments")

meats_Department =
  employee_File %>%
  filter(department_name == "Meats") %>%
  ggplot(aes(y = reorder(store_name, +store_name), fill = gender_full)) +
  geom_bar(position = "dodge", color = "black") +
  facet_wrap(~status) +
  geom_text(stat = "count", aes(label = ..count..), size = 4,
            position = position_dodge(.9)) + theme_minimal() +
  labs(title="Bar chart",
       subtitle="The proportion of gender in meats deparment of each store.",
       x = "Number of Employee",
       y = "Store Code")

overall_Department + meats_Department

#Analysis 3.2: The proportion of employees' ages in the big departments.
employee_File %>%
  filter(department_name %in% c("Bakery", "Customer Service", "Meats", "Produce")) %>%
  ggplot(aes(x = department_name ,y = age, fill = gender_full)) +
  geom_violin(color = "black", size = 0.8) +
  theme_bw() +
  labs(title="Violin Plot",
       subtitle="The proportion of employees' ages in the big departments.",
       x = "Department's Name",
       y = "Employees' age") +
  theme(text = element_text(size = 20))

bw + minimal + test + dark

#Analysis 3.3: The average of employees’ length of service in some department.
mean_department_Service_Length = employee_File %>%
  group_by(department_name,gender_full) %>%
  summarise_at(vars(length_of_service),funs(mean(.,na.rm=TRUE)))

mean_department_Service_Length %>%
  filter(length_of_service < 10) %>%
  ggplot(aes(x = department_name, y = length_of_service, fill = gender_full)) +
  geom_bar(stat = "identity", width=.5, color = "black") +
  theme_test() +
  geom_text(aes(label = round(length_of_service, 2)),size = 5, 
            position = position_stack(vjust = 0.5)) +
  labs(title="Bar chart",
       subtitle="The average of employees’ length of service in some departments.",
       x = "Departments",
       y = "Length of Service",
       fill = "Gender") +
  theme(text = element_text(size = 20))

#Analysis 3.4: The relationship between store and department.
employee_File %>%
  group_by(store_name) %>%
  filter(n() > 300) %>%
  ggplot(aes(y = department_name , fill = department_name)) +
  geom_bar(color = "black", size = 0.8) +
  facet_wrap(~store_name) +
  theme_bw() +
  labs(title="Bar Chart",
       subtitle="The relationship between store and department.",
       x = "Number of Employee",
       y = "Department") +
  theme(text = element_text(size = 20))


#Question 4: Is there any issue in each store?

#Analysis 4.1: The average of ages in each store.
store_Average_Age = employee_File %>%
  group_by(store_name, status, gender_full) %>%
  summarise_at(vars(age),funs(mean(.,na.rm=TRUE)))

store_Average_Age %>%
  group_by(store_name, age) %>%
  filter(age > 50, store_name != 35, status == "ACTIVE") %>%
  ggplot(aes(x = age, y = reorder(store_name, +store_name), color = gender_full)) +
  geom_point(size = 5) +
  theme_bw() +
  labs(title="Scatterplot",
       subtitle="The relationship between stores and employees' average age.",
       x = "Employees' Average Age",
       y = "Store Code")
  theme(text = element_text(size = 20))

#Analysis 4.2: Are there any store nearly to close down?
employee_File %>%
  filter(termreason_desc =="Retirement") %>%
  ggplot(aes(y = store_name, x = age, fill = gender_full)) +
  geom_violin() +
  theme_bw() +
  labs(title="Violin Plot",
       subtitle="Employees' retirement age in each store.",
       x = "Age",
       y = "Store Code") +
  theme(text = element_text(size = 20))

store_Average_Age %>%
  filter(status == "ACTIVE", age > 63) %>%
  ggplot(aes(x = reorder(store_name, +store_name), y = age, fill = gender_full)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_bw() +
  labs(title="Bar chart",
       subtitle="The relationship between store, employees' gender, and their average age.",
       x = "Store Code",
       y = "Employees' Average Age") +
  geom_text(aes(label = round(age,2)), size = 4,
            position = position_dodge(.9)) +
  theme(text = element_text(size = 20))

#Analysis 4.3: The employees' age in each department of the store 37.
employee_File %>%
  filter(store_name == 37, status == "ACTIVE") %>%
  count(EmployeeID)

employee_File %>%
  filter(store_name == 37, status == "ACTIVE") %>%
  ggplot(aes(x = age, fill = gender_full)) +
  geom_bar(position = "dodge", stat = "count",color = "black",size = .8) +
  facet_wrap(~job_title) +
  theme_bw()  +
  theme(text = element_text(size = 20),legend.key.size = unit(5, "line")) +
  geom_text(stat = "count", aes(label = ..count..), size = 3,
            vjust = 1, position = position_dodge(.9))  +
  theme(text = element_text(size = 20)) +
  labs(title="Bar Chart",
       subtitle = "The employees' age, gender, and position of store 37.",
       x = "Age",
       y = "Number of Employee",
       fill = "Gender")


#Question 5: Does any job title affect the company?

#Analysis 5.1: The relationship between job title and employees' age.
employee_File %>%
  group_by(job_title) %>%
  filter(n() > 700, status == "ACTIVE") %>%
  ggplot(aes(x = job_title, y = age, fill = gender_full)) +
  geom_violin() +
  theme_bw() +
  labs(title="Violin Plot",
       subtitle="The relationship between job title and employees' age.",
       x = "Job Title",
       y = "Age")  +
  theme(text = element_text(size = 20))

#Analysis 5.2: Does job title affect the length of services of employee?
jobtitle_Average_Service = employee_File %>%
  group_by(job_title, gender_full) %>%
  summarise_at(vars(length_of_service),funs(mean(.,na.rm=TRUE)))

jobtitle_Average_Service %>%
  group_by(job_title, length_of_service) %>%
  filter(length_of_service < 12) %>%
  ggplot(aes(x = length_of_service, y = job_title)) +
  geom_point(colour="white", shape=21, size = 6,
             aes(fill = factor(gender_full))) +
  scale_fill_manual(values=c("pink", "light blue")) +
  theme_bw()  +
  labs(title="Scatterplot",
       subtitle="The relationship between job title and employees' length of services.",
       x = "Average of length of service",
         y = "Job Title") +
  theme(text = element_text(size = 20))

#Analysis 5.3: The relationship between job title and employees’ termination reason.
employee_File %>%
  group_by(job_title) %>%
  filter(termreason_desc %in% c("Layoff", "Resignation"),
         job_title %in% c("Cashier", "Dairy Person", "Shelf Stocker")) %>%
  ggplot(aes(x = job_title, fill = termreason_desc)) +
  geom_histogram(stat = "count", position = "dodge", color = 4) +
  facet_wrap(~gender_full) +
  theme_bw() +
  labs(title="Histogram",
       subtitle="The relationship between job title and employees' termination reason.",
       x = "Average of length of service",
       y = "Job Title") +
  theme(text = element_text(size = 20))

#Analysis 5.4: The relationship between job title and city.
employee_File %>% 
    group_by(job_title, city_name) %>%
    filter(n() > 85, status == "ACTIVE") %>%
    ggplot(aes(y = city_name, fill = job_title)) +
    geom_bar(stat = "count", position = "dodge", color = "black", size = 0.7) +
    theme_test() +
    labs(title="Bar Chart",
         subtitle="The relationship between job title and city.",
         x = "The number of employees",
         y = "City", 
         fill = "Job Title")  +
    theme(text = element_text(size = 20))

#Analysis 5.5: The employees recruited in past ten years in each job title.
employee_File %>% 
  filter(between(hire_year,2005,2015)) %>%
  ggplot(aes(y = hire_year, fill = job_title)) +
  geom_bar(position = "dodge", color = "black", size = 0.8) +
  theme_test() +
  labs(title="Bar Chart",
       subtitle="The employees recruited in past ten years in each job title.",
       x = "The number of employees",
       y = "Employees' Recruitment Year",
       fill = "Job Title")  +
  theme(text = element_text(size = 20))

#Analysis 5.6: Job title in the two largest stores of the company.
employee_File %>% 
  group_by(store_name) %>%
  filter(n() > 450, status == "ACTIVE") %>%
  ggplot(aes(y = reorder(store_name, +store_name), fill = job_title)) +
  geom_bar(stat = "count", position = "dodge", color = "black", size = 0.8) +
  theme_test() +
  labs(title="Bar Chart",
       subtitle="Job title in the two largest stores of the company.",
       x = "The number of employees",
       y = "Store Code",
       fill = "Job Title") +
  theme(text = element_text(size = 20))


#EXTRA FEATURES
# 1. Library(patchwork)   // Patchwork is a package that aims to make combining different ggplots into a single design.
# 2. scale_fill_manual   // Users are allow to define their unique range of mappings from data levels to aesthetic values. 
# 3. theme()            // Theme() allow users to customize their plots, such as adding labels, text, fonts, and others.
# 4. theme_bw(),        // Change the plots' background.
#    theme_minimal(), 
#    theme_test(), 
#    theme_dark()


