using JwtPractice.DATA;
using JwtPractice.Models;
using JwtPractice.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace JwtPractice.Controllers
{
    [ApiController]
    [Route("api/Employee")]
    public class EmployeeController : ControllerBase
    {

        private ApplicationDbContext _dbContext;
        public EmployeeController(ApplicationDbContext dbContext)
        {
            _dbContext = dbContext;
        }


        [HttpGet("GetEmployee")]
        public async Task<IActionResult> GetEmployee(int id)
        {
            var query = @"SELECT * FROM Employee WHERE Id = @Id";
            var result = await _dbContext.Employee
                        .FromSqlRaw(query, new SqlParameter("@Id", id))
                        .FirstOrDefaultAsync();
            return Ok(result);
        }

        [HttpGet("GetEmployees")]
        public async Task<IActionResult> GetEmployees(int pageNumber, int pageSize)
        {
            var query = @"
                        EXEC sp_GetEmployees 
                        @PageNumber = @PageNumber, 
                        @PageSize = @PageSize";

            var result = await _dbContext.EmployeeListView
                            .FromSqlRaw(query,
                                new SqlParameter("@PageNumber", pageNumber),
                                new SqlParameter("@PageSize", pageSize))
                            .ToListAsync();
            return Ok(result);
        }

        //[HttpGet("GetEmployees")]
        //public async Task<IActionResult> GetEmployees()
        //{
        //    var query = @"
        //        SELECT 
        //        ID AS Id,
        //        [Name],
        //        Email,
        //        Phone,
        //        DepartmentName,
        //        Position,
        //        JoiningDate,
        //        PerformanceScore
        //    FROM EmployeeListView";
        //    var result = await _dbContext.EmployeeListView.FromSqlRaw(query).ToListAsync();
        //    return Ok(result);
        //}

        [HttpPost("GetFilteredEmployees")]
        public async Task<ActionResult> GetFilteredEmployees([FromBody] EmployeeListViewFilterViewModel filter)
        {
            var query = @"
                        EXEC sp_FilterEmployeeListView 
                        @Name = @Name, 
                        @Position = @Position, 
                        @DepartmentName = @DepartmentName, 
                        @MinScore = @MinScore, 
                        @MaxScore = @MaxScore";
            var result = await _dbContext.EmployeeListView
                            .FromSqlRaw(query,
                                new SqlParameter("@Name", (object)filter.Name ?? DBNull.Value),
                                new SqlParameter("@Position", (object)filter.Position ?? DBNull.Value),
                                new SqlParameter("@DepartmentName", (object)filter.DepartmentName ?? DBNull.Value),
                                new SqlParameter("@MinScore", (object)filter.MinScore ?? DBNull.Value),
                                new SqlParameter("@MaxScore", (object)filter.MaxScore ?? DBNull.Value))
                            .ToListAsync();
            return Ok(result);
        }

        
        [HttpPost("CreateEmployee")]
        public async Task<ActionResult> CreateEmployee([FromBody] Employee employee)
        {
            var result = await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                $@"
                    EXEC sp_CreateEmployee 
                    @Name = {employee.Name}, 
                    @Email = {employee.Email},
                    @Phone = {employee.Phone},
                    @DepartmentId = {employee.DepartmentId},
                    @Position = {employee.Position}, 
                    @JoiningDate = {employee.JoiningDate},
                    @Status = {employee.Status}
                ");
            return Ok();
        }

        [HttpPut("PutEmployee")]
        public async Task<IActionResult> PutEmployee([FromBody] Employee employee)
        {
            var result = await _dbContext.Database.ExecuteSqlInterpolatedAsync($@"
                EXEC sp_UpdateEmployee
                @Id = {employee.Id},
                @Name = {employee.Name}, 
                @Email = {employee.Email},
                @Phone = {employee.Phone},
                @DepartmentId = {employee.DepartmentId},
                @Position = {employee.Position}, 
                @JoiningDate = {employee.JoiningDate},
                @Status = {employee.Status}
            ");
            return NoContent();
        }

        [HttpDelete("DeleteEmployee")]
        public async Task<IActionResult> DeleteEmployee(int id)
        {
            var result = await _dbContext.Database.ExecuteSqlInterpolatedAsync($"EXEC sp_DeleteEmployee @Id = {id}");
            return NoContent();
        }

        //{
        //  "id": 0,
        //  "name": "labib",
        //  "email": "labib444@gmail.com",
        //  "phone": "01532990965",
        //  "departmentId": 1,
        //  "position": "Software Engineer",
        //  "joiningDate": "2025-01-07T04:24:21.173Z",
        //  "status": true
        //}

    }
}




//using Microsoft.AspNetCore.Mvc;
//using Microsoft.EntityFrameworkCore;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Threading.Tasks;

//// DbContext
//public class EmployeeDbContext : DbContext
//{
//    public EmployeeDbContext(DbContextOptions<EmployeeDbContext> options) : base(options) { }

//    public DbSet<Employee> Employees { get; set; }
//}

//// Model
//public class Employee
//{
//    public int Id { get; set; }
//    public string Name { get; set; }
//    public string Position { get; set; }
//    public DateTime JoiningDate { get; set; }
//    public int DepartmentId { get; set; }
//}

//// Controller
//[ApiController]
//[Route("api/[controller]")]
//public class EmployeesController : ControllerBase
//{
//    private readonly EmployeeDbContext _context;

//    public EmployeesController(EmployeeDbContext context)
//    {
//        _context = context;
//    }

//    // Get All using View
//    [HttpGet]
//    public async Task<ActionResult<IEnumerable<Employee>>> GetEmployees()
//    {
//        var employees = await _context.Employees.FromSqlRaw("SELECT * FROM vw_Employees").ToListAsync();
//        return employees;
//    }

//    // Get by Id using Stored Procedure
//    [HttpGet("{id}")]
//    public async Task<ActionResult<Employee>> GetEmployee(int id)
//    {
//        var employee = await _context.Employees.FromSqlInterpolated($"EXEC sp_GetEmployeeById @Id = {id}").FirstOrDefaultAsync();
//        if (employee == null)
//        {
//            return NotFound();
//        }
//        return employee;
//    }

//    // Create using Stored Procedure
//    [HttpPost]
//    public async Task<ActionResult> PostEmployee(Employee employee)
//    {
//        await _context.Database.ExecuteSqlInterpolatedAsync($"
//            EXEC sp_CreateEmployee @Name = { employee.Name}, @Position = { employee.Position}, @JoiningDate = { employee.JoiningDate}, @DepartmentId = { employee.DepartmentId}
//        ");
//        return Ok();
//    }

//    // Update using Stored Procedure
//    [HttpPut("{id}")]
//    public async Task<IActionResult> PutEmployee(int id, Employee employee)
//    {
//        if (id != employee.Id)
//        {
//            return BadRequest();
//        }

//        await _context.Database.ExecuteSqlInterpolatedAsync($"
//            EXEC sp_UpdateEmployee @Id = { employee.Id}, @Name = { employee.Name}, @Position = { employee.Position}, @JoiningDate = { employee.JoiningDate}, @DepartmentId = { employee.DepartmentId}
//        ");

//        return NoContent();
//    }

//    // Delete using Stored Procedure
//    [HttpDelete("{id}")]
//    public async Task<IActionResult> DeleteEmployee(int id)
//    {
//        await _context.Database.ExecuteSqlInterpolatedAsync($"EXEC sp_DeleteEmployee @Id = {id}");
//        return NoContent();
//    }
//}
