USE [master]
GO
/****** Object:  Database [SSMS]    Script Date: 08-01-2024 18:52:42 ******/
CREATE DATABASE [SSMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SSMS', FILENAME = N'E:\Database\SSMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SSMS_log', FILENAME = N'E:\Database\SSMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SSMS] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SSMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SSMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SSMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SSMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SSMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SSMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [SSMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SSMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SSMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SSMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SSMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SSMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SSMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SSMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SSMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SSMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SSMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SSMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SSMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SSMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SSMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SSMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SSMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SSMS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SSMS] SET  MULTI_USER 
GO
ALTER DATABASE [SSMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SSMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SSMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SSMS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SSMS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SSMS] SET QUERY_STORE = OFF
GO
USE [SSMS]
GO
/****** Object:  User [advsys]    Script Date: 08-01-2024 18:52:42 ******/
CREATE USER [advsys] FOR LOGIN [advsys] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[BankMaster]    Script Date: 08-01-2024 18:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankMaster](
	[BankId] [int] IDENTITY(1,1) NOT NULL,
	[BankName] [nchar](200) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_BankMaster] PRIMARY KEY CLUSTERED 
(
	[BankId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerMaster]    Script Date: 08-01-2024 18:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerMaster](
	[CustomerId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerCast] [nvarchar](max) NULL,
	[CustomerName] [nvarchar](max) NULL,
	[CustomerAddress] [nvarchar](max) NULL,
	[CADistrict] [int] NULL,
	[CATaluka] [int] NULL,
	[PermanentCustAddress] [nvarchar](max) NULL,
	[CustBusinessAddress] [nvarchar](max) NULL,
	[MobNo] [nvarchar](max) NULL,
	[WhatsAppNo] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[JoinDate] [date] NULL,
	[ProfilePic] [nvarchar](max) NULL,
	[AdharCardImage] [nvarchar](max) NULL,
	[PanCardImage] [nvarchar](max) NULL,
	[CouponCode] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[ESign] [nvarchar](max) NULL,
	[PRTaluka] [int] NULL,
	[PRDistrict] [int] NULL,
	[MobNo2] [nvarchar](50) NULL,
	[SameAddress] [bit] NULL,
 CONSTRAINT [PK_CustomerMaster] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DistrictMaster]    Script Date: 08-01-2024 18:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DistrictMaster](
	[Id] [int] NULL,
	[DisName] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMaster]    Script Date: 08-01-2024 18:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMaster](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[ReceiptNo] [bigint] NULL,
	[ReceiptDate] [datetime] NULL,
	[CustomerId] [int] NULL,
	[PaymentMode] [nvarchar](50) NULL,
	[BankId] [int] NULL,
	[Amount] [money] NULL,
	[Remark] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PaymentMaster] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TalukaMastar]    Script Date: 08-01-2024 18:52:42 ******/
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
/****** Object:  Table [dbo].[UserMaster]    Script Date: 08-01-2024 18:52:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMaster](
	[Userid] [int] NULL,
	[UserName] [nvarchar](500) NULL,
	[Password] [nvarchar](500) NULL,
	[Compid] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BankMaster] ON 

INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (1, N'Bank of Baroda                                                                                                                                                                                          ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (2, N'Bank of India                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (3, N'Bank of Maharashtra                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (4, N'Canara Bank                                                                                                                                                                                             ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (5, N'Central Bank of India                                                                                                                                                                                   ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (6, N'Indian Bank                                                                                                                                                                                             ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (7, N'Indian Overseas Bank                                                                                                                                                                                    ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (8, N'Punjab & Sind Bank                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (9, N'Punjab National Bank                                                                                                                                                                                    ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (10, N'State Bank of India                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (11, N'UCO Bank                                                                                                                                                                                                ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (12, N'Union Bank of India                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (13, N'Axis Bank Ltd.                                                                                                                                                                                          ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (14, N'Bandhan Bank Ltd.                                                                                                                                                                                       ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (15, N'CSB Bank Ltd.                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (16, N'City Union Bank Ltd.                                                                                                                                                                                    ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (17, N'DCB Bank Ltd.                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (18, N'Dhanlaxmi Bank Ltd.                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (19, N'Federal Bank Ltd.                                                                                                                                                                                       ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (20, N'HDFC Bank Ltd                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (21, N'ICICI Bank Ltd.                                                                                                                                                                                         ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (22, N'Induslnd Bank Ltd                                                                                                                                                                                       ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (23, N'IDFC First Bank Ltd.                                                                                                                                                                                    ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (24, N'Jammu & Kashmir Bank Ltd.                                                                                                                                                                               ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (25, N'Karnataka Bank Ltd.                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (26, N'Karur Vysya Bank Ltd.                                                                                                                                                                                   ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (27, N'Kotak Mahindra Bank Ltd                                                                                                                                                                                 ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (28, N'Nainital Bank Ltd.                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (29, N'RBL Bank Ltd.                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (30, N'South Indian Bank Ltd.                                                                                                                                                                                  ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (31, N'Tamilnad Mercantile Bank Ltd.                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (32, N'YES Bank Ltd.                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (33, N'IDBI Bank Ltd.                                                                                                                                                                                          ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (34, N'Au Small Finance Bank Limited                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (35, N'Capital Small Finance Bank Limited                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (36, N'Equitas Small Finance Bank Limited                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (37, N'Suryoday Small Finance Bank Limited                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (38, N'Ujjivan Small Finance Bank Limited                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (39, N'Utkarsh Small Finance Bank Limited                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (40, N'ESAF Small Finance Bank Limited                                                                                                                                                                         ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (41, N'Fincare Small Finance Bank Limited                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (42, N'Jana Small Finance Bank Limited                                                                                                                                                                         ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (43, N'North East Small Finance Bank Limited                                                                                                                                                                   ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (44, N'Shivalik Small Finance Bank Limited                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (45, N'Unity Small Finance Bank Limited                                                                                                                                                                        ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (46, N'India Post Payments Bank Limited                                                                                                                                                                        ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (47, N'Fino Payments Bank Limited                                                                                                                                                                              ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (48, N'Paytm Payments Bank Limited                                                                                                                                                                             ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (49, N'Airtel Payments Bank Limited                                                                                                                                                                            ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (50, N'Andhra Pragathi Grameena Bank                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (51, N'Andhra Pradesh Grameena Vikas Bank                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (52, N'Arunachal Pradesh Rural Bank                                                                                                                                                                            ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (53, N'Aryavart Bank                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (54, N'Assam Gramin Vikash Bank                                                                                                                                                                                ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (55, N'Bangiya Gramin Vikas Bank                                                                                                                                                                               ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (56, N'Baroda Gujarat Gramin Bank                                                                                                                                                                              ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (57, N'Baroda Rajasthan Kshetriya Gramin Bank                                                                                                                                                                  ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (58, N'Baroda UP Bank                                                                                                                                                                                          ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (59, N'Chaitanya Godavari Grameena Bank                                                                                                                                                                        ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (60, N'Chhattisgarh Rajya Gramin Bank                                                                                                                                                                          ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (61, N'Dakshin Bihar Gramin Bank                                                                                                                                                                               ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (62, N'Ellaquai Dehati Bank                                                                                                                                                                                    ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (63, N'Himachal Pradesh Gramin Bank                                                                                                                                                                            ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (64, N'J&K Grameen Bank                                                                                                                                                                                        ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (65, N'Jharkhand Rajya Gramin Bank                                                                                                                                                                             ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (66, N'Karnataka Gramin Bank                                                                                                                                                                                   ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (67, N'Karnataka Vikas Grameena Bank                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (68, N'Kerala Gramin Bank                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (69, N'Madhya Pradesh Gramin Bank                                                                                                                                                                              ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (70, N'Madhyanchal Gramin Bank                                                                                                                                                                                 ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (71, N'Maharashtra Gramin Bank                                                                                                                                                                                 ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (72, N'Manipur Rural Bank                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (73, N'Meghalaya Rural Bank                                                                                                                                                                                    ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (74, N'Mizoram Rural Bank                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (75, N'Nagaland Rural Bank                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (76, N'Odisha Gramya Bank                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (77, N'Paschim Banga Gramin Bank                                                                                                                                                                               ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (78, N'Prathama UP Gramin Bank                                                                                                                                                                                 ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (79, N'Puduvai Bharathiar Grama Bank                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (80, N'Punjab Gramin Bank                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (81, N'Rajasthan Marudhara Gramin Bank                                                                                                                                                                         ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (82, N'Saptagiri Grameena Bank                                                                                                                                                                                 ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (83, N'Sarva Haryana Gramin Bank                                                                                                                                                                               ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (84, N'Saurashtra Gramin Bank                                                                                                                                                                                  ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (85, N'Tamil Nadu Grama Bank                                                                                                                                                                                   ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (86, N'Telangana Grameena Bank                                                                                                                                                                                 ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (87, N'Tripura Gramin Bank                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (88, N'Utkal Grameen bank                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (89, N'Uttar Bihar Gramin Bank                                                                                                                                                                                 ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (90, N'Uttarakhand Gramin Bank                                                                                                                                                                                 ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (91, N'Uttarbanga Kshetriya Gramin Bank                                                                                                                                                                        ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (92, N'Vidharbha Konkan Gramin Bank                                                                                                                                                                            ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (93, N'AB Bank Ltd.                                                                                                                                                                                            ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (94, N'Abu Dhabi Commercial Bank Ltd.                                                                                                                                                                          ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (95, N'American Express Banking Corporation                                                                                                                                                                    ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (96, N'Australia and New Zealand Banking Group Ltd.                                                                                                                                                            ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (97, N'Barclays Bank Plc.                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (98, N'Bank of America                                                                                                                                                                                         ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (99, N'Bank of Bahrain & Kuwait BSC                                                                                                                                                                            ', 1)
GO
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (100, N'Bank of Ceylon                                                                                                                                                                                          ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (101, N'Bank of China                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (102, N'Bank of Nova Scotia                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (103, N'BNP Paribas                                                                                                                                                                                             ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (104, N'Citibank N.A.                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (105, N'Cooperatieve Rabobank U.A.                                                                                                                                                                              ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (106, N'Credit Agricole Corporate & Investment Bank                                                                                                                                                             ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (107, N'Credit Suisse A.G                                                                                                                                                                                       ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (108, N'CTBC Bank Co., Ltd.                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (109, N'DBS Bank India Limited                                                                                                                                                                                  ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (110, N'Deutsche Bank                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (111, N'Doha Bank Q.P.S.C                                                                                                                                                                                       ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (112, N'Emirates Bank NBD                                                                                                                                                                                       ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (113, N'First Abu Dhabi Bank PJSC                                                                                                                                                                               ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (114, N'FirstRand Bank Ltd                                                                                                                                                                                      ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (115, N'HSBC Ltd                                                                                                                                                                                                ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (116, N'Industrial & Commercial Bank of China Ltd.                                                                                                                                                              ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (117, N'Industrial Bank of Korea                                                                                                                                                                                ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (118, N'J.P. Morgan Chase Bank N.A.                                                                                                                                                                             ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (119, N'JSC VTB Bank                                                                                                                                                                                            ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (120, N'KEB Hana Bank                                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (121, N'Kookmin Bank                                                                                                                                                                                            ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (122, N'Krung Thai Bank Public Co. Ltd.                                                                                                                                                                         ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (123, N'Mashreq Bank PSC                                                                                                                                                                                        ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (124, N'Mizuho& Bank Ltd.                                                                                                                                                                                       ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (125, N'MUFG Bank, Ltd.                                                                                                                                                                                         ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (126, N'NatWest Markets Plc                                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (127, N'PT Bank Maybank Indonesia TBK                                                                                                                                                                           ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (128, N'Qatar National Bank (Q.P.S.C.)                                                                                                                                                                          ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (129, N'Sberbank                                                                                                                                                                                                ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (130, N'SBM Bank (India) Limited                                                                                                                                                                                ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (131, N'Shinhan Bank                                                                                                                                                                                            ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (132, N'Societe Generale                                                                                                                                                                                        ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (133, N'Sonali Bank Ltd.                                                                                                                                                                                        ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (134, N'Standard Chartered Bank                                                                                                                                                                                 ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (135, N'Sumitomo Mitsui Banking Corporation                                                                                                                                                                     ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (136, N'United Overseas Bank Ltd                                                                                                                                                                                ', 1)
INSERT [dbo].[BankMaster] ([BankId], [BankName], [IsActive]) VALUES (137, N'Woori Bank                                                                                                                                                                                              ', 1)
SET IDENTITY_INSERT [dbo].[BankMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerMaster] ON 

INSERT [dbo].[CustomerMaster] ([CustomerId], [CustomerCast], [CustomerName], [CustomerAddress], [CADistrict], [CATaluka], [PermanentCustAddress], [CustBusinessAddress], [MobNo], [WhatsAppNo], [BirthDate], [JoinDate], [ProfilePic], [AdharCardImage], [PanCardImage], [CouponCode], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [ESign], [PRTaluka], [PRDistrict], [MobNo2], [SameAddress]) VALUES (7, N'Patel', N'Brij Patel demo', N'srsio;dhlglkrdhfghfgklhfl', 15, 140, N'srsiodhlglkrdhfghfgklhfl', N'srlgihlkdsfhdgsklhlllll', N'897897465486', N'897897465486', CAST(N'2023-12-29' AS Date), CAST(N'2023-12-30' AS Date), N'profilepic-20240107085315998.png', N'aadhar-card-20240107085315998.png', N'pan-card-20240107085315998.png', N'dlrgjdrlkgjdklrjtelrktjer,erjtherkjther', 1, CAST(N'2024-01-01T21:31:37.000' AS DateTime), N'System', CAST(N'2024-01-07T14:23:15.000' AS DateTime), N'System', N'', 57, 7, NULL, NULL)
INSERT [dbo].[CustomerMaster] ([CustomerId], [CustomerCast], [CustomerName], [CustomerAddress], [CADistrict], [CATaluka], [PermanentCustAddress], [CustBusinessAddress], [MobNo], [WhatsAppNo], [BirthDate], [JoinDate], [ProfilePic], [AdharCardImage], [PanCardImage], [CouponCode], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [ESign], [PRTaluka], [PRDistrict], [MobNo2], [SameAddress]) VALUES (8, N'Patel', N'Karan Patel', N'some new address for testing purope', 15, 140, N'some new address for testing purope', N'this si another address that used for permanent addesss', N'689746846848', N'689746846848', CAST(N'2024-01-12' AS Date), CAST(N'2024-01-18' AS Date), N'profilepic-20240107135847258.png', N'aadhar-card-20240107135847258.png', N'pan-card-20240107135847258.png', N'sd;fkjdsklfjd,sdfjshdfjk, this is t3esting for demo', 1, CAST(N'2024-01-02T20:36:48.000' AS DateTime), N'System', CAST(N'2024-01-07T19:28:48.000' AS DateTime), N'System', N'', 140, 15, N'9876854654', 1)
INSERT [dbo].[CustomerMaster] ([CustomerId], [CustomerCast], [CustomerName], [CustomerAddress], [CADistrict], [CATaluka], [PermanentCustAddress], [CustBusinessAddress], [MobNo], [WhatsAppNo], [BirthDate], [JoinDate], [ProfilePic], [AdharCardImage], [PanCardImage], [CouponCode], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [ESign], [PRTaluka], [PRDistrict], [MobNo2], [SameAddress]) VALUES (11, N'Patel', N'Brij', N'iukhjklk', 2, 13, N'khkjhkjhkj', N'jhgkjhklhl', N'689746846848', N'6546532132132', CAST(N'2024-01-18' AS Date), CAST(N'2024-01-05' AS Date), N'profilepic-20240107070419136.png', N'aadhar-card-20240107070419136.png', N'pan-card-20240107070419136.png', N'iuhiukjhkjl,uhoilokholk', 1, CAST(N'2024-01-07T12:34:19.000' AS DateTime), N'System', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'', N'', 143, 15, NULL, NULL)
INSERT [dbo].[CustomerMaster] ([CustomerId], [CustomerCast], [CustomerName], [CustomerAddress], [CADistrict], [CATaluka], [PermanentCustAddress], [CustBusinessAddress], [MobNo], [WhatsAppNo], [BirthDate], [JoinDate], [ProfilePic], [AdharCardImage], [PanCardImage], [CouponCode], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [ESign], [PRTaluka], [PRDistrict], [MobNo2], [SameAddress]) VALUES (18, N'Patel', N'Yash mukeshbhai', N'Tharad', 2, 12, N'Tharad', N'Om sai infotech ', N'9624402990', N'9624402990', CAST(N'1996-04-20' AS Date), CAST(N'2024-01-07' AS Date), N'profilepic-20240107085645887.png', N'aadhar-card-20240107085645887.png', N'pan-card-20240107085645887.png', N'987,225', 1, CAST(N'2024-01-07T14:26:45.000' AS DateTime), N'System', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'', N'', 12, 2, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CustomerMaster] OFF
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
SET IDENTITY_INSERT [dbo].[PaymentMaster] ON 

INSERT [dbo].[PaymentMaster] ([PaymentId], [ReceiptNo], [ReceiptDate], [CustomerId], [PaymentMode], [BankId], [Amount], [Remark], [CreatedAt], [UpdatedAt], [CreatedBy], [UpdatedBy]) VALUES (1, 2, CAST(N'2024-01-07T00:00:00.000' AS DateTime), 7, N'cash', 0, 3000.0000, N'dfgdfg', CAST(N'2024-08-01T16:29:48.000' AS DateTime), CAST(N'2024-08-01T17:29:05.000' AS DateTime), N'System', N'System')
INSERT [dbo].[PaymentMaster] ([PaymentId], [ReceiptNo], [ReceiptDate], [CustomerId], [PaymentMode], [BankId], [Amount], [Remark], [CreatedAt], [UpdatedAt], [CreatedBy], [UpdatedBy]) VALUES (2, 3, CAST(N'2024-01-05T00:00:00.000' AS DateTime), 8, N'bank', 1, 4500.0000, N'testing remrkrr', CAST(N'2024-08-01T17:38:06.000' AS DateTime), CAST(N'2024-08-01T17:44:38.000' AS DateTime), N'System', N'System')
INSERT [dbo].[PaymentMaster] ([PaymentId], [ReceiptNo], [ReceiptDate], [CustomerId], [PaymentMode], [BankId], [Amount], [Remark], [CreatedAt], [UpdatedAt], [CreatedBy], [UpdatedBy]) VALUES (4, 4, CAST(N'2024-01-08T00:00:00.000' AS DateTime), 8, N'cash', 0, 5000.0000, N'new testing', CAST(N'2024-08-01T17:44:58.000' AS DateTime), NULL, N'System', NULL)
SET IDENTITY_INSERT [dbo].[PaymentMaster] OFF
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
INSERT [dbo].[UserMaster] ([Userid], [UserName], [Password], [Compid]) VALUES (1, N'omsai', N'omsai', 1)
GO
/****** Object:  Index [IX_PaymentMaster]    Script Date: 08-01-2024 18:52:42 ******/
ALTER TABLE [dbo].[PaymentMaster] ADD  CONSTRAINT [IX_PaymentMaster] UNIQUE NONCLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [SSMS] SET  READ_WRITE 
GO
