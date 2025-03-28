/****** Object:  Database [GameForum]    Script Date: 2025/2/27 上午 09:47:30 ******/
CREATE DATABASE [GameForum]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GameForum', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\GameForum.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GameForum_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\GameForum_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GameForum] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GameForum].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GameForum] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GameForum] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GameForum] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GameForum] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GameForum] SET ARITHABORT OFF 
GO
ALTER DATABASE [GameForum] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GameForum] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GameForum] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GameForum] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GameForum] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GameForum] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GameForum] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GameForum] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GameForum] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GameForum] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GameForum] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GameForum] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GameForum] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GameForum] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GameForum] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GameForum] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GameForum] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GameForum] SET RECOVERY FULL 
GO
ALTER DATABASE [GameForum] SET  MULTI_USER 
GO
ALTER DATABASE [GameForum] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GameForum] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GameForum] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GameForum] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GameForum] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GameForum] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'GameForum', N'ON'
GO
ALTER DATABASE [GameForum] SET QUERY_STORE = ON
GO
ALTER DATABASE [GameForum] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GameForum]
GO
/****** Object:  Table [dbo].[Advertisement]    Script Date: 2025/2/27 上午 09:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertisement](
	[advertisement_id] [int] IDENTITY(1,1) NOT NULL,
	[advertisementName] [nvarchar](50) NOT NULL,
	[category] [nvarchar](24) NOT NULL,
	[imageUrl] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[advertisement_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[article_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[articleTitle] [nvarchar](50) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[postDate] [datetime] NULL,
	[editDate] [datetime] NULL,
	[status] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[article_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticleGroup]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleGroup](
	[articleGroup_id] [int] IDENTITY(1,1) NOT NULL,
	[category] [nvarchar](24) NOT NULL,
	[views] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[articleGroup_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticleMessage]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleMessage](
	[articleMessage_id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[messageContent] [nvarchar](250) NOT NULL,
	[editDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[articleMessage_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discussion]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discussion](
	[discussion_id] [int] IDENTITY(1,1) NOT NULL,
	[discussionName] [nvarchar](50) NOT NULL,
	[discussionDescription] [nvarchar](500) NULL,
	[imageUrl] [nvarchar](250) NULL,
	[views] [int] NULL,
	[category] [nvarchar](24) NULL,
	[articleGroup_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[discussion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[news_id] [int] IDENTITY(1,1) NOT NULL,
	[newsTitle] [nvarchar](50) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[imageUrl] [nvarchar](250) NULL,
	[editDate] [datetime] NULL,
	[category] [nvarchar](24) NULL,
PRIMARY KEY CLUSTERED 
(
	[news_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewsImage]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsImage](
	[newsImage_id] [int] IDENTITY(1,1) NOT NULL,
	[news_id] [int] NOT NULL,
	[imageUrl] [nvarchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[newsImage_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewsMessage]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsMessage](
	[newsMessage_id] [int] IDENTITY(1,1) NOT NULL,
	[news_id] [int] NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[messageContent] [nvarchar](250) NOT NULL,
	[editDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[newsMessage_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[orderDate] [datetime] NULL,
	[orderStatus_id] [int] NOT NULL,
	[shippingAddress] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[orderStatus_id] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[orderStatus_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[productName] [nvarchar](50) NOT NULL,
	[productDescription] [nvarchar](500) NULL,
	[mainImageUrl] [nvarchar](250) NULL,
	[price] [int] NOT NULL,
	[productCategory_id] [int] NULL,
	[stock] [int] NULL,
	[sold] [int] NULL,
	[rating] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductAdditionalImage]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAdditionalImage](
	[productAdditionalImage_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[additionalImageUrl] [nvarchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[productAdditionalImage_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[productCategory_id] [int] IDENTITY(1,1) NOT NULL,
	[category] [nvarchar](24) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[productCategory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[shoppingCart_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[shoppingCart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[user_id] [varchar](50) NOT NULL,
	[password] [varchar](64) NOT NULL,
	[nickname] [nvarchar](50) NOT NULL,
	[photoUrl] [nvarchar](250) NULL,
	[gender] [varchar](1) NULL,
	[birthdate] [datetime] NULL,
	[address] [nvarchar](100) NULL,
	[email] [nvarchar](100) NULL,
	[phone] [char](10) NULL,
	[registerDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ViewHistory]    Script Date: 2025/2/27 上午 09:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ViewHistory](
	[viewHistory_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[product_id] [int] NOT NULL,
	[viewDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[viewHistory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([order_id], [user_id], [product_id], [quantity], [orderDate], [orderStatus_id], [shippingAddress]) VALUES (1, N'user001', 1, 1, CAST(N'2025-02-27T09:45:54.847' AS DateTime), 1, N'台北市信義區')
INSERT [dbo].[Order] ([order_id], [user_id], [product_id], [quantity], [orderDate], [orderStatus_id], [shippingAddress]) VALUES (2, N'user002', 2, 2, CAST(N'2025-02-27T09:45:54.847' AS DateTime), 2, N'高雄市左營區')
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([orderStatus_id], [status]) VALUES (1, N'處理中')
INSERT [dbo].[OrderStatus] ([orderStatus_id], [status]) VALUES (2, N'已出貨')
INSERT [dbo].[OrderStatus] ([orderStatus_id], [status]) VALUES (3, N'已完成')
INSERT [dbo].[OrderStatus] ([orderStatus_id], [status]) VALUES (4, N'取消')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([product_id], [productName], [productDescription], [mainImageUrl], [price], [productCategory_id], [stock], [sold], [rating]) VALUES (1, N'遊戲鍵盤', N'RGB背光機械鍵盤，適合電競玩家', N'keyboard.jpg', 2990, 1, 50, 10, 4.5)
INSERT [dbo].[Product] ([product_id], [productName], [productDescription], [mainImageUrl], [price], [productCategory_id], [stock], [sold], [rating]) VALUES (2, N'PS5 遊戲點數卡', N'適用於 PlayStation 5，購買遊戲或訂閱服務', N'ps5_card.jpg', 1000, 2, 100, 20, 4.8)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([productCategory_id], [category]) VALUES (1, N'電玩周邊')
INSERT [dbo].[ProductCategory] ([productCategory_id], [category]) VALUES (2, N'遊戲點數卡')
INSERT [dbo].[ProductCategory] ([productCategory_id], [category]) VALUES (3, N'限量收藏品')
INSERT [dbo].[ProductCategory] ([productCategory_id], [category]) VALUES (4, N'遊戲光碟')
INSERT [dbo].[ProductCategory] ([productCategory_id], [category]) VALUES (5, N'桌遊')
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
INSERT [dbo].[User] ([user_id], [password], [nickname], [photoUrl], [gender], [birthdate], [address], [email], [phone], [registerDate]) VALUES (N'user001', N'password123', N'玩家一號', N'photo1.jpg', N'M', CAST(N'1990-01-01T00:00:00.000' AS DateTime), N'台北市', N'user001@example.com', N'0912345678', CAST(N'2025-02-27T09:45:54.847' AS DateTime))
INSERT [dbo].[User] ([user_id], [password], [nickname], [photoUrl], [gender], [birthdate], [address], [email], [phone], [registerDate]) VALUES (N'user002', N'password123', N'高手二號', N'photo2.jpg', N'F', CAST(N'1995-05-20T00:00:00.000' AS DateTime), N'高雄市', N'user002@example.com', N'0923456789', CAST(N'2025-02-27T09:45:54.847' AS DateTime))
GO
ALTER TABLE [dbo].[Article] ADD  DEFAULT (getdate()) FOR [postDate]
GO
ALTER TABLE [dbo].[Article] ADD  DEFAULT (getdate()) FOR [editDate]
GO
ALTER TABLE [dbo].[ArticleGroup] ADD  DEFAULT ((0)) FOR [views]
GO
ALTER TABLE [dbo].[ArticleMessage] ADD  DEFAULT (getdate()) FOR [editDate]
GO
ALTER TABLE [dbo].[Discussion] ADD  DEFAULT ((0)) FOR [views]
GO
ALTER TABLE [dbo].[News] ADD  DEFAULT (getdate()) FOR [editDate]
GO
ALTER TABLE [dbo].[NewsMessage] ADD  DEFAULT (getdate()) FOR [editDate]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (getdate()) FOR [orderDate]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [stock]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [sold]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [rating]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT (getdate()) FOR [registerDate]
GO
ALTER TABLE [dbo].[ViewHistory] ADD  DEFAULT (getdate()) FOR [viewDate]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[ArticleMessage]  WITH CHECK ADD FOREIGN KEY([article_id])
REFERENCES [dbo].[Article] ([article_id])
GO
ALTER TABLE [dbo].[ArticleMessage]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[NewsImage]  WITH CHECK ADD FOREIGN KEY([news_id])
REFERENCES [dbo].[News] ([news_id])
GO
ALTER TABLE [dbo].[NewsMessage]  WITH CHECK ADD FOREIGN KEY([news_id])
REFERENCES [dbo].[News] ([news_id])
GO
ALTER TABLE [dbo].[NewsMessage]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([orderStatus_id])
REFERENCES [dbo].[OrderStatus] ([orderStatus_id])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([productCategory_id])
REFERENCES [dbo].[ProductCategory] ([productCategory_id])
GO
ALTER TABLE [dbo].[ProductAdditionalImage]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[ViewHistory]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[ViewHistory]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
USE [master]
GO
ALTER DATABASE [GameForum] SET  READ_WRITE 
GO
