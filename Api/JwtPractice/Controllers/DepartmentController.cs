using JwtPractice.DATA;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace JwtPractice.Controllers
{
    [ApiController]
    [Route("api/Department")]
    public class DepartmentController : ControllerBase
    {
        private ApplicationDbContext _dbContext;
        public DepartmentController(ApplicationDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        [HttpGet("GetDepartments")]
        public async Task<IActionResult> GetDepartments()
        {
            var result = await _dbContext.DepartmentViewModel.ToListAsync();
            return Ok(result);
        }
    }
}
