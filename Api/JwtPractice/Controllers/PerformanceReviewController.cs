using JwtPractice.DATA;
using JwtPractice.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace JwtPractice.Controllers
{
    [ApiController]
    [Route("api/PerformanceReview")]
    public class PerformanceReviewController : ControllerBase
    {

        private ApplicationDbContext _dbContext;
        public PerformanceReviewController(ApplicationDbContext dbContext)
        {
            _dbContext = dbContext;
        }


        //[HttpGet("GetPerformanceReview")]
        //public async Task<ActionResult> GetPerformanceReview(int employeeId)
        //{
        //    var query = @"
        //                SELECT * 
        //                FROM PerformanceReview 
        //                WHERE EmployeeId = @EmployeeId";

        //    var reviews = await _dbContext.PerformanceReview
        //        .FromSqlRaw(query, new SqlParameter("@EmployeeId", employeeId))
        //        .ToListAsync();

        //    return Ok(reviews);
        //}

        [HttpGet("GetPerformanceReview")]
        public async Task<List<PerformanceReview>> GetPerformanceReview(int id, int pageNumber, int pageSize)
        {
            var query = @"
                        EXEC sp_GetPerformanceReviews 
                        @EmployeeId = @EmployeeId, 
                        @PageNumber = @PageNumber, 
                        @PageSize = @PageSize";
            var result = await _dbContext.PerformanceReview
                            .FromSqlRaw(query,
                                new SqlParameter("@EmployeeId", (object)id ?? DBNull.Value),
                                new SqlParameter("@PageNumber", (object)pageNumber ?? DBNull.Value),
                                new SqlParameter("@PageSize", (object)pageSize ?? DBNull.Value))
                            .ToListAsync();
            return result;
        }

        [HttpPost("CreatePerformanceReview")]
        public async Task<ActionResult> CreatePerformanceReview([FromBody] PerformanceReview performanceReview)
        {
            try
            {
                var result = await _dbContext.Database.ExecuteSqlInterpolatedAsync(
                $@"
                    EXEC AddPerformanceReview 
                    @EmployeeId = {performanceReview.EmployeeId}, 
                    @ReviewDate = {performanceReview.ReviewDate},
                    @ReviewScore = {performanceReview.ReviewScore},
                    @ReviewNotes = {performanceReview.ReviewNotes}
                ");
                await _dbContext.Database.ExecuteSqlInterpolatedAsync($@"EXEC sp_UpdateAverageDepartmentScore");
            }
            catch(Exception ex)
            {

            }
            return Ok();
        }

        [HttpGet("GetDepartmentPerformance")]
        public async Task<List<DepartmentPerformance>> GetDepartmentPerformance()
        {
            var result = await _dbContext.DepartmentPerformances.ToListAsync();
            return result;
        }
    }
}
