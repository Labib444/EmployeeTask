# EmployeeTask
[Watch the demo video](https://youtu.be/KP-Ml1q9pOk)

# Setup Instructions

- Clone the repo
- Use visual studio 2022 and .Net 7.0
- Open the frontend folder then double click on index.html 
- Open .sln file in api folder and run the project in visual studio in "http" mode (not IIS, Docker or any other modes)
- Also if needed, change in appsettings.json in .Net project to your desired DB connection
- Download any script(with or withoutData), then open a new query window then copy paste the script contents and run.


# Project Overview and Features

- Employee CRUD has soft delete
- Can filter employees
- Supports Pagination 
- Can add Multiple Performance Reviews 
- Showing Average Department Perforcemance score
- Very Basic form validations have been added, therefore will advice caution.
- Used stored procedures, views, transactions
- Used EntityFramework for easier query to object mapping and also for triggering raw sql queries.
- Frontend is basic html and javascript 

# Any additional notes or optimizations
- Everytime a new performance review is added, the average of all previous and current reviews will be stored in "Employee" table column "AverageScore". Keeping all the Averages like this way to prevent recalculations of averages again and again for all employees during calculating the average performance score of Departments.

- Also created a different table "DepartmentAvgScores" to store the calculated averages of all departments so that when the UI is loading it will fetch from here rather than calculating again and again.

- To avoid many recalculations of average scores and Joining tables when showing Employees on the list, "EmployeeListView" table was used, it is readonly table where all the informations are kept which do not require joins and recalculations of averages. The columns of this table was indexed because filterings is done on this table.

- I have created Indexes on "EmployeeListView" for Name, Position, DepartmentName, PerformanceScore(between 1 and 10), also created 
combined index of them. Also created index for EmployeeId in "PerformanceReview" table because everytime we open to see all employees review it fetches using employeeId.

- "EmployeeListView" table is only for reading the main table is actually "Employee" table.

- When calculating Department score average it ignores employees who are in inactive or has no reviews.

- Also if you are using scriptWithData.sql then some data might never show in UI because those data where used in debugging. Kindly freshly create new data and check on them.



