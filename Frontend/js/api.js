const API_BASE_URL = "http://localhost:5283/api";

async function addEmployee(event) {
    event.preventDefault();

    const employeeData = {
        name: document.getElementById("employeeName").value,
        email: document.getElementById("employeeEmail").value,
        phone: document.getElementById("employeePhone").value,
        departmentId: document.getElementById("employeeDepartment").value,
        position: document.getElementById("employeePosition").value,
        joiningDate: document.getElementById("employeeJoiningDate").value,
        status: true
    };

    const response = await fetch(`${API_BASE_URL}/Employee/CreateEmployee`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(employeeData),
    });

    if (response.ok) {
        alert("Employee added successfully!");
        fetchEmployees(1, 10); // Refresh the table
    } else {
        alert("Error adding employee.");
    }
}

async function addPerformanceReview(event) {
    event.preventDefault();

    const employeeId = document.getElementById('employeeId').value;
    
    const review = {
        id: 0,
        employeeId: employeeId,
        reviewScore: parseInt(document.getElementById('reviewScore').value),
        reviewDate: document.getElementById('reviewDate').value,
        reviewNotes: document.getElementById('reviewNotes').value
    };

    const response = await fetch(`${API_BASE_URL}/PerformanceReview/CreatePerformanceReview`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(review),
    });

    if (response.ok) {
        alert("Review added successfully!");
        fetchEmployees(1, 10); // Refresh the table
        getDepartmentAveragePerformance();
    } else {
        alert("Error adding review.");
    }
    bootstrap.Modal.getInstance(document.getElementById('performanceReviewModal')).hide();
}

async function fetchEmployees(pageNumber, pageSize) {
    const response = await fetch(`${API_BASE_URL}/Employee/GetEmployees?pageNumber=${pageNumber}&pageSize=${pageSize}`);
    const employees = await response.json();
    updateEmployeeTable(employees);
}

async function submitFilter() {
    // Get values from the filter form inputs
    const name = document.getElementById('searchName').value;
    const position = document.getElementById('filterPosition').value;
    const department = document.getElementById('filterDepartment').value;
    const minScore = parseFloat(document.getElementById('filterScoreMin').value) || null;
    const maxScore = parseFloat(document.getElementById('filterScoreMax').value) || null;

    // Prepare the filter object
    const filter = {
        name: name || null,
        position: position || null,
        departmentName: department || null,
        minScore: minScore,
        maxScore: maxScore
    };

    // Send the filter data to the API
    try {
        const response = await fetch(`${API_BASE_URL}/Employee/GetFilteredEmployees`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(filter),
        });

        // Check if the response is successful
        if (!response.ok) {
            throw new Error('Failed to fetch filtered employees');
        }

        // Get the filtered employees data
        const employees = await response.json();

        // Update the UI with the filtered employees (you can reuse the table update logic here)
        updateEmployeeTable(employees);
    } catch (error) {
        console.error('Error submitting filter:', error);
    }
}

function updateEmployeeTable(employees) {
    const tableBody = document.getElementById('employeeTable');
    tableBody.innerHTML = ''; // Clear the table

    let currentPage = 1;
    const rowsPerPage = 5;
    const start = (currentPage - 1) * rowsPerPage;
    const end = start + rowsPerPage;
    const paginatedEmployees = employees.slice(start, end);

    employees.forEach((employee, index) => {
        const row = `
            <tr>
                <td>${employee.name}</td>
                <td>${employee.email}</td>
                <td>${employee.phone}</td>
                <td>${employee.departmentName}</td>
                <td>${employee.position}</td>
                <td>${employee.joiningDate}</td>
                <td>
                    ${employee.status ? "" : ""}
                    ${employee.performanceScore}
                    <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#allScoresModal" onclick="viewAllScores(${employee.id})">All Scores</button>
                </td>
                <td>
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editEmployeeModal" onclick="prepareEditPage(${employee.id})">Edit</button>
                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteEmployeeModal" onclick="prepareDeletePage(${employee.id})">Delete</button>
                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#performanceReviewModal" onclick="prepareReview(${employee.id})">Add Score</button>
                </td>
            </tr>`;
        tableBody.innerHTML += row;
    });

    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';

    // const totalPages = Math.ceil(employees.length / rowsPerPage);
    const totalPages = 5;

    for (let i = 1; i <= totalPages; i++) {
        const li = document.createElement('li');
        li.className = `page-item ${i === currentPage ? '' : ''}`;
        li.innerHTML = `<button class="page-link">${i}</button>`;
        li.addEventListener('click', () => {
            currentPage = i;
            fetchEmployees(i, 10);
        });
        pagination.appendChild(li);
    }
}

function resetFilter(){
    document.getElementById('searchName').value = '';
    document.getElementById('filterPosition').value = '';
    document.getElementById('filterScoreMin').value = '';
    document.getElementById('filterScoreMax').value = '';

    const selectElement = document.getElementById("filterDepartment");
    selectElement.selectedIndex = 0;
    selectElement.value = "";

    const tableBody = document.getElementById('employeeTable');
    tableBody.innerHTML = ''; // Clear existing rows
    fetchEmployees(1, 10);
}

