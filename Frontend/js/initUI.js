async function populateDepartmentOptions() {
    const departmentDropdown = document.getElementById('employeeDepartment');
    const filterDepartmentDropdown = document.getElementById('filterDepartment');
    const editDepartmentDropdown= document.getElementById('editEmployeeDepartment');
    
    try {
        const response = await fetch('http://localhost:5283/api/Department/GetDepartments');
        const departments = await response.json();
        // localStorage.setItem('departments', JSON.stringify(departments));
        departments.forEach(department => {
            const option = document.createElement('option');
            option.value = department.id;
            option.textContent = department.departmentName;
            departmentDropdown.appendChild(option);
        });

        departments.forEach(department => {
            const option = document.createElement('option');
            option.value = department.departmentName;
            option.textContent = department.departmentName;
            filterDepartmentDropdown.appendChild(option);
        });

        departments.forEach(department => {
            const option = document.createElement('option');
            option.value = department.id;
            option.textContent = department.departmentName;
            editDepartmentDropdown.appendChild(option);
        });
    } catch (error) {
        console.error('Error populating department options:', error);
    }
}

// const storedDepartments = localStorage.getItem('departments');
// const departments = JSON.parse(storedDepartments);

populateDepartmentOptions()