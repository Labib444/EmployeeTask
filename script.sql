USE [master]
GO
/****** Object:  Database [Employee]    Script Date: 1/8/2025 2:35:51 PM ******/
CREATE DATABASE [Employee]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Employee', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Employee.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Employee_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Employee_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Employee] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Employee].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Employee] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Employee] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Employee] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Employee] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Employee] SET ARITHABORT OFF 
GO
ALTER DATABASE [Employee] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Employee] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Employee] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Employee] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Employee] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Employee] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Employee] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Employee] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Employee] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Employee] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Employee] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Employee] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Employee] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Employee] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Employee] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Employee] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Employee] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Employee] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Employee] SET  MULTI_USER 
GO
ALTER DATABASE [Employee] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Employee] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Employee] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Employee] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Employee] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Employee] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Employee] SET QUERY_STORE = OFF
GO
USE [Employee]
GO
/****** Object:  Table [dbo].[DepartmentAvgScores]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentAvgScores](
	[DepartmentId] [int] NOT NULL,
	[DepartmentName] [varchar](100) NULL,
	[AvgScore] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DepartmentPerformance]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DepartmentPerformance] AS
SELECT 
    DepartmentName, 
    AvgScore AS DepartmentAvgScore
FROM 
    DepartmentAvgScores;
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](100) NOT NULL,
	[ManagerId] [int] NULL,
	[Budget] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DepartmentViewModel]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DepartmentViewModel] AS
SELECT 
    Id, 
    DepartmentName
FROM 
    Departments;
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[Position] [varchar](50) NOT NULL,
	[JoiningDate] [datetime] NOT NULL,
	[Status] [bit] NOT NULL,
	[AverageScore] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeListView]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeListView](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Phone] [nvarchar](15) NULL,
	[DepartmentName] [nvarchar](50) NULL,
	[Position] [nvarchar](50) NULL,
	[JoiningDate] [datetime] NULL,
	[PerformanceScore] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PerformanceReview]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerformanceReview](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[ReviewDate] [datetime] NOT NULL,
	[ReviewScore] [int] NOT NULL,
	[ReviewNotes] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmployeeListView_AllFilters]    Script Date: 1/8/2025 2:35:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeListView_AllFilters] ON [dbo].[EmployeeListView]
(
	[Name] ASC,
	[Position] ASC,
	[DepartmentName] ASC,
	[PerformanceScore] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmployeeListView_DepartmentName]    Script Date: 1/8/2025 2:35:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeListView_DepartmentName] ON [dbo].[EmployeeListView]
(
	[DepartmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmployeeListView_Name]    Script Date: 1/8/2025 2:35:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeListView_Name] ON [dbo].[EmployeeListView]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_EmployeeListView_PerformanceScore_Range]    Script Date: 1/8/2025 2:35:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeListView_PerformanceScore_Range] ON [dbo].[EmployeeListView]
(
	[PerformanceScore] ASC
)
WHERE ([PerformanceScore]>=(1) AND [PerformanceScore]<=(10))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmployeeListView_Position]    Script Date: 1/8/2025 2:35:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeListView_Position] ON [dbo].[EmployeeListView]
(
	[Position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PerformanceReview_EmployeeId_ReviewDate]    Script Date: 1/8/2025 2:35:51 PM ******/
