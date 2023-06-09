USE [master]
GO
/****** Object:  Database [OnlineShop]    Script Date: 4/16/2023 10:51:36 PM ******/
CREATE DATABASE [OnlineShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.EM_SQLSERVER\MSSQL\DATA\OnlineShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.EM_SQLSERVER\MSSQL\DATA\OnlineShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [OnlineShop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OnlineShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineShop] SET RECOVERY FULL 
GO
ALTER DATABASE [OnlineShop] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OnlineShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OnlineShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'OnlineShop', N'ON'
GO
ALTER DATABASE [OnlineShop] SET QUERY_STORE = ON
GO
ALTER DATABASE [OnlineShop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [OnlineShop]
GO
/****** Object:  Table [dbo].[Baskets]    Script Date: 4/16/2023 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Baskets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_Id] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
	[Count] [int] NOT NULL,
 CONSTRAINT [PK_Baskets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 4/16/2023 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[First_Name] [nvarchar](50) NOT NULL,
	[Last_Name] [nvarchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Factors]    Script Date: 4/16/2023 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Create_Date] [date] NOT NULL,
	[Total_Price] [int] NOT NULL,
	[Discount] [int] NOT NULL,
	[Customer_Id] [int] NOT NULL,
 CONSTRAINT [PK_Factors] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventories]    Script Date: 4/16/2023 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventories](
	[Inventory_Id] [int] IDENTITY(1,1) NOT NULL,
	[Product_Id] [int] NOT NULL,
	[Qty] [int] NOT NULL,
	[Enter_Time] [date] NOT NULL,
	[Exit_Time] [date] NULL,
 CONSTRAINT [PK_Inventories] PRIMARY KEY CLUSTERED 
(
	[Inventory_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Factor]    Script Date: 4/16/2023 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Factor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Factor_Id] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
	[Qty] [int] NOT NULL,
 CONSTRAINT [PK_Product_Factor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 4/16/2023 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Product_Name] [nvarchar](50) NOT NULL,
	[Unit_Price] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [First_Name], [Last_Name], [Password], [Email]) VALUES (1, N'عماد', N'افراسیابی', N'EM123', N'emadafrasiyabi@gmail.com')
INSERT [dbo].[Customers] ([Id], [First_Name], [Last_Name], [Password], [Email]) VALUES (2, N'مهدی', N'شرفی', N'MA123', N'mahdisharafi@gmail.com')
INSERT [dbo].[Customers] ([Id], [First_Name], [Last_Name], [Password], [Email]) VALUES (3, N'مینا', N'سلطانی', N'MI123', N'minasoltani@gmail.com')
INSERT [dbo].[Customers] ([Id], [First_Name], [Last_Name], [Password], [Email]) VALUES (10, N'نادر', N'رمضانی', N'MN123', N'naderramezani@gmail.com')
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Factors] ON 

INSERT [dbo].[Factors] ([Id], [Create_Date], [Total_Price], [Discount], [Customer_Id]) VALUES (1, CAST(N'2023-04-12' AS Date), 62400, 20, 1)
INSERT [dbo].[Factors] ([Id], [Create_Date], [Total_Price], [Discount], [Customer_Id]) VALUES (2, CAST(N'2023-01-25' AS Date), 52250, 10, 2)
INSERT [dbo].[Factors] ([Id], [Create_Date], [Total_Price], [Discount], [Customer_Id]) VALUES (3, CAST(N'2022-08-19' AS Date), 4000, 20, 1)
INSERT [dbo].[Factors] ([Id], [Create_Date], [Total_Price], [Discount], [Customer_Id]) VALUES (5, CAST(N'2023-04-16' AS Date), 76300, 0, 1)
INSERT [dbo].[Factors] ([Id], [Create_Date], [Total_Price], [Discount], [Customer_Id]) VALUES (12, CAST(N'2023-04-16' AS Date), 341500, 0, 1)
INSERT [dbo].[Factors] ([Id], [Create_Date], [Total_Price], [Discount], [Customer_Id]) VALUES (13, CAST(N'2023-04-16' AS Date), 92100, 0, 1)
SET IDENTITY_INSERT [dbo].[Factors] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventories] ON 

INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (1, 1, 33, CAST(N'2023-01-01' AS Date), CAST(N'2023-02-18' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (2, 2, 8, CAST(N'2023-01-01' AS Date), CAST(N'2023-01-04' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (3, 3, 22, CAST(N'2023-01-01' AS Date), CAST(N'2023-04-09' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (4, 4, 41, CAST(N'2023-01-01' AS Date), CAST(N'2023-01-08' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (5, 5, 54, CAST(N'2023-01-01' AS Date), CAST(N'2023-03-12' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (6, 6, 8, CAST(N'2023-01-01' AS Date), CAST(N'2023-02-22' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (7, 8, 19, CAST(N'2023-01-01' AS Date), CAST(N'2023-01-26' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (8, 9, 24, CAST(N'2023-01-01' AS Date), CAST(N'2023-03-05' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (9, 10, 0, CAST(N'2022-01-01' AS Date), CAST(N'2022-03-06' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (10, 11, 15, CAST(N'2022-01-01' AS Date), CAST(N'2022-05-01' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (11, 12, 11, CAST(N'2022-01-01' AS Date), CAST(N'2022-05-01' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (12, 13, 22, CAST(N'2022-05-01' AS Date), CAST(N'2022-05-01' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (23, 15, 20, CAST(N'2023-02-06' AS Date), CAST(N'2023-02-06' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (1016, 1016, 5, CAST(N'2023-04-16' AS Date), CAST(N'2023-04-17' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (1017, 1017, 4, CAST(N'2023-04-16' AS Date), CAST(N'2023-04-17' AS Date))
INSERT [dbo].[Inventories] ([Inventory_Id], [Product_Id], [Qty], [Enter_Time], [Exit_Time]) VALUES (1018, 1018, 7, CAST(N'2023-04-16' AS Date), CAST(N'2023-04-16' AS Date))
SET IDENTITY_INSERT [dbo].[Inventories] OFF
GO
SET IDENTITY_INSERT [dbo].[Product_Factor] ON 

INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (1, 1, 5, 1)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (2, 1, 6, 1)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (3, 2, 2, 2)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (4, 2, 1, 1)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (5, 3, 4, 5)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (12, 12, 1, 3)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (13, 12, 5, 2)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (14, 12, 6, 2)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (15, 12, 8, 3)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (16, 12, 10, 2)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (17, 12, 12, 1)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (18, 12, 2, 4)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (19, 12, 4, 2)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (20, 12, 3, 2)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (21, 13, 2, 1)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (22, 13, 4, 1)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (23, 13, 6, 2)
INSERT [dbo].[Product_Factor] ([Id], [Factor_Id], [Product_Id], [Qty]) VALUES (24, 13, 8, 1)
SET IDENTITY_INSERT [dbo].[Product_Factor] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (1, N'بخاری', 3500)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (2, N'تلوزیون', 25000)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (3, N'یخچال', 50000)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (4, N'تلفن', 1000)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (5, N'گاز', 30000)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (6, N'کولر', 33000)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (8, N'کولر آبی', 100)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (9, N'سماور', 25000)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (10, N'اتو', 900)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (11, N'شیر آب', 400)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (12, N'پنکه', 900)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (13, N'بالشت', 400)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (14, N'پتو', 1200)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (15, N'جالباسی', 300)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (1016, N'مانیتور', 5000)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (1017, N'سیستم صوتی', 2000)
INSERT [dbo].[Products] ([Id], [Product_Name], [Unit_Price]) VALUES (1018, N'رو میزی', 200)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
/****** Object:  Index [IX_Inventories__Unique]    Script Date: 4/16/2023 10:51:37 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Inventories__Unique] ON [dbo].[Inventories]
(
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Baskets]  WITH CHECK ADD  CONSTRAINT [FK_Baskets_Baskets___Customer] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Baskets] CHECK CONSTRAINT [FK_Baskets_Baskets___Customer]
GO
ALTER TABLE [dbo].[Baskets]  WITH CHECK ADD  CONSTRAINT [FK_Baskets_Baskets___Product] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Baskets] CHECK CONSTRAINT [FK_Baskets_Baskets___Product]
GO
ALTER TABLE [dbo].[Factors]  WITH CHECK ADD  CONSTRAINT [FK_Factors_Factors___Customer] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Factors] CHECK CONSTRAINT [FK_Factors_Factors___Customer]
GO
ALTER TABLE [dbo].[Inventories]  WITH CHECK ADD  CONSTRAINT [FK_Inventories_Products] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Inventories] CHECK CONSTRAINT [FK_Inventories_Products]
GO
ALTER TABLE [dbo].[Product_Factor]  WITH CHECK ADD  CONSTRAINT [FK_Product_Factor___Factor] FOREIGN KEY([Factor_Id])
REFERENCES [dbo].[Factors] ([Id])
GO
ALTER TABLE [dbo].[Product_Factor] CHECK CONSTRAINT [FK_Product_Factor___Factor]
GO
ALTER TABLE [dbo].[Product_Factor]  WITH CHECK ADD  CONSTRAINT [FK_Product_Factor___Product] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Product_Factor] CHECK CONSTRAINT [FK_Product_Factor___Product]
GO
USE [master]
GO
ALTER DATABASE [OnlineShop] SET  READ_WRITE 
GO
