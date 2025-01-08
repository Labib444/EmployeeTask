using Microsoft.AspNetCore.Mvc;

namespace JwtPractice.Models
{
    public class DepartmentPerformance
    {
        public string DepartmentName { get; set; }
        public decimal DepartmentAvgScore { get; set; }
    }
}
