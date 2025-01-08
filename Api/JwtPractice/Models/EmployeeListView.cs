using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace JwtPractice.Models
{
    public partial class EmployeeListView
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string DepartmentName { get; set; }
        public string Position { get; set; }
        public DateTime JoiningDate { get; set; }
        public decimal PerformanceScore { get; set; }
    }
}
