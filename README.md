# EmployeeTask
[Watch the demo video](https://youtu.be/KP-Ml1q9pOk)

# Setup Instructions

- Clone the repo
- Use visual studio 2022 and .Net 7.0
- Open the frontend folder then double click on index.html 
- Open .sln file in api folder and run the project in visual studio in "http" mode (not IIS, Docker or any other modes)
- Also if needed, change in appsettings.json in .Net project to your desired DB connection
- Download any script(with or withoutData), firstly make sure you have an empty "Employee" database already created on sql server manager, then open a new query window then copy paste the script contents and run. Please select database "Employee" when running the query it might be selected to "master" by default.

# Project Overview and Features

- Employee CRUD
- Can filter employees
- Supports Pagination 
- Can add Multiple Performance Reviews 
- Showing Average Department Perforcemance score

# Any additional notes or optimizations
- Everytime a new performance review is added, the average of all previous and current reviews will be stored in Employee table column AverageScore. Keeping all the Averages like this way to prevent recalculations averages again and again for all employees during calculating the average performance score of Departments.

- Also created a different table "DepartmentAvgScores" to store the calculated averages of all departments so that when the UI is loading it will fetch from here rather than calculating again and again.

- To avoid many recalculations of average scores and Joining tables when showing Employees on the list, "EmployeeListView" table was used, it is readonly table where all the informations are kept which do not require joins and recalculations of averages. The columns of this table was indexed because filterings is done on this table.



