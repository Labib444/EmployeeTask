using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JwtPractice.Models
{
    public partial class Employee
    {
        [Key]
        public int Id { get; set; }

        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }

        [ForeignKey("Departments")]
        public int DepartmentId { get; set; }

        public string Position { get; set; }

        public DateTime JoiningDate { get; set; }

        public Boolean Status { get; set; }
    }
}

