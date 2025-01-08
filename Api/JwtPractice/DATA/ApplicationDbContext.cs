using JwtPractice.Models;
using JwtPractice.ViewModels;
using Microsoft.EntityFrameworkCore;

namespace JwtPractice.DATA
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
            ;
        }

        public virtual DbSet<Employee> Employee { get; set; }
        public virtual DbSet<Departments> Departments { get; set; }
        public virtual DbSet<PerformanceReview> PerformanceReview { get; set; }
        public DbSet<DepartmentPerformance> DepartmentPerformances { get; set; }
        public DbSet<DepartmentViewModel> DepartmentViewModel { get; set; }
        public virtual DbSet<EmployeeListView> EmployeeListView { get; set; }

        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Map the view to the DepartmentPerformance model
            modelBuilder.Entity<DepartmentPerformance>(entity =>
            {
                entity.HasNoKey();  // Views usually don't have a primary key
                entity.ToView("DepartmentPerformance");  // Map the model to the view
            });

            modelBuilder.Entity<DepartmentViewModel>(entity =>
            {
                entity.HasNoKey();  // Views usually don't have a primary key
                entity.ToView("DepartmentViewModel");  // Map the model to the view
            });
        }

        //public virtual DbSet<School> School { get; set; }
        //public virtual DbSet<Student> Student { get; set; }
        //public virtual DbSet<Class> Class { get; set; }
        //public virtual DbSet<Section> Section { get; set; }
        //public virtual DbSet<Subscription> Subscription { get; set; }
        //public virtual DbSet<Offer> Offer { get; set; }
        //public virtual DbSet<PGWSecurityToken> PGWSecurityToken { get; set; }
        //public virtual DbSet<ZikrAppVersion> ZikrAppVersion { get; set; }


        //public virtual DbSet<StudentsSubject> StudentsSubjects { get; set; }

        //public virtual DbSet<Subject> Subjects { get; set; }

    }
}