CREATE NONCLUSTERED INDEX [IX_PerformanceReview_EmployeeId_ReviewDate] ON [dbo].[PerformanceReview]
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Departments]  WITH NOCHECK ADD  CONSTRAINT [FK_Departments_Employee] FOREIGN KEY([ManagerId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Departments] NOCHECK CONSTRAINT [FK_Departments_Employee]
GO
ALTER TABLE [dbo].[Employee]  WITH NOCHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
GO
ALTER TABLE [dbo].[Employee] NOCHECK CONSTRAINT [FK_Employee_Department]
GO
ALTER TABLE [dbo].[PerformanceReview]  WITH NOCHECK ADD  CONSTRAINT [FK_PerformanceReview_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[PerformanceReview] NOCHECK CONSTRAINT [FK_PerformanceReview_Employee]
GO
/****** Object:  StoredProcedure [dbo].[AddEmployeeToEmployeeListView]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddEmployeeToEmployeeListView]
    @EmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert the new employee's data into EmployeeListView
    INSERT INTO EmployeeListView (ID, [Name], Email, Phone, DepartmentName, Position, JoiningDate, PerformanceScore)
    SELECT 
        e.ID,
        e.Name,
        e.Email,
        e.Phone,
        d.DepartmentName AS DepartmentName,
        e.Position,
        e.JoiningDate,
        0
    FROM Employee e
    LEFT JOIN Departments d ON e.DepartmentID = d.Id
    WHERE e.ID = @EmployeeID
END;
GO
/****** Object:  StoredProcedure [dbo].[AddPerformanceReview]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddPerformanceReview]
    @EmployeeId INT,
    @ReviewDate DATETIME,
    @ReviewScore INT,
    @ReviewNotes VARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Insert the new performance review
    INSERT INTO PerformanceReview (EmployeeId, ReviewDate, ReviewScore, ReviewNotes)
    VALUES (@EmployeeId, @ReviewDate, @ReviewScore, @ReviewNotes);

    -- Step 2: Recalculate the average score for the employee
    DECLARE @NewAverageScore DECIMAL(18, 2);

    SELECT @NewAverageScore = AVG(CAST(ReviewScore AS DECIMAL(18, 2)))
    FROM PerformanceReview
    WHERE EmployeeId = @EmployeeId;

    -- Step 3: Update the AverageScore column in the Employee table
    UPDATE Employee
    SET AverageScore = @NewAverageScore
    WHERE Id = @EmployeeId;

	-- Step 3: Update the AverageScore column in the Employee table
    UPDATE EmployeeListView
    SET PerformanceScore = @NewAverageScore
    WHERE Id = @EmployeeId;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployeeInEmployeeListView]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteEmployeeInEmployeeListView]
    @EmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE EmployeeListView WHERE Id = @EmployeeID;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateEmployee]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CreateEmployee]
    @Name NVARCHAR(100),
    @Email NVARCHAR(255),
    @Phone NVARCHAR(100),
    @DepartmentId INT,
    @Position NVARCHAR(100),
    @JoiningDate DATETIME,
    @Status BIT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert the employee record
        INSERT INTO Employee ([Name], Email, Phone, DepartmentId, Position, JoiningDate, [Status])
        VALUES (@Name, @Email, @Phone, @DepartmentId, @Position, @JoiningDate, @Status);

        -- Get the ID of the newly inserted employee
        DECLARE @EmployeeId INT = SCOPE_IDENTITY();

        -- Call the second stored procedure to add the employee to EmployeeListView
        EXEC dbo.AddEmployeeToEmployeeListView @EmployeeId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Re-throw the error for debugging or logging purposes
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteEmployee]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteEmployee]
    @Id INT                -- Employee Id to identify the record to update
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Employee
        SET [Status] = 0
        WHERE Id = @Id;

		EXEC dbo.DeleteEmployeeInEmployeeListView @Id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Re-throw the error for debugging or logging purposes
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_FilterEmployeeListView]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_FilterEmployeeListView]
    @Name NVARCHAR(100) = NULL,          -- Optional: Search by Name
    @Position NVARCHAR(100) = NULL,      -- Optional: Search by Position
    @DepartmentName NVARCHAR(100) = NULL,   -- Optional: Filter by Department
    @MinScore DECIMAL(18, 2) = NULL,     -- Optional: Filter by minimum score
    @MaxScore DECIMAL(18, 2) = NULL      -- Optional: Filter by maximum score
AS
BEGIN
    SET NOCOUNT ON;

    -- Start the query
    SELECT 
        e.ID AS Id,
        e.[Name],
        e.Email,
        e.Phone,
        e.DepartmentName,
        e.Position,
        e.JoiningDate,
        e.PerformanceScore
    FROM EmployeeListView e
    WHERE 
        (@Name IS NULL OR e.Name LIKE '%' + @Name + '%')        -- Filter by Name if provided
        AND (@Position IS NULL OR e.Position LIKE '%' + @Position + '%')  -- Filter by Position if provided
        AND (@DepartmentName IS NULL OR e.DepartmentName LIKE @DepartmentName)  -- Filter by Department if provided
        AND (@MinScore IS NULL OR e.PerformanceScore >= @MinScore)   -- Filter by MinScore if provided
        AND (@MaxScore IS NULL OR e.PerformanceScore <= @MaxScore)   -- Filter by MaxScore if provided
    ORDER BY e.Id DESC;  
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetEmployees]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetEmployees]
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate the offset
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    -- Select paginated rows
    SELECT 
        ID AS Id,
        [Name],
        Email,
        Phone,
        DepartmentName,
        Position,
        JoiningDate,
        PerformanceScore
    FROM EmployeeListView
    ORDER BY Id DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPerformanceReviews]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetPerformanceReviews]
    @EmployeeId INT,
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate the offset
    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    -- Select paginated rows
    SELECT 
        Id,
        EmployeeId,
        ReviewDate,
        ReviewScore,
        ReviewNotes
    FROM PerformanceReview
    WHERE EmployeeId = @EmployeeId
    ORDER BY Id DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAverageDepartmentScore]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateAverageDepartmentScore]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        TRUNCATE TABLE DepartmentAvgScores;

        INSERT INTO DepartmentAvgScores (DepartmentId, DepartmentName, AvgScore)
        SELECT 
            e.DepartmentId,
            d.DepartmentName,
            AVG(e.AverageScore) AS AvgReviewScore
        FROM 
            Employee e
        JOIN 
            Departments d ON d.Id = e.DepartmentId
		WHERE 
            e.Status = 1 AND e.AverageScore IS NOT NULL
        GROUP BY 
            e.DepartmentId, d.DepartmentName;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateEmployee]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateEmployee]
    @Id INT,                -- Employee Id to identify the record to update
    @Name NVARCHAR(100),
    @Email NVARCHAR(255),
    @Phone NVARCHAR(100),
    @DepartmentId INT,
    @Position NVARCHAR(100),
    @JoiningDate DATETIME,
    @Status BIT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Employee
        SET 
            Name = @Name,
            Email = @Email,
            Phone = @Phone,
            DepartmentId = @DepartmentId,
            Position = @Position,
            JoiningDate = @JoiningDate,
            [Status] = @Status
        WHERE Id = @Id;

		EXEC dbo.UpdateEmployeeInEmployeeListView @Id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Re-throw the error for debugging or logging purposes
        THROW;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployeeInEmployeeListView]    Script Date: 1/8/2025 2:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEmployeeInEmployeeListView]
    @EmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the employee's data in EmployeeListView
    UPDATE EmployeeListView
    SET 
        [Name] = e.Name,
        Email = e.Email,
        Phone = e.Phone,
        DepartmentName = d.DepartmentName,
        Position = e.Position,
        JoiningDate = e.JoiningDate,
        PerformanceScore = ISNULL(e.AverageScore, 0)
    FROM EmployeeListView elv
    INNER JOIN Employee e ON elv.ID = e.ID
    LEFT JOIN Departments d ON e.DepartmentID = d.Id
    WHERE e.ID = @EmployeeID
END;
GO
USE [master]
GO
ALTER DATABASE [Employee] SET  READ_WRITE 
GO
