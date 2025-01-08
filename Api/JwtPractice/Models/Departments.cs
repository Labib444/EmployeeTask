using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace JwtPractice.Models
{
    public partial class Departments
    {
        [Key]
        public int Id { get; set; }
        public string DepartmentName { get; set; }

        [ForeignKey("Employee")]
        public int ManagerId { get; set; }
        public decimal Budget { get; set; }
    }
}
