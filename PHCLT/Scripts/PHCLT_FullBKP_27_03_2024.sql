USE [master]
GO
/****** Object:  Database [Phclt]    Script Date: 27-03-2024 14:02:31 ******/
CREATE DATABASE [Phclt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Phclt', FILENAME = N'E:\Database\Phclt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Phclt_log', FILENAME = N'E:\Database\Phclt_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Phclt] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Phclt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Phclt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Phclt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Phclt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Phclt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Phclt] SET ARITHABORT OFF 
GO
ALTER DATABASE [Phclt] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Phclt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Phclt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Phclt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Phclt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Phclt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Phclt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Phclt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Phclt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Phclt] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Phclt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Phclt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Phclt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Phclt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Phclt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Phclt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Phclt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Phclt] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Phclt] SET  MULTI_USER 
GO
ALTER DATABASE [Phclt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Phclt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Phclt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Phclt] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Phclt] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Phclt] SET QUERY_STORE = OFF
GO
USE [Phclt]
GO
/****** Object:  User [advsys]    Script Date: 27-03-2024 14:02:32 ******/
CREATE USER [advsys] FOR LOGIN [advsys] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[DistrictMaster]    Script Date: 27-03-2024 14:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DistrictMaster](
	[Id] [int] NULL,
	[DisName] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[phcdetail]    Script Date: 27-03-2024 14:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phcdetail](
	[phcid] [int] NOT NULL,
	[phcname] [nvarchar](500) NULL,
	[userid] [int] NOT NULL,
	[disid] [int] NULL,
	[talukaid] [int] NULL,
	[phccode] [nvarchar](500) NULL,
	[phcPopulation] [numeric](18, 2) NULL,
 CONSTRAINT [PK_phcdetail_1] PRIMARY KEY CLUSTERED 
(
	[phcid] ASC,
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCenterDetails]    Script Date: 27-03-2024 14:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCenterDetails](
	[SubCenterDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[PHCId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[SubCenterName] [nvarchar](max) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedAt] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubCenterDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TalukaMastar]    Script Date: 27-03-2024 14:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TalukaMastar](
	[Id] [int] NULL,
	[Talukaname] [nvarchar](500) NULL,
	[Distid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 27-03-2024 14:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMaster](
	[Userid] [int] NULL,
	[UserName] [nvarchar](500) NULL,
	[Password] [nvarchar](500) NULL,
	[Compid] [int] NULL,
	[UsesFullname] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VillageMaster]    Script Date: 27-03-2024 14:02:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VillageMaster](
	[VillageMasterId] [int] IDENTITY(1,1) NOT NULL,
	[PHCId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[VillageName] [nvarchar](max) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedAt] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VillageMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (1, N'Kachchh')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (2, N'BanasKantha')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (3, N'Patan')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (4, N'Mahesana')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (5, N'SabarKantha')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (6, N'Gandhinagar')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (7, N'Ahmadabad')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (8, N'Surendranagar')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (9, N'Rajkot')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (10, N'Jamnagar')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (11, N'Porbandar')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (12, N'Junagadh')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (13, N'Amreli')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (14, N'Bhavnagar')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (15, N'Anand')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (16, N'Kheda')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (17, N'PanchMahals')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (18, N'Dohad')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (19, N'Vadodara')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (20, N'Narmada')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (21, N'Bharuch')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (22, N'The Dangs')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (23, N'Navsari')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (24, N'Valsad')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (25, N'Surat')
INSERT [dbo].[DistrictMaster] ([Id], [DisName]) VALUES (26, N'Tapi')
GO
INSERT [dbo].[phcdetail] ([phcid], [phcname], [userid], [disid], [talukaid], [phccode], [phcPopulation]) VALUES (1, N'NAV PHC', 1, 23, 201, N'12', CAST(20000.00 AS Numeric(18, 2)))
INSERT [dbo].[phcdetail] ([phcid], [phcname], [userid], [disid], [talukaid], [phccode], [phcPopulation]) VALUES (1, N'Karan Demo', 2, 24, 208, N'987', CAST(20000.00 AS Numeric(18, 2)))
INSERT [dbo].[phcdetail] ([phcid], [phcname], [userid], [disid], [talukaid], [phccode], [phcPopulation]) VALUES (2, N'AND PHC', 1, 15, 140, N'987', CAST(2000.00 AS Numeric(18, 2)))
INSERT [dbo].[phcdetail] ([phcid], [phcname], [userid], [disid], [talukaid], [phccode], [phcPopulation]) VALUES (2, N'VAPI PHC', 2, 24, 210, N'123', CAST(20000.00 AS Numeric(18, 2)))
INSERT [dbo].[phcdetail] ([phcid], [phcname], [userid], [disid], [talukaid], [phccode], [phcPopulation]) VALUES (3, N'JAM PHC', 1, 10, 94, N'25', CAST(6500.00 AS Numeric(18, 2)))
INSERT [dbo].[phcdetail] ([phcid], [phcname], [userid], [disid], [talukaid], [phccode], [phcPopulation]) VALUES (3, N'DHRAM PHC', 2, 24, 207, N'12', CAST(2500.00 AS Numeric(18, 2)))
INSERT [dbo].[phcdetail] ([phcid], [phcname], [userid], [disid], [talukaid], [phccode], [phcPopulation]) VALUES (4, N'SD PHC', 1, 8, 75, N'456', CAST(7800.00 AS Numeric(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[SubCenterDetails] ON 

INSERT [dbo].[SubCenterDetails] ([SubCenterDetailsId], [PHCId], [UserId], [SubCenterName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (9, 4, 1, N'SD Sub', 1, CAST(N'2024-03-26T10:01:51.000' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[SubCenterDetails] ([SubCenterDetailsId], [PHCId], [UserId], [SubCenterName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (10, 1, 1, N'Demo PHC Sub ', 1, CAST(N'2024-03-26T10:02:15.000' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[SubCenterDetails] ([SubCenterDetailsId], [PHCId], [UserId], [SubCenterName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (11, 1, 2, N'KARAN PHC SUB', 2, CAST(N'2024-03-26T10:08:56.000' AS DateTime), 2, CAST(N'2024-03-26T10:39:01.000' AS DateTime), 1)
INSERT [dbo].[SubCenterDetails] ([SubCenterDetailsId], [PHCId], [UserId], [SubCenterName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (12, 2, 2, N'VAPI PHC SUB', 2, CAST(N'2024-03-26T10:09:13.000' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[SubCenterDetails] ([SubCenterDetailsId], [PHCId], [UserId], [SubCenterName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (13, 3, 2, N'DH PHC SUB', 2, CAST(N'2024-03-26T10:10:07.000' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[SubCenterDetails] ([SubCenterDetailsId], [PHCId], [UserId], [SubCenterName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (14, 2, 2, N'Daman PHC Sub', 2, CAST(N'2024-03-26T10:12:40.000' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[SubCenterDetails] OFF
GO
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (1, N'Lakhpat', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (2, N'Rapar', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (3, N'Bhachau', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (4, N'Anjar', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (5, N'Bhuj', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (6, N'Nakhatrana', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (7, N'Abdasa', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (8, N'Mandvi', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (9, N'Mundra', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (10, N'Gandhidham', 1)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (11, N'Vav', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (12, N'Tharad', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (13, N'Dhanera', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (14, N'Dantiwada', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (15, N'Amirgadh', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (16, N'Danta', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (17, N'Vadgam', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (18, N'Palanpur', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (19, N'Deesa', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (20, N'Deodar', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (21, N'Bhabhar', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (22, N'Kankrej', 2)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (23, N'Santalpur', 3)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (24, N'Radhanpur', 3)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (25, N'Sidhpur', 3)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (26, N'Patan', 3)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (27, N'Harij', 3)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (28, N'Sarni', 3)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (29, N'Chanasma', 3)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (30, N'Satlasana', 4)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (31, N'Kheralu', 4)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (32, N'Unjha', 4)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (33, N'Visnagar', 4)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (34, N'Vadnagar', 4)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (35, N'Vijapur', 4)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (36, N'Mahesana', 4)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (37, N'Becharaji', 4)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (38, N'Kadi', 4)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (39, N'Khedbrahma', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (40, N'Vijaynagar', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (41, N'Vadali', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (42, N'ldar', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (43, N'Bhiloda', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (44, N'Meghraj', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (45, N'Himatnagar', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (46, N'Prantij', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (47, N'Talod', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (48, N'Modasa', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (49, N'Dhansura', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (50, N'Malpur', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (51, N'Bayad', 5)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (52, N'Kalal', 6)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (53, N'Mansa', 6)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (54, N'Gandhinagar', 6)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (55, N'Dehgam', 6)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (56, N'Mandal', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (57, N'Detroj-Rampura', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (58, N'Viramgam', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (59, N'Sanand', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (60, N'Ahmadabad City', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (61, N'Daskroi', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (62, N'Dholka', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (63, N'Bavla', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (64, N'Ranpur', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (65, N'Barwala', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (66, N'Dhandhuka', 7)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (67, N'Halvad', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (68, N'Dhrangadhra', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (69, N'Dasada', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (70, N'Lakhtar', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (71, N'Wadhwan', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (72, N'Muli', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (73, N'Chotila', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (74, N'Sayla', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (75, N'Chuda', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (76, N'Limbdi', 8)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (77, N'Maliya', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (78, N'Morvi', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (79, N'Tankara', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (80, N'Wankaner', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (81, N'Paddhari', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (82, N'Rajkot', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (83, N'Lodhika', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (84, N'KotdaSangani', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (85, N'Jasdan', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (86, N'Gondal', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (87, N'Jamkandorna', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (88, N'Upleta', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (89, N'Dhoraji', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (90, N'Jetpur', 9)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (91, N'Okhamandal', 10)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (92, N'Khambhalia', 10)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (93, N'Jamnagar', 10)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (94, N'Jodiya', 10)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (95, N'Dhrol', 10)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (96, N'Kalavad', 10)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (97, N'Lalpur', 10)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (98, N'Kalyanpur', 10)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (99, N'Bhanvad', 10)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (100, N'Jamjodhpur', 10)
GO
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (101, N'Porbandar', 11)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (102, N'Ranavav', 11)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (103, N'Kutiyana', 11)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (104, N'Manavadar', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (105, N'Vanthali', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (106, N'Junagadh', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (107, N'Bhesan', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (108, N'Visavadar', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (109, N'Mendarda', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (110, N'Keshod', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (111, N'Mangrol', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (112, N'Malia', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (113, N'Talala', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (114, N'Patan-Veraval', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (115, N'Sutrapada', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (116, N'Kodinar', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (117, N'Una', 12)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (118, N'KunkavavVadia', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (119, N'Babra', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (120, N'Lathi', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (121, N'Lilia', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (122, N'Amreli', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (123, N'Bagasara', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (124, N'Dhari', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (125, N'SavarKundla', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (126, N'Khambha', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (127, N'Jafrabad', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (128, N'Rajula', 13)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (129, N'Botad', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (130, N'Vallabhipur', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (131, N'Gadhada', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (132, N'Umrala', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (133, N'Bhavnagar', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (134, N'Ghogha', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (135, N'Sihor', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (136, N'Gariadhar', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (137, N'Palitana', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (138, N'Talaja', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (139, N'Mahuva', 14)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (140, N'Tarapur', 15)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (141, N'Sojitra', 15)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (142, N'Umreth', 15)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (143, N'Anand', 15)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (144, N'Petlad', 15)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (145, N'Khambhat', 15)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (146, N'Borsad', 15)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (147, N'Anklav', 15)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (148, N'Kapadvanj', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (149, N'Virpur', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (150, N'Balasinor', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (151, N'Kathlal', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (152, N'Mehmedabad', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (153, N'Kheda', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (154, N'Matar', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (155, N'Nadiad', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (156, N'Mahudha', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (157, N'Thasra', 16)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (158, N'Khanpur', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (159, N'Kadana', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (160, N'Santrampur', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (161, N'Lunawada', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (162, N'Shehera', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (163, N'Morwa (Hadaf)', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (164, N'Godhra', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (165, N'Kalal', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (166, N'Ghoghamba', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (167, N'Halal', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (168, N'Jambughoda', 17)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (169, N'Fatepura', 18)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (170, N'Jhalod', 18)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (171, N'Limkheda', 18)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (172, N'Dohad', 18)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (173, N'Garbada', 18)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (174, N'Devgadbaria', 18)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (175, N'Dhanpur', 18)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (176, N'Savli', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (177, N'Vadodara', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (178, N'Vaghodia', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (179, N'JetpurPavi', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (180, N'Chhota Udaipur', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (181, N'Kavant', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (182, N'Nasvadi', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (183, N'Sankheda', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (184, N'Dabhoi', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (185, N'Padra', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (186, N'Karjan', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (187, N'Sinor', 19)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (188, N'Tilakwada', 20)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (189, N'Nandod', 20)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (190, N'Dediapada', 20)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (191, N'Sagbara', 20)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (192, N'Jambusar', 21)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (193, N'Amod', 21)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (194, N'Vagra', 21)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (195, N'Bharuch', 21)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (196, N'Jhagadia', 21)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (197, N'Anklesvar', 21)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (198, N'Hansot', 21)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (199, N'Valia', 21)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (200, N'Dangs', 22)
GO
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (201, N'Navsari', 23)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (202, N'Jalalpore', 23)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (203, N'Gandevi', 23)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (204, N'Chikhli', 23)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (205, N'Bansda', 23)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (206, N'Valsad', 24)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (207, N'Dharampur', 24)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (208, N'Pardi', 24)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (209, N'Kaprada', 24)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (210, N'Umbergaon', 24)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (211, N'Olpad', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (212, N'Mangrol', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (213, N'Umarpada', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (214, N'Mandvi', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (215, N'Kamrej', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (216, N'Surat City', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (217, N'Chorasi', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (218, N'Palsana', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (219, N'Bardoli', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (220, N'Mahuva', 25)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (221, N'Nizar', 26)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (222, N'Uchchhal', 26)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (223, N'Songadh', 26)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (224, N'Vyara', 26)
INSERT [dbo].[TalukaMastar] ([Id], [Talukaname], [Distid]) VALUES (225, N'Valod', 26)
GO
INSERT [dbo].[UserMaster] ([Userid], [UserName], [Password], [Compid], [UsesFullname]) VALUES (1, N'9512875983', N'omsai', 1, N'Dharmisthakumari Mahendrabhai Patel')
INSERT [dbo].[UserMaster] ([Userid], [UserName], [Password], [Compid], [UsesFullname]) VALUES (2, N'7041089989', N'omsai', 1, N'Karan Rajgor')
GO
SET IDENTITY_INSERT [dbo].[VillageMaster] ON 

INSERT [dbo].[VillageMaster] ([VillageMasterId], [PHCId], [UserId], [VillageName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (1, 3, 2, N'Dharam Village', 2, CAST(N'2024-03-26T12:21:38.000' AS DateTime), 2, CAST(N'2024-03-26T12:27:08.000' AS DateTime), 1)
INSERT [dbo].[VillageMaster] ([VillageMasterId], [PHCId], [UserId], [VillageName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (2, 1, 2, N'Udvada Gam', 2, CAST(N'2024-03-26T12:27:31.000' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[VillageMaster] ([VillageMasterId], [PHCId], [UserId], [VillageName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (4, 3, 1, N'Jam village edit', 1, CAST(N'2024-03-26T12:29:37.000' AS DateTime), 1, CAST(N'2024-03-26T12:30:16.000' AS DateTime), 1)
INSERT [dbo].[VillageMaster] ([VillageMasterId], [PHCId], [UserId], [VillageName], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [IsActive]) VALUES (6, 4, 1, N'some new phc in village', 1, CAST(N'2024-03-26T12:30:02.000' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[VillageMaster] OFF
GO
USE [master]
GO
ALTER DATABASE [Phclt] SET  READ_WRITE 
GO
