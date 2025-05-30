USE [SSMS]
GO
/****** Object:  Table [dbo].[Complaints]    Script Date: 26-01-2024 18:36:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Complaints](
	[ComplaintsId] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintDate] [date] NULL,
	[ComplaintAttended] [bit] NULL,
	[ComplaintAttendee] [nvarchar](100) NULL,
	[Problem] [nvarchar](max) NULL,
	[Solution] [nvarchar](max) NULL,
	[ComplaintImage] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[CustomersProductId] [int] NULL,
	[Product] [nvarchar](200) NULL,
	[ModelNo] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ComplaintsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Complaints] ON 

INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (7, CAST(N'2024-01-17' AS Date), 0, N'', N'having problem with my phone', N'', N'', 1, CAST(N'2024-01-26T16:40:28.000' AS DateTime), N'System', NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (9, CAST(N'2024-01-04' AS Date), 0, N'', N'sdasd', N'', N'', 1, CAST(N'2024-01-26T17:43:03.000' AS DateTime), N'System', NULL, NULL, 0, NULL, N'')
INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (10, CAST(N'2024-01-03' AS Date), 0, N'', N'some prob', N'', N'', 1, CAST(N'2024-01-26T17:45:48.000' AS DateTime), N'System', NULL, NULL, 0, NULL, N'')
INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (11, CAST(N'2024-01-01' AS Date), 0, N'', N'iluioui', N'', N'', 1, CAST(N'2024-01-26T17:47:21.000' AS DateTime), N'System', NULL, NULL, 0, NULL, N'de-02')
INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (12, CAST(N'2024-01-04' AS Date), 0, N'', N'fghjfghfg', N'', N'', 1, CAST(N'2024-01-26T17:48:46.000' AS DateTime), N'System', NULL, NULL, 1, NULL, N'pc-02')
INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (13, CAST(N'2024-01-12' AS Date), 0, N'', N'xdfgsdxfsdf', N'', N'', 1, CAST(N'2024-01-26T17:50:20.000' AS DateTime), N'System', NULL, NULL, 0, NULL, N'')
INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (14, CAST(N'2024-01-24' AS Date), 0, N'now attend has been joind', N'updated probmlem', N'', N'', 1, CAST(N'2024-01-26T17:54:07.000' AS DateTime), N'System', CAST(N'2024-01-26T18:28:32.000' AS DateTime), N'System', 2, NULL, N'de-02')
INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (15, CAST(N'2024-01-02' AS Date), 0, N'', N'zfzsdfsad', N'', N'complaint-20240126122437088.png', 1, CAST(N'2024-01-26T17:54:37.000' AS DateTime), N'System', NULL, NULL, 3, NULL, N'pc-02')
INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (16, CAST(N'2024-01-02' AS Date), 0, N'asdfasdas', N'gdsfsdz', N'', N'', 1, CAST(N'2024-01-26T17:55:10.000' AS DateTime), N'System', NULL, NULL, 2, NULL, N'sm-01')
INSERT [dbo].[Complaints] ([ComplaintsId], [ComplaintDate], [ComplaintAttended], [ComplaintAttendee], [Problem], [Solution], [ComplaintImage], [IsActive], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [CustomersProductId], [Product], [ModelNo]) VALUES (17, CAST(N'2024-01-03' AS Date), 0, N'', N'SDzasdsad', N'', N'', 1, CAST(N'2024-01-26T18:33:51.000' AS DateTime), N'System', NULL, NULL, 1, NULL, N'sm-01')
SET IDENTITY_INSERT [dbo].[Complaints] OFF
GO
