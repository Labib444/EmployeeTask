# EmployeeTask
[Watch the demo video](https://youtu.be/KP-Ml1q9pOk)

# Setup Instructions

- Clone the repo
- Use visual studio 2022 and .Net 7.0
- Open the frontend folder then double click on index.html 
- Open .sln file in api folder and run the project in visual studio in "http" mode (not IIS, Docker or any other modes)

# Project Overview and Features

- Employee CRUD
- Can filter employees 
- Can add Multiple Performance Reviews 
- Showing Average Department Perforcemance score

# Any additional notes or optimizations
- Everytime a new performance review is added, the average of all previous and current reviews will be stored in Employee table column AverageScore. Keeping all the Averages like this way to prevent recalculations averages again and again for all employees during calculating the average performance score of Departments.

- Also created a different table "DepartmentAvgScores" to store the calculated averages of all departments so that when the UI is loading it will fetch from here rather than calculating again and again.

- To avoid many recalculations of average scores and Joining tables when showing Employees on the list, "EmployeeListView" table was used, it is readonly table where all the informations are kept which do not require joins and recalculations of averages. 