async function viewAllScores(employeeId, pageNumber, pageSize = 5) {
    if(pageNumber === undefined) pageNumber = 1;
    try {
        const response = await fetch(`${API_BASE_URL}/PerformanceReview/GetPerformanceReview?id=${employeeId}&pageNumber=${pageNumber}&pageSize=${pageSize}`, {
            method: 'GET',
        });
    
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
    
        const reviews = await response.json();
        console.log('Performance Reviews:', reviews);
        updateEmployeePerformanceReviewTable(reviews, employeeId); // Call a function to display reviews in a modal
    } catch (error) {
        console.error('Error fetching performance reviews:', error);
    }
}

function updateEmployeePerformanceReviewTable(reviewsList, employeeId){
    let currentReviewPage = 1;
    const reviewsPerPage = 5;
    let totalReviews = 20;

    const reviews = reviewsList;
    const tableBody = document.getElementById('performanceScoresTableBody');
    tableBody.innerHTML = ''; // Clear existing rows
    
    const start = (currentReviewPage - 1) * reviewsPerPage;
    const end = start + reviewsPerPage;
    const paginatedReviews = reviews.slice(start, end);
    
    paginatedReviews.forEach(review => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${review.reviewDate}</td>
            <td>${review.reviewScore}</td>
            <td>${review.reviewNotes}</td>
        `;
        tableBody.appendChild(row);
    });

    const pagination = document.getElementById('paginationScores');
    pagination.innerHTML = ''; // Clear existing pagination
    
    const totalPages = Math.ceil(totalReviews / reviewsPerPage);

    for (let i = 1; i <= totalPages; i++) {
        const li = document.createElement('li');
        li.className = `page-item ${i === currentReviewPage ? '' : ''}`;
        li.innerHTML = `<button class="page-link">${i}</button>`;
        li.addEventListener('click', (event) => {
            currentReviewPage = i;
            viewAllScores(employeeId, currentReviewPage, 5);
        });
        pagination.appendChild(li);
    }
}

async function getDepartmentAveragePerformance() {
    try {
        const response = await fetch(`${API_BASE_URL}/PerformanceReview/GetDepartmentPerformance`, {
            method: 'GET',
        });
    
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
    
        const deptReviews = await response.json();

        const tableBody = document.getElementById('averageScoresTable');
        tableBody.innerHTML = '';

        deptReviews.forEach(department => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${department.departmentName}</td>
                <td>${department.departmentAvgScore}</td>
            `;
            tableBody.appendChild(row);
        });

    } catch (error) {
        console.error('Error fetching performance reviews:', error);
    }
}

async function prepareEditPage(employeeId) {
    try {
        const response = await fetch(`${API_BASE_URL}/Employee/GetEmployee?id=${employeeId}`, {
            method: 'GET',
        });
    
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const employee = await response.json();

        const joiningDate = new Date(employee.joiningDate);
        const formattedDate = joiningDate.toISOString().split('T')[0];

        document.getElementById('employeeIdEdit').value = employee.id;
        document.getElementById('editEmployeeName').value = employee.name;
        document.getElementById('editEmployeeEmail').value = employee.email;
        document.getElementById('editEmployeePhone').value = employee.phone;
        document.getElementById('editEmployeeDepartment').value = employee.departmentId;
        document.getElementById('editEmployeePosition').value = employee.position;
        document.getElementById('editEmployeeJoiningDate').value = formattedDate;
    } catch (error) {
        console.error('Error fetching data:', error);
    }
}

async function updateEmployeeData(){
    const employeeId = document.getElementById('employeeIdEdit').value;

    const employeeData = {
        id: employeeId,
        name: document.getElementById("editEmployeeName").value,
        email: document.getElementById("editEmployeeEmail").value,
        phone: document.getElementById("editEmployeePhone").value,
        departmentId: document.getElementById("editEmployeeDepartment").value,
        position: document.getElementById("editEmployeePosition").value,
        joiningDate: document.getElementById("editEmployeeJoiningDate").value,
        status: true
    };

    const response = await fetch(`${API_BASE_URL}/Employee/PutEmployee`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(employeeData),
    });

    if (response.ok) {
        alert("Employee updated successfully!");
        fetchEmployees(1, 10); // Refresh the table
    } else {
        alert("Error updating employee.");
    }
}

function prepareDeletePage(employeeId) {
    document.getElementById('employeeIdDelete').value = employeeId;
}

async function deleteEmployeeData(){
    let id = document.getElementById('employeeIdDelete').value;
    const response = await fetch(`${API_BASE_URL}/Employee/DeleteEmployee?id=${id}`, {
        method: "DELETE",
        headers: { "Content-Type": "application/json" }
    });

    if (response.ok) {
        alert("Employee deleted successfully!");
        fetchEmployees(1, 10); // Refresh the table
    } else {
        alert("Error deleting employee.");
    }
}

// Call the function on page load
fetchEmployees(1, 10);
getDepartmentAveragePerformance();


