USE [GameForum]
GO
/****** Object:  Table [dbo].[Advertise]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertise](
	[AdvertiseID] [int] NOT NULL,
	[AdName] [nvarchar](50) NOT NULL,
	[AdDescribe] [nvarchar](100) NULL,
	[AdvertiseURL] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Advertise] PRIMARY KEY CLUSTERED 
(
	[AdvertiseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticleImg]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleImg](
	[ArticleImgID] [int] NOT NULL,
	[ArticleID] [int] NOT NULL,
	[ArticleImgURL] [nvarchar](max) NOT NULL,
	[ArticleImgDate] [datetime2](7) NULL,
 CONSTRAINT [PK_ArticleImg] PRIMARY KEY CLUSTERED 
(
	[ArticleImgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticleMessage]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleMessage](
	[BoardID] [int] NOT NULL,
	[UserID] [int] NULL,
	[Message] [nvarchar](200) NULL,
 CONSTRAINT [PK_ArticleMessage] PRIMARY KEY CLUSTERED 
(
	[BoardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[ArticleID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[BoardID] [int] NULL,
	[ArticleFloor] [int] NOT NULL,
	[ArticleTitle] [nvarchar](100) NOT NULL,
	[ArticleContent] [nvarchar](max) NOT NULL,
	[PublishedDate] [datetime2](7) NOT NULL,
	[LastUpdated] [datetime2](7) NULL,
	[ViewCount] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Status] [nvarchar](50) NULL,
	[ArticleLabel] [nchar](10) NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CollectArticles]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CollectArticles](
	[ID] [int] NOT NULL,
	[ArticleID] [int] NOT NULL,
 CONSTRAINT [PK_CollectArticles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerProblems]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerProblems](
	[ID] [nchar](10) NOT NULL,
	[UserID] [int] NOT NULL,
	[ProblemType] [nvarchar](50) NULL,
	[ProblemTitle] [nvarchar](50) NULL,
	[ProblemContent] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_CustomerProblems] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerServiceCenter]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerServiceCenter](
	[QuestID] [int] NOT NULL,
	[QuestName] [nvarchar](max) NOT NULL,
	[QuestAnswer] [nvarchar](max) NOT NULL,
	[QuestType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CustomerServiceCenter] PRIMARY KEY CLUSTERED 
(
	[QuestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Friend]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friend](
	[UserID] [int] NOT NULL,
	[FriendID] [int] NOT NULL,
 CONSTRAINT [PK_Friend] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kanban]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kanban](
	[KanbanID] [int] NOT NULL,
	[KanbanName] [nvarchar](100) NOT NULL,
	[KanbanImage] [nvarchar](100) NULL,
	[Category] [nvarchar](50) NOT NULL,
	[KanbanType] [nvarchar](100) NULL,
 CONSTRAINT [PK_GameGruops] PRIMARY KEY CLUSTERED 
(
	[KanbanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[NewsID] [int] NOT NULL,
	[BoardID] [int] NULL,
	[NewsName] [nvarchar](200) NOT NULL,
	[NewsLabel] [nvarchar](100) NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewsMessageBoard]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsMessageBoard](
	[BoardID] [int] NOT NULL,
	[UserID] [int] NULL,
	[Message] [nvarchar](200) NULL,
 CONSTRAINT [PK_NewsMessageBoard] PRIMARY KEY CLUSTERED 
(
	[BoardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrderDate] [datetime2](7) NOT NULL,
	[OrderStatus] [nvarchar](50) NULL,
	[ShippingAddress] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[OrderDetailID] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductDescription] [nvarchar](1000) NULL,
	[ProductPrice] [decimal](18, 2) NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[ImageURL] [nvarchar](255) NULL,
	[IsAvailable] [bit] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[UserID] [int] NOT NULL,
	[ProductID] [int] NULL,
	[AddTime] [datetime2](7) NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocialLogins]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocialLogins](
	[ID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Provider] [nvarchar](50) NOT NULL,
	[ProviderUserId] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
 CONSTRAINT [PK_SocialLogins] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscribeKanBan]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscribeKanBan](
	[ID] [int] NOT NULL,
	[KanBanID] [int] NOT NULL,
 CONSTRAINT [PK_subscribeKanBan] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subscription]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscription](
	[ID] [int] NOT NULL,
	[ArticleID] [int] NOT NULL,
	[SubscriberID] [int] NULL,
 CONSTRAINT [PK_Subscription] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Talk]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Talk](
	[ListenerID] [int] NOT NULL,
	[SpeakerID] [int] NULL,
	[TalkContent] [nvarchar](500) NULL,
 CONSTRAINT [PK_Talk_1] PRIMARY KEY CLUSTERED 
(
	[ListenerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Track]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[UserTrackID] [int] NOT NULL,
	[TrackedID] [int] NOT NULL,
 CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED 
(
	[UserTrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2025/2/21 下午 02:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[MemberName] [nvarchar](50) NULL,
	[PhoneNumber] [varchar](20) NULL,
	[Address] [nvarchar](500) NULL,
	[RegisteredDate] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Identification] [varchar](10) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Advertise] ([AdvertiseID], [AdName], [AdDescribe], [AdvertiseURL]) VALUES (1, N'Super Sale', N'Huge discounts on all products!', N'https://example.com/super-sale')
INSERT [dbo].[Advertise] ([AdvertiseID], [AdName], [AdDescribe], [AdvertiseURL]) VALUES (2, N'New Arrival', N'Check out our latest collection.', N'https://example.com/new-arrival')
INSERT [dbo].[Advertise] ([AdvertiseID], [AdName], [AdDescribe], [AdvertiseURL]) VALUES (3, N'Limited Offer', N'Exclusive deals for a limited time.', N'https://example.com/limited-offer')
INSERT [dbo].[Advertise] ([AdvertiseID], [AdName], [AdDescribe], [AdvertiseURL]) VALUES (4, N'Flash Deal', N'Up to 50% off on selected items.', N'https://example.com/flash-deal')
INSERT [dbo].[Advertise] ([AdvertiseID], [AdName], [AdDescribe], [AdvertiseURL]) VALUES (5, N'Holiday Specials', N'Celebrate with special discounts.', N'https://example.com/holiday-specials')
GO
INSERT [dbo].[ArticleImg] ([ArticleImgID], [ArticleID], [ArticleImgURL], [ArticleImgDate]) VALUES (1, 1, N'/images/articles/elden_ring_dlc.jpg', CAST(N'2025-02-18T10:15:00.0000000' AS DateTime2))
INSERT [dbo].[ArticleImg] ([ArticleImgID], [ArticleID], [ArticleImgURL], [ArticleImgDate]) VALUES (2, 1, N'/images/articles/gta6_leak.jpg', CAST(N'2025-02-19T12:30:00.0000000' AS DateTime2))
INSERT [dbo].[ArticleImg] ([ArticleImgID], [ArticleID], [ArticleImgURL], [ArticleImgDate]) VALUES (3, 2, N'/images/articles/zelda_tears_of_kingdom.jpg', CAST(N'2025-02-20T14:45:00.0000000' AS DateTime2))
INSERT [dbo].[ArticleImg] ([ArticleImgID], [ArticleID], [ArticleImgURL], [ArticleImgDate]) VALUES (4, 2, N'/images/articles/csgo_tournament.jpg', CAST(N'2025-02-21T16:00:00.0000000' AS DateTime2))
INSERT [dbo].[ArticleImg] ([ArticleImgID], [ArticleID], [ArticleImgURL], [ArticleImgDate]) VALUES (5, 2, N'/images/articles/starfield_space.jpg', CAST(N'2025-02-22T18:10:00.0000000' AS DateTime2))
GO
INSERT [dbo].[Articles] ([ArticleID], [GroupID], [UserID], [BoardID], [ArticleFloor], [ArticleTitle], [ArticleContent], [PublishedDate], [LastUpdated], [ViewCount], [IsDeleted], [Status], [ArticleLabel]) VALUES (1, 201, 1001, NULL, 1, N'《艾爾登法環》DLC：暗影之樹新細節公開！', N'FromSoftware 最新的《艾爾登法環》DLC「暗影之樹」即將發布，全新 Boss、武器與劇情將帶來新的挑戰！', CAST(N'2025-02-20T10:00:00.0000000' AS DateTime2), CAST(N'2025-02-20T10:30:00.0000000' AS DateTime2), 320, 0, N'Published', N'情報        ')
INSERT [dbo].[Articles] ([ArticleID], [GroupID], [UserID], [BoardID], [ArticleFloor], [ArticleTitle], [ArticleContent], [PublishedDate], [LastUpdated], [ViewCount], [IsDeleted], [Status], [ArticleLabel]) VALUES (2, 202, 1002, NULL, 1, N'《薩爾達傳說：王國之淚》最佳武器推薦', N'想要征服海拉魯？這篇文章將介紹《王國之淚》最強的武器組合，讓你輕鬆面對敵人！', CAST(N'2025-02-19T14:15:00.0000000' AS DateTime2), CAST(N'2025-02-19T15:00:00.0000000' AS DateTime2), 210, 0, N'Published', N'攻略        ')
INSERT [dbo].[Articles] ([ArticleID], [GroupID], [UserID], [BoardID], [ArticleFloor], [ArticleTitle], [ArticleContent], [PublishedDate], [LastUpdated], [ViewCount], [IsDeleted], [Status], [ArticleLabel]) VALUES (3, 203, 1003, NULL, 1, N'《GTA 6》發售日爆料？2025 年登場', N'最近有內部人士透露《GTA 6》的發售時間，並分享了一些全新地圖與遊戲特色的細節！', CAST(N'2025-02-18T08:45:00.0000000' AS DateTime2), CAST(N'2025-02-18T09:20:00.0000000' AS DateTime2), 500, 0, N'Draft', N'情報        ')
GO
INSERT [dbo].[CustomerServiceCenter] ([QuestID], [QuestName], [QuestAnswer], [QuestType]) VALUES (1, N'我忘記密碼了，該怎麼辦？', N'請至登入頁面點選 "忘記密碼"，系統會寄送密碼重設連結至您的 Email。', N'帳號問題')
INSERT [dbo].[CustomerServiceCenter] ([QuestID], [QuestName], [QuestAnswer], [QuestType]) VALUES (2, N'為什麼我的帳號被封鎖？', N'請確認您是否違反社群規範，例如使用外掛、發表不當言論等。如有異議，請透過客服信箱申訴。', N'帳號問題')
INSERT [dbo].[CustomerServiceCenter] ([QuestID], [QuestName], [QuestAnswer], [QuestType]) VALUES (3, N'遊戲中遇到 BUG，該如何回報？', N'請在論壇的「Bug 反饋」區發表新貼文，或直接聯絡客服提供詳細描述與截圖。', N'遊戲問題')
INSERT [dbo].[CustomerServiceCenter] ([QuestID], [QuestName], [QuestAnswer], [QuestType]) VALUES (4, N'購買遊戲幣後沒有收到，怎麼辦？', N'請先確認付款是否成功，若已扣款但未收到，請提供交易紀錄並聯絡客服處理。', N'付款問題')
INSERT [dbo].[CustomerServiceCenter] ([QuestID], [QuestName], [QuestAnswer], [QuestType]) VALUES (5, N'如何更改論壇的暱稱？', N'請至個人資料設定頁面修改暱稱，每 30 天可更改一次。', N'帳號問題')
GO
INSERT [dbo].[Kanban] ([KanbanID], [KanbanName], [KanbanImage], [Category], [KanbanType]) VALUES (201, N'艾爾登法環討論區', N'/images/groups/elden_ring.jpg', N'動作角色扮演', NULL)
INSERT [dbo].[Kanban] ([KanbanID], [KanbanName], [KanbanImage], [Category], [KanbanType]) VALUES (202, N'FPS 射擊愛好者', N'/images/groups/fps_gamers.jpg', N'第一人稱射擊', NULL)
INSERT [dbo].[Kanban] ([KanbanID], [KanbanName], [KanbanImage], [Category], [KanbanType]) VALUES (203, N'GTA 6 玩家社群', N'/images/groups/gta6.jpg', N'開放世界', NULL)
INSERT [dbo].[Kanban] ([KanbanID], [KanbanName], [KanbanImage], [Category], [KanbanType]) VALUES (204, N'薩爾達傳說交流區', N'/images/groups/zelda.jpg', N'動作冒險', NULL)
INSERT [dbo].[Kanban] ([KanbanID], [KanbanName], [KanbanImage], [Category], [KanbanType]) VALUES (205, N'即時戰略迷', N'/images/groups/rts_fans.jpg', N'策略遊戲', NULL)
GO
INSERT [dbo].[News] ([NewsID], [BoardID], [NewsName], [NewsLabel]) VALUES (1, 101, N'《艾爾登法環》DLC「黃金樹之影」即將登場', N'遊戲更新')
INSERT [dbo].[News] ([NewsID], [BoardID], [NewsName], [NewsLabel]) VALUES (2, 102, N'《GTA 6》正式發表，2025 年上市！', N'遊戲新聞')
INSERT [dbo].[News] ([NewsID], [BoardID], [NewsName], [NewsLabel]) VALUES (3, 103, N'《英雄聯盟》S14 世界賽賽程公布', N'電競賽事')
INSERT [dbo].[News] ([NewsID], [BoardID], [NewsName], [NewsLabel]) VALUES (4, 101, N'論壇系統維護公告（2 月 25 日）', N'公告')
INSERT [dbo].[News] ([NewsID], [BoardID], [NewsName], [NewsLabel]) VALUES (5, 102, N'限時活動：Steam 春季特賣正式開跑！', N'活動資訊')
GO
INSERT [dbo].[NewsMessageBoard] ([BoardID], [UserID], [Message]) VALUES (101, 1001, N'這次的《艾爾登法環》DLC 看起來超讚！大家期待嗎？')
INSERT [dbo].[NewsMessageBoard] ([BoardID], [UserID], [Message]) VALUES (102, 1002, N'GTA 6 終於來了！希望畫質和自由度比前作更強！')
INSERT [dbo].[NewsMessageBoard] ([BoardID], [UserID], [Message]) VALUES (103, 1003, N'LOL S14 世界賽，T1 今年能奪冠嗎？')
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [ProductID], [Quantity], [OrderDate], [OrderStatus], [ShippingAddress]) VALUES (1, 1, 2, CAST(N'2025-02-15T14:30:00.0000000' AS DateTime2), N'待出貨', N'台北市信義區電競路 88 號')
INSERT [dbo].[OrderDetails] ([OrderDetailID], [ProductID], [Quantity], [OrderDate], [OrderStatus], [ShippingAddress]) VALUES (2, 2, 1, CAST(N'2025-02-16T10:45:00.0000000' AS DateTime2), N'已出貨', N'高雄市電競大街 99 號')
INSERT [dbo].[OrderDetails] ([OrderDetailID], [ProductID], [Quantity], [OrderDate], [OrderStatus], [ShippingAddress]) VALUES (3, 3, 3, CAST(N'2025-02-17T09:20:00.0000000' AS DateTime2), N'已完成', N'新北市遊戲城 66 號')
INSERT [dbo].[OrderDetails] ([OrderDetailID], [ProductID], [Quantity], [OrderDate], [OrderStatus], [ShippingAddress]) VALUES (4, 4, 1, CAST(N'2025-02-18T16:10:00.0000000' AS DateTime2), N'取消', N'台北市信義區電競路 88 號')
INSERT [dbo].[OrderDetails] ([OrderDetailID], [ProductID], [Quantity], [OrderDate], [OrderStatus], [ShippingAddress]) VALUES (5, 5, 5, CAST(N'2025-02-19T12:00:00.0000000' AS DateTime2), N'待出貨', N'高雄市電競大街 99 號')
GO
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDetailID]) VALUES (1, 1001, 1)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDetailID]) VALUES (2, 1001, 2)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDetailID]) VALUES (3, 1002, 3)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDetailID]) VALUES (4, 1002, 4)
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDetailID]) VALUES (5, 1003, 5)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [ProductPrice], [StockQuantity], [Category], [ImageURL], [IsAvailable]) VALUES (1, N'塞爾達傳說：荒野之息', N'一個開放世界的冒險遊戲，探索海拉魯大地。', CAST(59.99 AS Decimal(18, 2)), 120, N'冒險', N'http://example.com/zelda.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [ProductPrice], [StockQuantity], [Category], [ImageURL], [IsAvailable]) VALUES (2, N'賽博朋克2077', N'設定在夜之城的開放世界動作冒險故事。', CAST(49.99 AS Decimal(18, 2)), 75, N'角色扮演', N'http://example.com/cyberpunk.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [ProductPrice], [StockQuantity], [Category], [ImageURL], [IsAvailable]) VALUES (3, N'集合啦！動物森友會', N'一個生活模擬遊戲，建造和自定義自己的島嶼。', CAST(49.99 AS Decimal(18, 2)), 200, N'模擬', N'http://example.com/animal_crossing.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [ProductPrice], [StockQuantity], [Category], [ImageURL], [IsAvailable]) VALUES (4, N'光環：無限', N'一個第一人稱射擊遊戲，包含單人劇情和多人模式。', CAST(59.99 AS Decimal(18, 2)), 150, N'射擊', N'http://example.com/halo.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductDescription], [ProductPrice], [StockQuantity], [Category], [ImageURL], [IsAvailable]) VALUES (5, N'我的世界', N'一個沙盒遊戲，可以建造和探索自己的世界。', CAST(29.99 AS Decimal(18, 2)), 300, N'沙盒', N'http://example.com/minecraft.jpg', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [Email], [PasswordHash], [MemberName], [PhoneNumber], [Address], [RegisteredDate], [IsActive], [Identification]) VALUES (1001, N'pro_gamer', N'progamer@example.com', N'$2b$12$randomhash1234567890', N'遊戲達人', N'0912-345-678', N'台北市信義區電競路 88 號', CAST(N'2024-01-15T10:30:00.0000000' AS DateTime2), 1, N'A123456789')
INSERT [dbo].[Users] ([UserID], [Username], [Email], [PasswordHash], [MemberName], [PhoneNumber], [Address], [RegisteredDate], [IsActive], [Identification]) VALUES (1002, N'fps_master', N'fpsmaster@example.com', N'$2b$12$randomhash0987654321', N'FPS高手', N'0987-654-321', N'高雄市電競大街 99 號', CAST(N'2023-12-20T15:45:00.0000000' AS DateTime2), 1, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [Email], [PasswordHash], [MemberName], [PhoneNumber], [Address], [RegisteredDate], [IsActive], [Identification]) VALUES (1003, N'rpg_lover', N'rpglover@example.com', N'$2b$12$randomhash1122334455', N'RPG探險家', N'0933-222-111', N'新北市遊戲城 66 號', CAST(N'2024-02-01T08:20:00.0000000' AS DateTime2), 1, NULL)
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_StockQuantity]  DEFAULT ((0)) FOR [StockQuantity]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_IsAvailable]  DEFAULT ((1)) FOR [IsAvailable]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ArticleImg]  WITH CHECK ADD  CONSTRAINT [FK_ArticleImg_Articles] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
GO
ALTER TABLE [dbo].[ArticleImg] CHECK CONSTRAINT [FK_ArticleImg_Articles]
GO
ALTER TABLE [dbo].[ArticleMessage]  WITH CHECK ADD  CONSTRAINT [FK_ArticleMessage_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ArticleMessage] CHECK CONSTRAINT [FK_ArticleMessage_Users]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_ArticleMessage] FOREIGN KEY([BoardID])
REFERENCES [dbo].[ArticleMessage] ([BoardID])
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_ArticleMessage]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_GameGruops] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Kanban] ([KanbanID])
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_GameGruops]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_Users]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_Users1] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_Users1]
GO
ALTER TABLE [dbo].[CollectArticles]  WITH CHECK ADD  CONSTRAINT [FK_CollectArticles_Articles] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
GO
ALTER TABLE [dbo].[CollectArticles] CHECK CONSTRAINT [FK_CollectArticles_Articles]
GO
ALTER TABLE [dbo].[CollectArticles]  WITH CHECK ADD  CONSTRAINT [FK_CollectArticles_Users] FOREIGN KEY([ID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CollectArticles] CHECK CONSTRAINT [FK_CollectArticles_Users]
GO
ALTER TABLE [dbo].[CustomerProblems]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProblems_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CustomerProblems] CHECK CONSTRAINT [FK_CustomerProblems_Users]
GO
ALTER TABLE [dbo].[Friend]  WITH CHECK ADD  CONSTRAINT [FK_Friend_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Friend] CHECK CONSTRAINT [FK_Friend_Users]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_NewsMessageBoard] FOREIGN KEY([BoardID])
REFERENCES [dbo].[NewsMessageBoard] ([BoardID])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_NewsMessageBoard]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_OrderDetails] FOREIGN KEY([OrderDetailID])
REFERENCES [dbo].[OrderDetails] ([OrderDetailID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_OrderDetails]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Products]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Users]
GO
ALTER TABLE [dbo].[SocialLogins]  WITH CHECK ADD  CONSTRAINT [FK_SocialLogins_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[SocialLogins] CHECK CONSTRAINT [FK_SocialLogins_Users]
GO
ALTER TABLE [dbo].[SubscribeKanBan]  WITH CHECK ADD  CONSTRAINT [FK_SubscribeKanBan_Kanban] FOREIGN KEY([KanBanID])
REFERENCES [dbo].[Kanban] ([KanbanID])
GO
ALTER TABLE [dbo].[SubscribeKanBan] CHECK CONSTRAINT [FK_SubscribeKanBan_Kanban]
GO
ALTER TABLE [dbo].[SubscribeKanBan]  WITH CHECK ADD  CONSTRAINT [FK_SubscribeKanBan_Users] FOREIGN KEY([ID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[SubscribeKanBan] CHECK CONSTRAINT [FK_SubscribeKanBan_Users]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_Articles] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_Articles]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_Users] FOREIGN KEY([ID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_Users]
GO
ALTER TABLE [dbo].[Talk]  WITH CHECK ADD  CONSTRAINT [FK_Talk_Users] FOREIGN KEY([ListenerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Talk] CHECK CONSTRAINT [FK_Talk_Users]
GO
ALTER TABLE [dbo].[Track]  WITH CHECK ADD  CONSTRAINT [FK_Track_Users] FOREIGN KEY([UserTrackID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Track] CHECK CONSTRAINT [FK_Track_Users]
GO
