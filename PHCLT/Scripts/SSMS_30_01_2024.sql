USE [SSMS]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 30-01-2024 19:14:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[BrandId] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[BrandId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Brand] ON 

INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (1, N'Samsung', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (2, N'Xiaomi', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (3, N'Vivo', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (4, N'Realme', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (5, N'OPPO', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (6, N'Apple', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (7, N'Huawei', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (8, N'Dell Technologies', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (9, N'LG Group', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (10, N'Sony', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (11, N'Midea', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (12, N'Panasonic', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (13, N'HP', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (14, N'Canon', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (15, N'Xbox', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (16, N'Gree', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (17, N'PlayStation', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (18, N'Haier', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (19, N'Xiaomi', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (20, N'Hikvision', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (21, N'Lenovo', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (22, N'Goertek', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (23, N'BOE', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (24, N'Mitsubishi Electric', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (25, N'Nintendo', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (26, N'Techtronic Industries', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (27, N'Western Digital', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (28, N'ZTE', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (29, N'Kyocera', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (30, N'Sharp', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (31, N'Quanta Computer', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (32, N'Toshiba', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (33, N'Motorola Solutions', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (34, N'OnePlus', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (35, N'Harman', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (36, N'Fujifilm', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (37, N'ASUS', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (38, N'Whirlpool', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (39, N'Wii', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (40, N'Logitech', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (41, N'Seb', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (42, N'Arçelik', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (43, N'Trimble Navigation', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (44, N'Pegatron', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (45, N'Transsion', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (46, N'Sandisk', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (47, N'TCL CSOT', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (48, N'Lens Technology', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (49, N'Coway', 1)
INSERT [dbo].[Brand] ([BrandId], [BrandName], [IsActive]) VALUES (50, N'Brother Industries', 1)
SET IDENTITY_INSERT [dbo].[Brand] OFF
GO


alter table Complaints
add ComplaintNo nvarchar(50) null

alter table Complaints
add BrandId int null


alter table Complaints
add SolutionBy nvarchar(50) null

alter table Complaints
add SolutionDate DateTime null

