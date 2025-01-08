namespace JwtPractice.ViewModels
{
    public class EmployeeListViewFilterViewModel
    {
        public string? Name { get; set; }
        public string? Position { get; set; } 
        public string? DepartmentName { get; set; }
        public decimal? MinScore { get; set; }
        public decimal? MaxScore { get; set; }
    }
}
