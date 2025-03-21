USE [GameForum]
GO
/****** Object:  Table [dbo].[Advertisement]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertisement](
	[AdvertisementID] [int] IDENTITY(1,1) NOT NULL,
	[AdvertisementName] [nvarchar](50) NOT NULL,
	[Category] [nvarchar](24) NOT NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[HyperUrl] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[AdvertisementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[ArticleID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[ArticleGroupID] [int] NULL,
	[ArticleContent] [nvarchar](max) NOT NULL,
	[PostDate] [datetime] NULL,
	[EditDate] [datetime] NULL,
	[Status] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK__Article__CC36F66090AB9C5B] PRIMARY KEY CLUSTERED 
(
	[ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticleGroup]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleGroup](
	[ArticleGroupID] [int] IDENTITY(1,1) NOT NULL,
	[DiscussionID] [int] NOT NULL,
	[Category] [nvarchar](24) NOT NULL,
	[Views] [int] NULL,
	[CoverImage] [image] NULL,
	[ArticleTitle] [nvarchar](100) NULL,
 CONSTRAINT [PK__ArticleG__9DEC28CAA7277795] PRIMARY KEY CLUSTERED 
(
	[ArticleGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticleMessage]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleMessage](
	[ArticleMessageID] [int] IDENTITY(1,1) NOT NULL,
	[ArticleID] [int] NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[MessageContent] [nvarchar](250) NOT NULL,
	[EditDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ArticleMessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerProblems]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerProblems](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[QuestionType] [nvarchar](50) NULL,
	[QuestionDescription] [nvarchar](1000) NULL,
	[Image] [image] NULL,
 CONSTRAINT [PK_CustomerProblems] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discussion]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discussion](
	[DiscussionID] [int] IDENTITY(1,1) NOT NULL,
	[DiscussionName] [nvarchar](50) NOT NULL,
	[DiscussionDescription] [nvarchar](500) NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[Views] [int] NULL,
	[Category] [nvarchar](24) NULL,
 CONSTRAINT [PK_Discussion] PRIMARY KEY CLUSTERED 
(
	[DiscussionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoricalVisitors]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoricalVisitors](
	[HistoricalVisitorID] [int] IDENTITY(1,1) NOT NULL,
	[OwnerID] [varchar](50) NOT NULL,
	[VisitorID] [varchar](50) NULL,
	[VisitTime] [datetime] NULL,
 CONSTRAINT [PK_HistoricalVisitors] PRIMARY KEY CLUSTERED 
(
	[HistoricalVisitorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[NewsID] [int] IDENTITY(1,1) NOT NULL,
	[NewsTitle] [nvarchar](50) NOT NULL,
	[NewsContent] [nvarchar](max) NOT NULL,
	[ImageUrl] [nvarchar](250) NULL,
	[EditDate] [datetime] NULL,
	[Category] [nvarchar](24) NULL,
PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewsImage]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsImage](
	[NewsImageID] [int] IDENTITY(1,1) NOT NULL,
	[NewsID] [int] NOT NULL,
	[ImageUrl] [nvarchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NewsImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewsMessage]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsMessage](
	[NewsMessageID] [int] IDENTITY(1,1) NOT NULL,
	[NewsID] [int] NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[MessageContent] [nvarchar](250) NOT NULL,
	[EditDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[NewsMessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrderDate] [datetime] NULL,
	[OrderStatusID] [int] NOT NULL,
	[ShippingAddress] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[OrderStatusID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[ProductDescription] [nvarchar](500) NULL,
	[MainImageUrl] [nvarchar](250) NULL,
	[Price] [int] NOT NULL,
	[ProductCategoryID] [int] NULL,
	[Stock] [int] NULL,
	[Sold] [int] NULL,
	[Rating] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductAdditionalImage]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAdditionalImage](
	[ProductAdditionalImageID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[AdditionalImageUrl] [nvarchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductAdditionalImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](24) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Relationships]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relationships](
	[RelationshipID] [int] IDENTITY(1,1) NOT NULL,
	[PersonAID] [varchar](50) NOT NULL,
	[PersonBID] [varchar](50) NULL,
	[RelationshipType] [nvarchar](50) NULL,
 CONSTRAINT [PK_Relationships] PRIMARY KEY CLUSTERED 
(
	[RelationshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[ShoppingCartID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ShoppingCartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [varchar](50) NOT NULL,
	[Password] [varchar](128) NULL,
	[Nickname] [nvarchar](50) NOT NULL,
	[PhotoUrl] [nvarchar](250) NULL,
	[Gender] [varchar](1) NULL,
	[Birthdate] [datetime] NULL,
	[Address] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Phone] [char](10) NULL,
	[RegisterDate] [datetime] NULL,
	[Provider] [varchar](50) NULL,
	[ProviderID] [varchar](255) NULL,
 CONSTRAINT [PK__User__B9BE370F8393A9A1] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ViewHistory]    Script Date: 2025/3/21 上午 10:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ViewHistory](
	[ViewHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ViewDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ViewHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Advertisement] ON 

INSERT [dbo].[Advertisement] ([AdvertisementID], [AdvertisementName], [Category], [ImageUrl], [HyperUrl]) VALUES (2, N'【異世界召喚】全新RPG手遊震撼上線！', N'手機遊戲', NULL, N'http://expamle.com.tw')
INSERT [dbo].[Advertisement] ([AdvertisementID], [AdvertisementName], [Category], [ImageUrl], [HyperUrl]) VALUES (4, N'【限定發售】《鬼滅之刃》角色徽章套組！', N'動漫周邊產品', NULL, NULL)
INSERT [dbo].[Advertisement] ([AdvertisementID], [AdvertisementName], [Category], [ImageUrl], [HyperUrl]) VALUES (5, N'【次世代戰鬥啟動】PS5限時優惠！', N'遊戲主機', NULL, NULL)
INSERT [dbo].[Advertisement] ([AdvertisementID], [AdvertisementName], [Category], [ImageUrl], [HyperUrl]) VALUES (6, N'【2025 ACG狂熱祭】早鳥票開賣啦！', N'動漫展活動', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Advertisement] OFF
GO
SET IDENTITY_INSERT [dbo].[Article] ON 

INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (1, N'user001', 1, N'「能夠再次奪冠，我感到非常高興。這次勝利對我和隊伍都有著特殊的意義。」「感謝一直以來支持我們的粉絲，這個冠軍屬於你們。」', CAST(N'2025-03-14T13:20:22.000' AS DateTime), CAST(N'2025-03-14T14:11:35.710' AS DateTime), N'存在')
INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (4, N'user100', 2, N'歡迎來到我們的新論壇！

在這裡，我們希望能夠打造一個友善、互助並且富有創意的交流空間，讓大家可以分享心得、討論話題，並且學習新知。

基本規則：

尊重彼此 - 請友善對待每一位成員，避免任何形式的攻擊、歧視或惡意言論。

保持內容合適 - 禁止發表違反法律或倫理的內容，包括但不限於暴力、仇恨、色情等。

避免洗版與垃圾訊息 - 請勿重複發表相同內容或散佈廣告，以維護論壇的整潔。

遵守版規與管理員指示 - 若有任何爭議，請依循管理團隊的指導，並以和平方式解決問題。

鼓勵有建設性的討論 - 歡迎分享您的經驗、見解與創意，讓大家一起成長。

祝賀與展望：

感謝大家加入這個全新的論壇！希望這裡能成為一個充滿活力與熱情的社群，讓我們一起創造更多有價值的討論與交流。

無論你是新手還是老手，都歡迎發表你的想法，一起讓這個論壇變得更好！

再次感謝大家的支持，祝大家討論愉快！

', CAST(N'2025-03-15T00:00:00.000' AS DateTime), NULL, N'存在')
INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (6, N'user002', 1, N'好猛', CAST(N'2025-03-14T15:01:00.000' AS DateTime), CAST(N'2025-03-01T15:42:00.000' AS DateTime), N'存在')
INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (7, N'user080', 3, N'<p>哈囉各位，我是拿塔，這次想跟大家分享一下我在《魔物獵人 荒野》中的經歷。</p><p>原本我只是想輕鬆享受狩獵的樂趣，沒想到卻被那隻名為「白之孤影」的魔物欺負得團團轉！這傢伙總是在我最不注意時出現，讓我屢戰屢敗，真的是氣到不行。</p><p>面對這樣的狀況，我決定發文向各位高手求教，有沒有人能分享一些對付「白之孤影」的實用攻略？也希望能藉此機會認識更多志同道合的獵人，一起討論如何提升技巧。</p>', CAST(N'2025-03-16T01:10:02.000' AS DateTime), CAST(N'2025-03-16T01:34:02.000' AS DateTime), N'存在')
INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (8, N'user100', 3, N'<p><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074198915_n.jpg" class="fr-fic fr-dii" status="success"></p><p><br></p><p><span style="font-size: 18px;">護鎖刃龍資訊</span></p><p><span style="font-size: 18px;">古代文明創造出的造龍種，帶有鎖刃龍之力。既沒有生殖能力，也不會捕食，而是直接攝取龍乳作為能量來源。除了與其他護龍一樣能夠吸收和釋放能量之外，還能通過翼上的鎖刃吸收屬性能量，轉化為自身的養分。</span></p><p><br></p><p><span style="font-size: 18px;">出現位置 : 龍都遺跡</span></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖刃龍資訊</span></p><p><span style="font-size: 18px;">公會保存的文獻指出，這種飛龍早已滅絕。翅膀的一部分有獨特的刀刃，形如鎖鏈，能夠自由伸縮並橫掃獵物。不僅如此，它還能通過鎖刃吸收屬性能量，作為自己的能源，甚至能夠將吸收的能量轉化為龍屬性並釋放出來。</span></p><p><br></p><p><span style="font-size: 18px;">出現位置 : 全地圖皆會出現</span></p><p><br></p><p><br></p><p><span style="font-size: 18px;">弱點</span></p><p><span style="font-size: 18px;">鎖刃龍的頭部是弱點，身體兩側的鎖刃可以被破壞，尾巴可以單獨被切斷，以上所有部位都有較高幾率掉落素材。</span></p><p><br></p><p><span style="font-size: 24px;"><strong>掉落材料</strong></span></p><p><span style="font-size: 18px;">【護鎖刃龍】下位護龍的鱗：</span></p><p><span style="font-size: 18px;">目標報酬【20%】、破壞頭部部位【100%】、破壞傷口掉落【45%】、剝取屍體【50%】。護龍的毛皮：目標報酬【20%】、破壞左右鎖刃【100%】、破壞傷口掉落【43%】、剝取屍體【30%】。護龍的血：目標報酬【10%】、剝取切斷的尾巴【100%】、破壞傷口掉落【12%】、剝取屍體【20%】。滋養精華：目標報酬【30%】。精壯護骨：目標報酬【20%】。</span></p><p><br></p><p><span style="font-size: 18px;">【鎖刃龍】上位無情鎖刃甲：</span></p><p><span style="font-size: 18px;">破壞鎖刃部位【100%】。鎖刃龍的上等鱗：目標報酬【20%】、破壞傷口掉落【45%】、剝取屍體【30%】。鎖刃龍的尖角：目標報酬【8%】、破壞頭部部位【100%】、剝取屍體【13%】。鎖刃龍的尾巴：目標報酬【8%】、剝取切斷的尾巴部位【93%】、剝取屍體【11%】。鎖刃龍的堅鎧殼：目標報酬【20%】、破壞傷口掉落【43%】、剝取屍體【23%】。鎖刃龍的白毛：目標報酬【15%】、破壞傷口掉落【12%】、剝取屍體【18%】。堅龍骨：目標報酬【18%】。鎖刃龍狩獵證S：目標報酬【8%】。鎖刃龍的龍玉：目標報酬【3%】、剝取切斷的尾巴部位【7%】、剝取屍體【5%】。</span></p><p><br></p><p><br></p><p><span style="font-size: 24px;"><strong>如何躲避招式</strong></span></p><p><span style="font-size: 18px;">後撤步鎖刃擊</span></p><p><span style="font-size: 18px;">護鎖刃龍先抬起側面的肢體開始蓄力，然後立刻躍起配合後撤步將身上的鎖鏈甩到目標位置，攻擊範圍不算大，只需要稍稍移動便可躲過攻擊。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074216810_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">單爪鎖鏈擊</span></p><p><span style="font-size: 18px;">比較常用的招式，鎖刃龍先是將要攻擊的翅膀與鎖刃蜷縮起來蓄力，然後朝玩家方向直接甩去。看到前搖動作就需要準備防禦或移動躲避了。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074219085_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖連甩擊</span></p><p><span style="font-size: 18px;">零幀起手，直接抬高手臂並依靠慣性朝下揮舞手臂將鎖鏈甩向玩家，鎖鏈本身較細攻擊判定範圍也不算大，但難以預判落點且前搖太短容易反應不及時，需要多打形成肌肉記憶才好打。同時這個召喚還有一個二連擊的變體，怪物會通過不同的爪子攻擊兩次。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074222047_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖鏈突刺</span></p><p><span style="font-size: 18px;">鎖刃龍跳到半空，擺出下圖所示姿勢將身上的鎖鏈甩到目標位置處，也就是突進一下再甩鎖鏈。可以靠地形直接躲過去，但這招的前搖不太明顯，容易在大意的時候直接被來一下。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074224366_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">甩尾</span></p><p><span style="font-size: 18px;">零幀起手且基本沒有前搖，躲避難度很高，需要有一定的肌肉記憶與對自身武器較高的熟練度才能應對。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/17407422634_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖刃爆擊</span></p><p><span style="font-size: 18px;">無需揮動雙爪即可進行的鎖刃攻擊，當鎖刃龍將某手臂的鎖刃揮動出去後暫時處於罰站狀態，揮出鎖刃的位置稍後會產生爆炸傷害。因此就算未被揮出的鎖刃打到也需要立刻遠離鎖刃的位置。</span></p><p><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074228990_n.jpg" class="fr-fic fr-dii" status="success"></p><p><br></p><p><br></p><p><span style="font-size: 18px;">爆氣</span></p><p><span style="font-size: 18px;">隨著高昂的嚎叫聲，護鎖刃龍的身體開始冒出白色火焰然後快速轉變為紅色並對其前方區域造成大範圍爆炸傷害，我們需要在顏色轉變為紅色前離開鎖刃龍的前方。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/17407423113_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">連跳</span></p><p><span style="font-size: 18px;">護鎖刃龍先是張開白色的鎖鏈並散發白色火焰，短暫蓄力後跳到半空中以不規則的路徑在空中使用鎖刃攻擊地面。看到鎖刃龍張開鎖刃並附有白色火焰時基本都是大範圍攻擊，需要立刻準備防禦或召喚坐騎遠離。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074233262_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖刃三連擊</span></p><p><span style="font-size: 18px;">護鎖刃龍以半身傾斜的姿勢開始蓄力，對前方區域先是左右兩連砍，然後跳到半空向下舞動鎖刃進行一次重擊，這招無論是前方還是側面都有極遠的傷害判定，看懂姿勢前搖建議立刻呼叫坐騎離開鎖刃龍附近範圍躲避。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074235543_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">來源：遊民星空</span></p>', CAST(N'2025-03-16T12:15:41.000' AS DateTime), NULL, N'存在')
INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (11, N'user013', 3, N'<p>哈哈</p>', CAST(N'2025-03-16T13:01:15.000' AS DateTime), CAST(N'2025-03-16T15:01:15.000' AS DateTime), N'刪除')
INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (13, N'user002', 1, N'<p>讚 T1</p>', CAST(N'2025-03-15T13:01:00.000' AS DateTime), NULL, N'草稿')
SET IDENTITY_INSERT [dbo].[Article] OFF
GO
SET IDENTITY_INSERT [dbo].[ArticleGroup] ON 

INSERT [dbo].[ArticleGroup] ([ArticleGroupID], [DiscussionID], [Category], [Views], [CoverImage], [ArticleTitle]) VALUES (1, 1, N'情報', 50, NULL, N'T1勝利宣言')
INSERT [dbo].[ArticleGroup] ([ArticleGroupID], [DiscussionID], [Category], [Views], [CoverImage], [ArticleTitle]) VALUES (2, 4, N'情報', 15, NULL, N'開版')
INSERT [dbo].[ArticleGroup] ([ArticleGroupID], [DiscussionID], [Category], [Views], [CoverImage], [ArticleTitle]) VALUES (3, 4, N'討論', 67, NULL, N'被「白之孤影」欺負，我決定要變強！')
SET IDENTITY_INSERT [dbo].[ArticleGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[ArticleMessage] ON 

INSERT [dbo].[ArticleMessage] ([ArticleMessageID], [ArticleID], [UserID], [MessageContent], [EditDate]) VALUES (1, 7, N'user098', N'這代魔物比較簡單還打不過', CAST(N'2025-03-19T09:39:20.740' AS DateTime))
INSERT [dbo].[ArticleMessage] ([ArticleMessageID], [ArticleID], [UserID], [MessageContent], [EditDate]) VALUES (2, 7, N'user095', N'樓上很兇', CAST(N'2025-03-19T09:40:31.653' AS DateTime))
INSERT [dbo].[ArticleMessage] ([ArticleMessageID], [ArticleID], [UserID], [MessageContent], [EditDate]) VALUES (3, 8, N'user097', N'素晴らしい', CAST(N'2025-03-19T09:43:47.517' AS DateTime))
SET IDENTITY_INSERT [dbo].[ArticleMessage] OFF
GO
SET IDENTITY_INSERT [dbo].[Discussion] ON 

INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (1, N'英雄聯盟', N'英雄系統
 
英雄大致分為四個種類【坦克型】、【物理攻擊型】、【法術攻擊型】、【輔助型】，每隻英雄都有多變的玩法，沒有局限，玩家可以依照自己的喜好，變化出不同的英雄型態。
 
增加速度又具平衡性
 
目前英雄共有120位，並會詳細的介紹英雄的故事及淵源，在英雄推出後原廠會針對新英雄的平衡度，進行反覆的評估，適時的進行調整，維持整體遊戲的平衡。', N'discussion/LOL.png', 1532, N'PC')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (4, N'魔物獵人', N'《魔物獵人 荒野》為《魔物獵人》系列最新作，遊戲承襲了《魔物獵人 世界》的路線，同時導入騎乘怪獸高速奔馳、飛行與狩獵的嶄新玩法。

　　狂野兇猛的大自然，襲來。

　　一個時刻都在動態變化的原野。這是個關於生活在具有兩面性的世界裡之魔物和人們的故事。

　　作為一名以狩獵強大魔物為生的「獵人」，你將利用狩獵中獲得的素材製造出更強大的武器和防具，並解開那個世界與人們之間的關連。

　　得以進化的狩獵動作，以及追求不間斷的沉浸感之極致的狩獵體驗正在等待著您。', N'discussion/mhws.jfif', 5228, N'家機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (5, N'惡靈古堡', N'故事設定在惡靈古堡2和3的1998年秋天，拉昆市爆發感染T病毒的時期
遊戲以小隊團體行動為主軸，玩家扮演安佈雷拉安全部隊(USS)的成員
以毀滅所有與T病毒有關包含倖存者在內等所有證據做為目的', N'discussion/20.jfif', 600, N'家機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (6, N'神魔之塔', N'　由 Mad Head Limited 開發的《神魔之塔》，是一款集寶石消除和召喚獸收集、育成於一體的角色扮演手機遊戲。

　　《神魔之塔》以古人類為了成為神而建造了能通向天界的以諾塔作主題，講述在建塔的過程中，惡魔欲利用以諾塔入侵天界。而身為召喚師的玩家肩負了解開召喚獸封印的重任，一步一步登上塔頂，尋找神的協助。
', N'discussion/tos.jfif', 4684, N'手機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (7, N'貓咪大戰爭', N'　　西元 2013 年，一群不曉得哪來的神祕「貓咪軍團」突然向日本列島發動進攻，讓全國上下陷入了前所未有的恐慌之中，眼看一場橫跨日本 47 個都府道縣、雞飛夠跳的戰爭就要開打，人類最終將會被貓咪們所征服嗎？', N'discussion/cat.jfif', 2513, N'手機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (8, N'崩壞：星穹鐵道', N'　《崩壞：星穹鐵道》是 HoYoverse 最新推出的銀河冒險 RPG 遊戲。在本作中，玩家將乘坐「星穹列車」體驗銀河間光怪陸離的奇幻景色，冒險和刺激構成了旅途的主要旋律。

　　玩家在各世界將邂逅新的夥伴，也會與熟悉的面孔重逢，攜手解決由「星核」引發的紛爭，並最終揭開它的奧秘。', N'discussion/road.jfif', 4153, N'手機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (9, N'怪物彈珠', N'
　　遊戲的戰鬥系統採回合制，由我方四個怪獸輪流發動攻擊，而攻擊的操作方式就是玩家觸押畫面任一處，並朝著攻擊目標的反方向向後滑動，此時會出現箭頭來輔助瞄準的路徑。', N'discussion/ms.jfif', 3841, N'手機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (10, N'Pokemon GO', N'
　　玩家在這款遊戲中將成為神奇寶貝訓練師，利用地理定位資訊，在現實世界中移動、探索、捕捉神奇寶貝，也要與其他陣營（共 3 個陣營）互相爭奪道館，可說是活用了《Ingress 虛擬入口》平台架構的作品。', N'discussion/pkmgo.jfif', 3151, N'手機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (11, N'新楓之谷', N'官方指出，《新楓之谷》史無前例地全面翻新遊戲架構與內容，在升級速度、職業平衡、技能平衡、戰鬥公式、地圖設計等內容都做了全面性的更新調整，希望能帶給玩家全新的冒險感動。', N'discussion/nms.jfif', 3485, N'PC')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (12, N'流亡黯道 Path of Exile', N'　在遊戲中玩家無法學習到自身的主動技能，僅能透過屬性技能寶石鑲嵌在裝備上來使用，這樣的好處是在使用技能上變得相當自由，變更裝備就能使用各式各樣的技能，但也因此相關道具變得非常珍貴，所以收集屬性技能寶石與可鑲嵌裝備就變成重要的遊戲目的。另外，目前屬性技能寶石分成力量（紅色）、敏捷（綠色）、智力（藍色）3 種，玩家可根據角色的屬性來做挑選。', N'discussion/poe.jfif', 2481, N'PC')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (13, N'爐石戰記', N'這款以魔獸世界為背景設定的卡片對戰遊戲《爐石戰記：魔獸英雄傳》，和最初的《魔獸世界》一樣，牌組也分成了九大職業，分別是大家熟悉的戰士、法師、牧師、德魯伊、術士、盜賊、獵人、薩滿、聖騎士。而這九大職業都有一名知名的英雄人物作為代表。', N'discussion/hs.jfif', 2105, N'PC')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (14, N'幻獸帕魯', N'《始世樂土（Craftopia）》獨立研發團隊 Pocketpair 旗下結合蒐集生物、創造生存元素的新作《幻獸帕魯 PalWorld》，是以名為「Pal（パル）」不可思議生物為主題，玩家將在開放世界中蒐集這種生物，讓牠們從事戰鬥、建築、農業或在工廠生產等。', N'discussion/palworld.jfif', 1025, N'PC')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (15, N'鬥陣特攻', N'《鬥陣特攻 2》是《鬥陣特攻》有史以來最重大的更新版本，本次更新會以搶先體驗打頭陣，讓玩家遊玩全新的 PvP 體驗、全新英雄與地圖以及前所未見的免費遊玩模式，主打全新五對五多人遊戲模式，並支援跨平台連線遊玩和跨平台進度共享。製作團隊強調，《鬥陣特攻 2》的PvP 體驗將透過全新的免費遊玩架構，帶來令人耳目一新的對戰玩法設計，並推出大幅更新遊戲內容，例如新英雄、英雄重製、地圖、模式及酷炫造型物品。', N'discussion/ow.jfif', 912, N'PC')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (16, N'俠盜獵車手 系列', N'　《俠盜獵車手 5》PS4版將運用新世代硬體的處理能力，帶來視覺與技術上的大幅強化，呈現更生動逼真的洛聖都（Los Santos）與佈雷恩郡（Blaine County）景觀，提供更遠的繪圖景深與更高的解析度。', N'discussion/GTA.jfif', 2184, N'家機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (18, N'艾爾登法環（Elden Ring）', N'　《艾爾登法環 黑夜君臨》承襲大受好評的《艾爾登法環》世界觀設定，包含舞台、敵人、武器等，並採用全新的多人協力生存動作玩法。最多 3 名玩家將可以操作各具特色的角色，攜手面對新的威脅。', N'discussion/elder.jfif', 1584, N'家機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (19, N'天堂 Mobile', N'　　《天堂 M》以線上遊戲《天堂》為藍本，除收錄原作職業外、亦搭載玩家熟悉的「血盟」社群系統，並在經典場景「亞丁城」中結合大規模狩獵、血盟攻城戰等核心元素。手機版《天堂 M》預計採用特別設計的操作介面，並強化視覺效果，方便玩家更自由自在地重溫《天堂》冒險旅程。', N'discussion/lm.jfif', 3475, N'手機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (20, N'原神', N'《原神》是由米哈遊開發的開放世界冒險遊戲，以被稱作「提瓦特」的幻想世界為舞台。在這個世界中，神選之人將被授予「神之眼」，導引元素之力。玩家將扮演一位名為「旅行者」的神秘角色，在自由的旅行中邂逅性格各異、能力獨特的同伴，並與同伴攜手擊敗強敵，找回失散的親人，逐步發掘「原神」的真相。', N'discussion/gs.jfif', 3108, N'手機')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (22, N'傳說對決 Arena of Valor', N'《傳說對決 Arena of Valor》是由 Garena 與天美工作室所合作開發，是一款能讓 10 位玩家同場競技的多人對戰 MOBA 手遊。簡單好上手的操作方式、細膩的畫風與高品質的遊戲畫面、多樣化的英雄與遊戲模式，無論你是操作華麗的神手玩家，或是想與三五好友輕鬆對戰的休閒玩家，都不能錯過襲捲台港澳的傳說風潮！', N'discussion/aov.jfif', 2184, N'手機')
SET IDENTITY_INSERT [dbo].[Discussion] OFF
GO
SET IDENTITY_INSERT [dbo].[HistoricalVisitors] ON 

INSERT [dbo].[HistoricalVisitors] ([HistoricalVisitorID], [OwnerID], [VisitorID], [VisitTime]) VALUES (1, N'user001', N'user002', CAST(N'2025-02-14T15:11:06.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[HistoricalVisitors] OFF
GO
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([NewsID], [NewsTitle], [NewsContent], [ImageUrl], [EditDate], [Category]) VALUES (1, N'《魔物獵人 荒野》正式版內容搶先剖析 動作和生態系表現全面升級！', N'背負著眾多獵人的殷殷期盼，讓新世代顯卡缺貨雪上加霜的超人氣狩獵動作遊戲最新作《魔物獵人 荒野》（PS5 / Xbox Series X|S / PC）終於即將在 2 月 28 日正式發售啦！
	這次的《魔物獵人 荒野》不只是系列首次在 PC 和主機平台同步發售，在兩次 Beta 中展現的諸多新魔物和新武器招式，更是讓全球獵人都迫不及待想要玩到正式版。本次巴哈姆特也幸運地拿到正式版的試玩資格，並將遊戲完整通關了一輪。所以現在就讓我們以正式版的試玩經驗，在官方限制的解禁範圍內，為各位分享一下對這片新作的感想吧！
	
　　《魔物獵人 荒野》的故事舞台建立在一個神祕的封禁之地。據稱千年前這裡曾有個大國，但因為不明原因毀滅。獵人公會在調查這塊土地的途中，撿到一名自稱是「守護者一族」的小男孩拿塔，並從他口中得知一頭被稱為「白之孤影」的神祕魔物毀了他的村莊，而這頭魔物很有可能是傳說中的滅絕種。於是決定救援守護者一族的公會，將玩家任命為調查隊的獵人，必須踏遍整個封禁之地，找到白之孤影和守護者村莊的下落。

　　這次《魔物獵人 荒野》的主線遠比以往的舊作更加故事導向，不只是有明確的主軸、大量的動畫演出，敘事方式也比以往有邏輯。在鋪陳魔物出場劇情時，也會講述他們是受到了什麼影響或做了什麼才會必須被玩家狩獵、NPC 也多了更多刻劃的餘裕。雖然總長度依然有限，但好歹也是徹徹底底的把主線到後日談一次講完，完整敘述一整個關於封禁之地的故事。至少比《魔物獵人 崛起》Switch 版剛發售時，那卡一半的劇情感覺好多了。
　另外有一個小抱怨，那就是極少部分的劇情中，即便進入自由操作，玩家也無法切換地圖、甚至無法製作裝備和購買補品，這部分與以往只有村莊和出門狩獵兩種狀態的邏輯不太一樣。雖然不確定是否是 BUG，但還是建議玩家在推進劇情前優先整備好，免去中間還要放棄任務的尷尬。
	', N'/img/News/MHW001.jpg', CAST(N'2025-02-24T23:00:01.000' AS DateTime), N'TV')
INSERT [dbo].[News] ([NewsID], [NewsTitle], [NewsContent], [ImageUrl], [EditDate], [Category]) VALUES (2, N'《Monster Hunter Now》SEASON 5「劃破春日的劍尾」正式登場 追加斬龍與青熊獸', N'Niantic 宣布，真實世界狩獵動作遊戲《Monster Hunter Now》（iOS / Android）SEASON 5「劃破春日的劍尾」現已正式登場，本次更新了大量內容，包括斬龍和青熊獸登場、追加新技能，以及向上修正部分武器類型與技能等等。

　　官方表示，除了老獵人與新手獵人的熱情支持，這次更邀請了來自不同領域的知名玩家，一同踏入《Monster Hunter Now》的世界。無論是「熱狗王」（新手獵人 HR30）、「鐵牛」（全能型 HR246）、「JOJO 啾啾」（輕弩專精 HR147）、還是「六嘆」（長槍愛好者 HR206），他們都將挑戰各種魔物，展現獵人的狩獵精神。
　　將追加「魔物出現任務」。完成此任務後，於過去 SEASON 登場的魔物就會出現在原野上。
	＜魔物出現任務的完成方式＞


　　新 SEASON 開始後，將開放以於過去 SEASON 登場的魔物為對象的魔物出現任務。完成指定任務後，討伐的魔物將永久出現在原野上。	
', N'/img/News/MHN.jpg', CAST(N'2025-03-14T13:44:46.860' AS DateTime), N'手機')
INSERT [dbo].[News] ([NewsID], [NewsTitle], [NewsContent], [ImageUrl], [EditDate], [Category]) VALUES (3, N'《天堂 M》「新篇章 2.0」改版 3/19 登場 槍手職業全面覺醒', N'遊戲橘子代理的手機遊戲《天堂 M》宣布將於 3 月 19 日推出上半年最大改版，重磅推出新篇章 2.0：六大全新經驗加速服，為新手及回歸玩家提供最佳的成長環境；天堂經典的「傳送控制戒指」亦同步登場，帶領玩家重溫最初的感動。槍手覺醒搭配技能全面優化，免費轉職活動限時開跑！台版專屬的「血盟終極競賽」即將引爆，官方祭出史上最大金額的藍鑽禮包，三大玩法等待最強血盟一決高下。此外，為幫助玩家全力成長，官方也準備多樣改版獎勵，包含玩家眾所期盼的七張 GAMA COUPON 如「特殊魔法娃娃合成 / [新篇章] 魔法娃娃合成」、「特殊變身合成 / [新篇章] 變身合成」、「特殊聖物合成 / [新篇章] 聖物合成」等，且所有伺服器的玩家根據對應步驟，還能獲得抽卡包、「亞丁騎士團的裝備箱 (活動)」、「+3 倫提斯耳環選擇箱 (活動)」等豐富獎勵。
　《天堂 M》遠距職業睽違已久迎來更新，槍手職業全面覺醒，職業技能大幅強化，開創更靈活的遠程戰鬥模式，重點技能優化說明如下。
 
智能射擊：技能優化；新增「智能瞄準」系統，讓戰鬥操作更加順暢。
絕對零度：全新技能；使用「冰結子彈」，強化主要魔法的冰凍效果。
魔力射擊：全新技能；啟用「裝填子彈系統」，連續使用魔法子彈進行高爆發攻擊。
冰凍榴彈：技能優化；發射範圍型的「寒冰攻擊」，在目標地點形成「寒氣地帶」。
 
　　此外，免費轉職活動限時展開，Lv.75 以上之玩家可於特定伺服器商城以 3,000 金幣購買轉職道具；可轉換的英雄級技能數量亦提升至 6 個，並增加血盟獨特傳說級技能。同步新增販售槍手血盟商人技能書「(英雄級) 技術教本 - 死亡狙擊」。
', N'/img/News/Heaven001.jpg', CAST(N'2025-03-17T19:32:36.000' AS DateTime), N'手機')
INSERT [dbo].[News] ([NewsID], [NewsTitle], [NewsContent], [ImageUrl], [EditDate], [Category]) VALUES (4, N'《聯盟戰棋》預定 4 月 2 日推出「機動魔都」 研發團隊公布特色介紹影片', N'Riot Games 今日宣布，《聯盟戰棋》棋組「機動魔都」即將於台灣時間 4 月 2 日更新的 14.1 版本中登場，在「機動魔都」版本中以霓虹都會為背景，眾多陣營為了爭奪地盤而展開永無止盡的派系戰爭，玩家必須捍衛自己的組織、擴張領土，以達成主宰城市的夢想。
    在「機動魔都」中帶來多種新特性，像是街頭狂魔，這是用塗鴉填滿街道的惡棍，他們可以塗鴉街道、賦予英雄多種狀態效果；百獸特攻隊則是隨著特性等級提升、可以獲得更強大的武器選項；罪惡集團會讓玩家在擁有 3、5、7 名相關英雄時觸發，每個罪惡集團的英雄獲得黑街霸主帽子時，將可以升級獨特技能；開運金牛的特性則是與金錢相關，玩家要賺入金幣投入其中才能獲得永久傷害增幅加成，這個設計主題是「賺得多、花得多」；破譯師特性則是即使在戰鬥中落敗，也能蒐集情報，並利用情報來獲取戰利品。
    詳細特性介紹，有興趣的玩家可參考官方說明。另外，官方還介紹了進入「機動魔都」的「兇惡威脅」型 5 費英雄蓋倫與札克，前者可以提供單位特性調整、還是可靠的前排，而札克作為威脅型單位，可以分裂，還可以施放技能跳到鄰近敵軍身上造成傷害與對敵人造成短暫暈眩等，以下為官方今日公布的介紹影片。', N'/img/News/TFT001.jpg', CAST(N'2025-03-17T11:06:36.000' AS DateTime), N'PC')
INSERT [dbo].[News] ([NewsID], [NewsTitle], [NewsContent], [ImageUrl], [EditDate], [Category]) VALUES (5, N'《MLB 勁旅對決》揭開三位全球代言人 預告將推出排名戰錦標賽更新', N'　Com2uS 公布旗下人氣棒球手機遊戲《MLB 勁旅對決》三位全球代言人，並預告即將帶來全新賽季更新及活動。
《MLB 勁旅對決》是 Com2uS 集結超過 20 年的開發經驗與技術推出的全球人氣手機棒球遊戲。基於 MLB 官方授權，透過生動的畫質及各種內容，為玩家帶來極致的對戰樂趣。
在準備迎接 2025 賽季開幕之際，《MLB 勁旅對決》公布了三位全球代言人。繼連續兩年擔任代言人的舊金山巨人隊李政厚、洛杉磯道奇隊山本由伸之後，大聯盟代表打者費城費城人隊 Bryce Harper 也加入陣容，玩家可與這些頂尖球員一同暢玩《MLB 勁旅對決》。
 　Bryce Harper 於 2010 年以美國職棒選秀會全體首輪第一順位投入職業生涯，曾兩度獲得國聯 MVP，並以外野手、指定打擊、一壘手等多個位置獲得 4 次銀棒獎，目前已連續 13 年擊出雙位數全壘打。特別是去年也入選明星賽，深受球迷支持。
 Com2uS 除了宣布為 2025 賽季的全球代言人外，也預告了全新的排名戰錦標賽更新。每場錦標賽採用七戰四勝制決定勝負，獲勝的玩家將晉級下一輪錦標賽以決出最終優勝者。賽季結束時將根據最終晉級階段發放豐富獎勵。
 　此外，遊戲也將舉辦活動紀念在日本東京舉行的「MLB Tokyo Series presented by Guggenheim」。官方預計推出可獲得遊戲內最高階級球員卡的各種豐富活動，還同時準備了可獲得新任代言人「Bryce Harper」等球員的活動，請玩家敬請期待。
', N'/img/News/MLB001.jpg', CAST(N'2025-03-14T17:10:17.000' AS DateTime), N'手機')
INSERT [dbo].[News] ([NewsID], [NewsTitle], [NewsContent], [ImageUrl], [EditDate], [Category]) VALUES (6, N'SNK 格鬥新作《餓狼傳說 City of the Wolves》實體版今日起開放預約', N'株式會社 SNK（本社：大阪府大阪市、代表取締役社長 CEO：松原 健二）宣布，2025 年 4 月 24 日（週四）發售的新作格鬥遊戲《餓狼傳說 City of the Wolves》實體版（PlayStation 5 / PlayStation 4）已開放預約。

　　SNK 的人氣格鬥遊戲《餓狼傳說》系列自 1991 年誕生以來一直引領著 90 年代格鬥遊戲的熱潮。從 1999 年的《餓狼 -MARK OF THE WOLVES-》起，時隔 26 年，系列的最新作品《餓狼傳說 City of the Wolves》終於登場。
 
　　新搭載了刺激感性的獨特「美術風格」、加速了戰鬥興奮度的「REV 系統」、以及更加進化的「戰鬥系統」。此外，以從初學者到熟練者都能充分享受的 2 種操作方式為首，還準備了各種新功能和新元素。以充滿慾望的南鎮為舞台，新的「傳說」即將開始。

　　集遊戲本篇與「SEASON PASS 1」於一體的套裝「SPECIAL EDITION」，售價為新台 1,840 元 / 港幣 500 元。
商品?容：
遊戲本篇
SEASON PASS 1
DLC 角色「安迪?博加德」（2025 年夏季上線預定）
DLC 角色「肯」（2025 年夏季上線預定）
DLC 角色「東丈」（2025 年秋季上線預定）
DLC 角色「春麗」（2025 年冬季上線預定）
DLC 角色「Mr.BIG」（2026 年初上線預定）', N'/img/News/Fighter001.jpg', CAST(N'2025-03-14T16:09:56.000' AS DateTime), N'PC')
SET IDENTITY_INSERT [dbo].[News] OFF
GO
SET IDENTITY_INSERT [dbo].[NewsImage] ON 

INSERT [dbo].[NewsImage] ([NewsImageID], [NewsID], [ImageUrl]) VALUES (1, 1, N'/img/News/MHW001.jpg')
INSERT [dbo].[NewsImage] ([NewsImageID], [NewsID], [ImageUrl]) VALUES (2, 2, N'/img/News/HHN.jpg')
INSERT [dbo].[NewsImage] ([NewsImageID], [NewsID], [ImageUrl]) VALUES (3, 3, N'/img/News/Heaven001.jpg')
INSERT [dbo].[NewsImage] ([NewsImageID], [NewsID], [ImageUrl]) VALUES (7, 4, N'/img/News/TFT001.jpg')
SET IDENTITY_INSERT [dbo].[NewsImage] OFF
GO
SET IDENTITY_INSERT [dbo].[NewsMessage] ON 

INSERT [dbo].[NewsMessage] ([NewsMessageID], [NewsID], [UserID], [MessageContent], [EditDate]) VALUES (1, 1, N'user001', N'簽', CAST(N'2025-01-05T15:00:01.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[NewsMessage] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [UserID], [ProductID], [Quantity], [OrderDate], [OrderStatusID], [ShippingAddress]) VALUES (1, N'user001', 1, 1, CAST(N'2025-02-27T09:45:54.847' AS DateTime), 1, N'台北市信義區')
INSERT [dbo].[Order] ([OrderID], [UserID], [ProductID], [Quantity], [OrderDate], [OrderStatusID], [ShippingAddress]) VALUES (2, N'user002', 2, 2, CAST(N'2025-02-27T09:45:54.847' AS DateTime), 2, N'高雄市左營區')
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([OrderStatusID], [Status]) VALUES (1, N'處理中')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [Status]) VALUES (2, N'已出貨')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [Status]) VALUES (3, N'已完成')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [Status]) VALUES (4, N'取消')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (1, N'遊戲鍵盤', N'RGB背光機械鍵盤，適合電競玩家', N'../img/product/mainImg/306GK7YF10.jpg', 2990, 1, 50, 10, 4.5)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (2, N'PS5 遊戲點數卡', N'適用於 PlayStation 5，購買遊戲或訂閱服務', N'../img/product/mainImg/97f39860d771a87c21972e0c0f1snyv5.JPG', 1000, 2, 100, 20, 4.8)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (14, N'魔物獵人 荒野', N'《魔物獵人 荒野》中文一般版', N'../img/product/mainImg/EkAUYeYG.jpg', 1890, 5, 201, 149, 4.9)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (15, N'Super Technos World 熱血系列與街機經典收藏版', N'《Super Technos World 熱血系列與街機經典收藏版》日英文合版', N'../img/product/mainImg/0h39rA8X.jpg', 990, 6, 50, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (16, N'人中之龍 8 外傳 夏威夷海盜 中文', N'《人中之龍 8 外傳 夏威夷海盜》中文一般版 遊戲', N'../img/product/mainImg/c1okbarA.jpg', 1390, 5, 56, 44, 4.9)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (17, N'印第安納瓊斯：古老之圈', N'《印第安納瓊斯：古老之圈》中文一般版', N'../img/product/mainImg/R6MsvYML.jpg', 1990, 7, 50, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (18, N'魔物獵人 荒野》艾路 Q 版絨毛玩偶', N'「《魔物獵人 荒野》艾路 Q 版絨毛玩偶」一個。（約 20cm x 12cm x 12cm）', N'../img/product/mainImg/8rCrNcpr.jpg', 960, 3, 5, 1, 5)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (20, N' 《大富翁 10》中文版（數位下載版）', N'「《大富翁 10》中文版 下載序號」一組。', N'../img/product/mainImg/Z3RAF8ap.jpg', 399, 4, 54, 11, 4.8)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (22, N'amiibo 人偶玩具：路易吉（超級瑪利歐系列）', N'任天堂全新週邊玩偶「amiibo」，內建有「NFC（近距離無線通信）」感應器，當玩家遊玩有支援該機能的作品時，可以跟遊戲產生互動，平時又可當作收藏品擺飾。', N'../img/product/mainImg/iDcNoftp.jpg', 590, 3, 5, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (23, N'《鬼滅之刃 火之神血風譚》中文究極版（數位下載版）', N'．「《鬼滅之刃 火之神血風譚》中文究極版 下載序號」一組。
　※ 收錄以下內容：
　-《鬼滅之刃 火之神血風譚》中文版 主程式
　- 角色通行證
　- 早期開放資格（可以提早開放 “鬼滅學園” 版本的竈門炭治郎、竈門襧豆子、我妻善逸、嘴平伊之助）
　- 遊戲內服裝 “蝴蝶屋病人服”（適用於竈門炭治郎、我妻善逸、嘴平伊之助）
　- 個人造型 12 種
　- 鬼滅點數 8,000 點
　- 高解析度 PC 桌布', N'../img/product/mainImg/JaqpSmLn.jpg', 2590, 4, 100, 0, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([ProductCategoryID], [Category]) VALUES (1, N'電腦周邊')
INSERT [dbo].[ProductCategory] ([ProductCategoryID], [Category]) VALUES (2, N'遊戲點數卡')
INSERT [dbo].[ProductCategory] ([ProductCategoryID], [Category]) VALUES (3, N'收藏品')
INSERT [dbo].[ProductCategory] ([ProductCategoryID], [Category]) VALUES (4, N'數位遊戲')
INSERT [dbo].[ProductCategory] ([ProductCategoryID], [Category]) VALUES (5, N'PS5')
INSERT [dbo].[ProductCategory] ([ProductCategoryID], [Category]) VALUES (6, N'NS')
INSERT [dbo].[ProductCategory] ([ProductCategoryID], [Category]) VALUES (7, N'Xbox')
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Relationships] ON 

INSERT [dbo].[Relationships] ([RelationshipID], [PersonAID], [PersonBID], [RelationshipType]) VALUES (1, N'user001', N'user002', N'Accepted')
INSERT [dbo].[Relationships] ([RelationshipID], [PersonAID], [PersonBID], [RelationshipType]) VALUES (2, N'user001', N'user003', N'Removed')
INSERT [dbo].[Relationships] ([RelationshipID], [PersonAID], [PersonBID], [RelationshipType]) VALUES (3, N'user001 ', N'user004', N'Following')
SET IDENTITY_INSERT [dbo].[Relationships] OFF
GO
SET IDENTITY_INSERT [dbo].[ShoppingCart] ON 

INSERT [dbo].[ShoppingCart] ([ShoppingCartID], [UserID], [ProductID], [Quantity]) VALUES (1, N'user001', 1, 1)
SET IDENTITY_INSERT [dbo].[ShoppingCart] OFF
GO
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user001', N'$2b$12$wPWHGjlELbF/3zAjCF1svey1qJdeLbndVuvn2.ESEpRN3pUywzWNW', N'玩家一號', N'photo1.jpg', N'M', CAST(N'1990-01-01T00:00:00.000' AS DateTime), N'雲林縣斗六市民生路 88 號', N'user001@example.com', N'0912345678', CAST(N'2025-02-27T09:45:54.847' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user002', N'$2b$12$7eV9kxbXw3DbN6fyYKrPF.DA2ppGPRhW8vlB97mdc4QXdhbJ0JwYO', N'高手二號', N'photo2.jpg', N'F', CAST(N'1995-05-20T00:00:00.000' AS DateTime), N'台東市正氣路 99 號', N'user002@example.com', N'0923456789', CAST(N'2025-02-27T09:45:54.847' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user003', N'$2b$12$2bQ8Ykrs2PxRQbP2OF4z3uzOPIsgLUyf3c9ky0FGXunyLpdmlU6mC', N'黑夜獵手3', NULL, N'F', CAST(N'1991-03-25T00:00:00.000' AS DateTime), N'高雄市鼓山區美術東三路 12 號', N'user3@gmail.com', N'0986819999', CAST(N'2025-03-14T02:21:52.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user004', N'$2b$12$vu4eaoVmAFeQXaQDIyTsEueBM2dO00UTQARNjSYP0spfqCK78qdlO', N'上單帝王4', NULL, N'M', CAST(N'1999-07-22T00:00:00.000' AS DateTime), N'新竹市東區關新路 134 號', N'user4@hotmail.com', N'0992548659', CAST(N'2025-03-14T02:21:52.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user005', N'$2b$12$D5u1HiBagTyDgtFDNNtC4.62P6P.43/QAxZ.gBU.w2o8MvZlHIRMq', N'幻影獵人5', NULL, N'F', CAST(N'2005-08-03T00:00:00.000' AS DateTime), N'花蓮市中正路 300 巷 15 號', N'user5@yahoo.com', N'0915090524', CAST(N'2025-03-14T02:21:53.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user006', N'$2b$12$icieJlUp6Ucw9abzl1VwwepVKxR3HAYBUyA7LNyzvG67EN8QEiI9W', N'我愛英雄聯盟6', NULL, N'M', CAST(N'1987-04-14T00:00:00.000' AS DateTime), N'台中市北區學士路 150 巷 10 號', N'user6@hotmail.com', N'0947418984', CAST(N'2025-03-14T02:21:53.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user007', N'$2b$12$2SGP7kZwgIViv0z2lW3GyOmYZF6p2yhAzFC2UbaKOMPs0wDSs5Vlu', N'雷霆戰將7', NULL, N'F', CAST(N'1988-11-14T00:00:00.000' AS DateTime), N'台中市西屯區台灣大道三段 255 號', N'user7@yahoo.com', N'0955093282', CAST(N'2025-03-14T02:21:53.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user008', N'$2b$12$ySrepKFA.mZMcyYSLflYpO2jBG558t9BD9Nj6y5ixkD7CSxRU71Cy', N'影子刺客8', NULL, N'F', CAST(N'1996-05-02T00:00:00.000' AS DateTime), N'台北市大安區復興南路一段 123 號', N'user8@yahoo.com', N'0975393272', CAST(N'2025-03-14T02:21:54.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user009', N'$2b$12$a8ZyVAcLvKtf1DnGi0Qh0u5HS/FujA4iDkI/dnfqndg5dTKzpzL3a', N'雷霆戰將9', NULL, N'M', CAST(N'2002-12-11T00:00:00.000' AS DateTime), N'彰化市中山路二段 45 巷 5 號', N'user9@gmail.com', N'0955956197', CAST(N'2025-03-14T02:21:54.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user010', N'$2b$12$VDtD/f/VeaMmrcUTBBr9Uu9lPV5SYf/0mKFLiZJFiZY3WHxF47CHC', N'我愛英雄聯盟10', NULL, N'M', CAST(N'1989-06-14T00:00:00.000' AS DateTime), N'嘉義市東區南京路 68 號', N'user10@outlook.com', N'0972365724', CAST(N'2025-03-14T02:21:54.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user011', N'$2b$12$sc81/JmSXjcEuDY2RS.5p.Ya7H.5xHA7OSMeq9Xutn2.oX5r.vlQi', N'戰場指揮官11', NULL, N'F', CAST(N'2004-11-03T00:00:00.000' AS DateTime), N'台北市士林區中山北路六段 88 號', N'user11@hotmail.com', N'0930408048', CAST(N'2025-03-14T02:21:55.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user012', N'$2b$12$YqFn1/VoERo7E2ZTKQnOd.FEFwjkGeYbhxZqsAOHHkOxK/Y9rraDK', N'狂風騎士12', NULL, N'M', CAST(N'1998-06-16T00:00:00.000' AS DateTime), N'台北市大安區復興南路一段 123 號', N'user12@gmail.com', N'0959504372', CAST(N'2025-03-14T02:21:55.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user013', N'$2b$12$xZJnm6VnXgG7nv5/QV9yWeY7TvaMo9Cc0KS9QSybP1XEQHAk.2GQy', N'極速射手13', NULL, N'F', CAST(N'1988-04-19T00:00:00.000' AS DateTime), N'花蓮市中正路 300 巷 15 號', N'user13@hotmail.com', N'0994152501', CAST(N'2025-03-14T02:21:55.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user014', N'$2b$12$Ov8fQc3DeEiz5G1OXHKQGefNXOtuPRlRb5bM8RwfPxCW1ZpNADskS', N'狂暴戰士14', NULL, N'F', CAST(N'1985-10-21T00:00:00.000' AS DateTime), N'台北市士林區中山北路六段 88 號', N'user14@gmail.com', N'0968780805', CAST(N'2025-03-14T02:21:56.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user015', N'$2b$12$lTOq24CIJApiNPOFaET2aO1l/fmxODNf1LzwkKh.NyceEWKGDS5qi', N'聖光牧師15', NULL, N'F', CAST(N'2000-08-22T00:00:00.000' AS DateTime), N'台北市士林區中山北路六段 88 號', N'user15@gmail.com', N'0938002741', CAST(N'2025-03-14T02:21:56.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user016', N'$2b$12$ftX3mI7v6NQPsWHI0o.6POE6ykHqjbT.zhM1nvzoYLecfkWUe3ppe', N'狂暴戰士16', NULL, N'F', CAST(N'1998-12-19T00:00:00.000' AS DateTime), N'宜蘭縣羅東鎮公正路 20 號', N'user16@gmail.com', N'0978144241', CAST(N'2025-03-14T02:21:56.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user017', N'$2b$12$vbnaBrEvSy7WwrVqCMtkuewMDos4abWNdPzBYhq4Io8e47ZouGm8y', N'冰霜法師17', NULL, N'F', CAST(N'1994-07-08T00:00:00.000' AS DateTime), N'屏東市自由路 120 巷 6 號', N'user17@outlook.com', N'0959654578', CAST(N'2025-03-14T02:21:57.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user018', N'$2b$12$3BrosyjPT7AU6wKMaWL.z.PPstsZLzVcyuSGof/YjzU96x337TP2O', N'戰場指揮官18', NULL, N'M', CAST(N'2005-03-22T00:00:00.000' AS DateTime), N'澎湖縣馬公市光華路 33 號', N'user18@outlook.com', N'0922932754', CAST(N'2025-03-14T02:21:57.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user019', N'$2b$12$LISxoCmMcKQeS32NRTPK5OASDU8/OVWBmJJG1CFZAZL3V3nZ3fKR.', N'上單帝王19', NULL, N'F', CAST(N'1995-04-21T00:00:00.000' AS DateTime), N'台中市西屯區台灣大道三段 255 號', N'user19@yahoo.com', N'0966322183', CAST(N'2025-03-14T02:21:57.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user020', N'$2b$12$3m7f4vw.mEJ6M8ucb2gbRuLD8ngwLFznRy3y606IOBCzvMyussFoq', N'幻影獵人20', NULL, N'M', CAST(N'1985-04-19T00:00:00.000' AS DateTime), N'彰化市中山路二段 45 巷 5 號', N'user20@gmail.com', N'0954251369', CAST(N'2025-03-14T02:21:58.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user021', N'$2b$12$zbVUFKWYbWuDm38E5rBzkOnG8Oawjm/M9td7mYo/wqC5tRZfcEeCW', N'火焰術士21', NULL, N'M', CAST(N'1987-03-15T00:00:00.000' AS DateTime), N'花蓮市中正路 300 巷 15 號', N'user21@gmail.com', N'0979634555', CAST(N'2025-03-14T02:21:58.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user022', N'$2b$12$R7SvVSPLIbiLiUTT/QDhTusyfJLwKO29jSakl4tpgTqUJ9fmdC.y.', N'LOL高手22', NULL, N'F', CAST(N'1998-01-02T00:00:00.000' AS DateTime), N'台中市北區學士路 150 巷 10 號', N'user22@hotmail.com', N'0942688488', CAST(N'2025-03-14T02:21:58.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user023', N'$2b$12$pbuGdzv3d/JtyCgxLsW4/eGuAGVtxlmStbbypRwHJDha6X1jtipg.', N'鋼鐵守衛23', NULL, N'F', CAST(N'1996-06-28T00:00:00.000' AS DateTime), N'台東市正氣路 99 號', N'user23@outlook.com', N'0924761958', CAST(N'2025-03-14T02:21:59.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user024', N'$2b$12$mwmwc9W5MWp194ZezdJoKOBQaX7f4/krGd93m0/7js9xkxMEK27Ai', N'影子刺客24', NULL, N'F', CAST(N'1994-04-25T00:00:00.000' AS DateTime), N'新北市板橋區文化路二段 45 巷 7 號', N'user24@yahoo.com', N'0976505546', CAST(N'2025-03-14T02:21:59.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user025', N'$2b$12$2vEpJAUBKUuF/BVgXAySA.24Buz.zhV/iWvABBiZb.xlJW89uTuSq', N'極速射手25', NULL, N'F', CAST(N'1994-03-07T00:00:00.000' AS DateTime), N'台東市正氣路 99 號', N'user25@gmail.com', N'0926233045', CAST(N'2025-03-14T02:21:59.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user026', N'$2b$12$HUX2dudPDtaC52gfLecRuOc4MOncC4lPVhtMyZquelnaqD3QeyI6C', N'風暴行者26', NULL, N'M', CAST(N'1994-04-01T00:00:00.000' AS DateTime), N'台南市中西區中正路 89 號', N'user26@outlook.com', N'0989367293', CAST(N'2025-03-14T02:22:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user027', N'$2b$12$Cxpo2BAd/jt0t07Yb5e0HeUu0TdpjALxzDVgJ/e1HyoSrLgbmC6x.', N'星辰遊俠27', NULL, N'M', CAST(N'1987-09-01T00:00:00.000' AS DateTime), N'屏東市自由路 120 巷 6 號', N'user27@gmail.com', N'0945782463', CAST(N'2025-03-14T02:22:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user028', N'$2b$12$RhL3pfK6BtIgCfgR/NU8GuIDPOdjDd.43py5jVjadxrc86zzDDDii', N'幻影獵人28', NULL, N'F', CAST(N'2001-06-12T00:00:00.000' AS DateTime), N'新竹市東區關新路 134 號', N'user28@yahoo.com', N'0918297682', CAST(N'2025-03-14T02:22:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user029', N'$2b$12$yFDyWHgbJ3Qn4ob3vifl8ungUALnpHyTFHx7AD/WUFj7P851ZLhBC', N'幻影獵人29', NULL, N'M', CAST(N'1985-12-02T00:00:00.000' AS DateTime), N'彰化市中山路二段 45 巷 5 號', N'user29@hotmail.com', N'0980276215', CAST(N'2025-03-14T02:22:01.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user030', N'$2b$12$5YZeALKG9AwVER1DJtxQsOuYebDr.CjZfCYD1XaC8SJFEuiL.PMYu', N'聖光牧師30', NULL, N'F', CAST(N'1999-06-06T00:00:00.000' AS DateTime), N'雲林縣斗六市民生路 88 號', N'user30@outlook.com', N'0948485249', CAST(N'2025-03-14T02:22:01.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user031', N'$2b$12$wGOaF3sJUQUcAp.z4tr47.63WINFdeqm7g57C8o9yRL5qd1E06Ej2', N'我愛英雄聯盟31', NULL, N'F', CAST(N'1987-07-26T00:00:00.000' AS DateTime), N'台北市大安區復興南路一段 123 號', N'user31@hotmail.com', N'0935427930', CAST(N'2025-03-14T02:22:01.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user032', N'$2b$12$.LZ5JWF31DP0KQDe6UIIauKND.yDgCk39ocwVgH7ncnK4yx4HIfB6', N'冰霜法師32', NULL, N'M', CAST(N'1998-02-11T00:00:00.000' AS DateTime), N'南投市中興路 68 號', N'user32@outlook.com', N'0975133971', CAST(N'2025-03-14T02:22:01.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user033', N'$2b$12$A/XXrTL9zkQP0o0SiI0SG.Nq4WeIx/Bh/sR6HhiUDylpSICG/MrrK', N'戰場指揮官33', NULL, N'M', CAST(N'1994-11-01T00:00:00.000' AS DateTime), N'屏東市自由路 120 巷 6 號', N'user33@hotmail.com', N'0928498223', CAST(N'2025-03-14T02:22:02.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user034', N'$2b$12$Dy6T7x/6pUIZVafmDU1XX.yuEQto1dRCij8Y2bOZWtDrLxddeeDQm', N'龍之騎士34', NULL, N'F', CAST(N'2004-04-12T00:00:00.000' AS DateTime), N'台北市大安區復興南路一段 123 號', N'user34@hotmail.com', N'0979527812', CAST(N'2025-03-14T02:22:02.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user035', N'$2b$12$cCUGSKhTcxBln3AeEZXiFelb0pfX.RIQrwIbuUHNKKyee6D47Gl4e', N'雷霆戰將35', NULL, N'M', CAST(N'1999-06-08T00:00:00.000' AS DateTime), N'高雄市鼓山區美術東三路 12 號', N'user35@gmail.com', N'0912801597', CAST(N'2025-03-14T02:22:02.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user036', N'$2b$12$8tdWopycrOa2kGz5biItluK/k1s5zeIlJGvM77GeIKcdEpZ/3oo0C', N'魔法學徒36', NULL, N'M', CAST(N'2002-09-24T00:00:00.000' AS DateTime), N'新北市板橋區文化路二段 45 巷 7 號', N'user36@hotmail.com', N'0919657788', CAST(N'2025-03-14T02:22:03.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user037', N'$2b$12$7fyu4NPNsvLYf/6ugg759O3Uxl42QY2Okc7OeLIOYDZdc02xwCuxW', N'狂暴戰士37', NULL, N'M', CAST(N'1996-02-17T00:00:00.000' AS DateTime), N'南投市中興路 68 號', N'user37@outlook.com', N'0934718810', CAST(N'2025-03-14T02:22:03.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user038', N'$2b$12$8xguHvAN3SkWVONB6qgSHeBEOXYqxVX/s6DSaJ5S7Uw9HpHWXh3O2', N'迅捷刺客38', NULL, N'F', CAST(N'2001-06-05T00:00:00.000' AS DateTime), N'台南市中西區中正路 89 號', N'user38@yahoo.com', N'0939353036', CAST(N'2025-03-14T02:22:03.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user039', N'$2b$12$HVItB3Wwk8hlw8X0WjcSjeSMAMfJWUNeQSIB..pUTQUBVPGK2c5wS', N'冰霜法師39', NULL, N'F', CAST(N'2001-12-27T00:00:00.000' AS DateTime), N'台中市西屯區台灣大道三段 255 號', N'user39@hotmail.com', N'0973542046', CAST(N'2025-03-14T02:22:04.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user040', N'$2b$12$Dn6yIpVaAToNII04I.OtcuX2sHg5dhGOG/bITDrwwQcfZsKmdPvGu', N'火焰術士40', NULL, N'M', CAST(N'2001-03-19T00:00:00.000' AS DateTime), N'花蓮市中正路 300 巷 15 號', N'user40@yahoo.com', N'0983766400', CAST(N'2025-03-14T02:22:04.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user041', N'$2b$12$odiudkZeA4STpk5056LFwO77HTiXWR68DifzNTyvgj3/HRhsuQyEa', N'神秘法師41', NULL, N'M', CAST(N'2002-12-02T00:00:00.000' AS DateTime), N'台東市正氣路 99 號', N'user41@yahoo.com', N'0955022694', CAST(N'2025-03-14T02:22:04.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user042', N'$2b$12$/Jx6U0j7L9C9Sk72kAz4UuPny18sl5Ljc4SXVOpZEqc2U4H0glN7y', N'LOL高手42', NULL, N'F', CAST(N'2000-05-17T00:00:00.000' AS DateTime), N'台南市中西區中正路 89 號', N'user42@yahoo.com', N'0931346715', CAST(N'2025-03-14T02:22:05.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user043', N'$2b$12$YxAXIju8tthOh5Jx9h.FFO2ksLV.nR98qRA3UvxHWWXKr4HUX3ku.', N'幻影獵人43', NULL, N'M', CAST(N'1987-11-05T00:00:00.000' AS DateTime), N'台中市西屯區台灣大道三段 255 號', N'user43@gmail.com', N'0962021245', CAST(N'2025-03-14T02:22:05.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user044', N'$2b$12$trPXdsNMLcQc97ZUzaZQguu6RhBOnh6.Zuoe4E.KPQL1TYvg7y0n.', N'我愛英雄聯盟44', NULL, N'M', CAST(N'1987-06-18T00:00:00.000' AS DateTime), N'南投市中興路 68 號', N'user44@yahoo.com', N'0921961243', CAST(N'2025-03-14T02:22:05.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user045', N'$2b$12$e1/joBF40p0icEANe5hNu.oWm1oKG.CUOelO.bjkL9YdntGBzqgdO', N'龍之騎士45', NULL, N'M', CAST(N'2004-05-13T00:00:00.000' AS DateTime), N'嘉義市東區南京路 68 號', N'user45@outlook.com', N'0918192253', CAST(N'2025-03-14T02:22:06.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user046', N'$2b$12$mbE1ip5qlbiCdhN9pnX4ouB9mDxJVjUXoftzzH54yxllW/v0/YcT2', N'影子刺客46', NULL, N'M', CAST(N'1994-08-09T00:00:00.000' AS DateTime), N'台南市中西區中正路 89 號', N'user46@hotmail.com', N'0974063855', CAST(N'2025-03-14T02:22:06.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user047', N'$2b$12$aH385NLYL10l3LN6gJF2J.OTQNZnlPm/TPDcja2b1YhpFJH.NfEtu', N'毀滅之刃47', NULL, N'F', CAST(N'2001-06-09T00:00:00.000' AS DateTime), N'台中市北區學士路 150 巷 10 號', N'user47@outlook.com', N'0968828190', CAST(N'2025-03-14T02:22:06.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user048', N'$2b$12$2mTQMSJ7E6zXnqkDqgBOTexo2VQ3r3nTZ3dHB6fygQvOYVrduOmXK', N'戰場指揮官48', NULL, N'M', CAST(N'1993-03-15T00:00:00.000' AS DateTime), N'台北市士林區中山北路六段 88 號', N'user48@outlook.com', N'0982683718', CAST(N'2025-03-14T02:22:07.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user049', N'$2b$12$MCwY8IypDvQhCgh6NpIUwO8LX4j/qNNcvti9s1oLHd.sKv/REgf/W', N'星辰遊俠49', NULL, N'M', CAST(N'1993-11-18T00:00:00.000' AS DateTime), N'高雄市鼓山區美術東三路 12 號', N'user49@yahoo.com', N'0956907451', CAST(N'2025-03-14T02:22:07.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user050', N'$2b$12$piEqndez779ptqdK3NXpG.Pr.RYOE3dZMXVjOr0deARuqi57YlOWO', N'雷霆戰將50', NULL, N'F', CAST(N'2003-12-15T00:00:00.000' AS DateTime), N'基隆市仁愛區愛三路 200 號', N'user50@gmail.com', N'0936899235', CAST(N'2025-03-14T02:22:07.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user051', N'$2b$12$NZ5TWqxmq1iN4UtukDqRQe8dKYbyN4sNbrLTGH5yKWEL6BJ/LruLu', N'影子刺客51', NULL, N'F', CAST(N'1999-01-23T00:00:00.000' AS DateTime), N'新竹市東區關新路 134 號', N'user51@outlook.com', N'0913609777', CAST(N'2025-03-14T02:22:08.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user052', N'$2b$12$eLCw2egMATuTpQncDEhOmeXUtikS2jC4CaK06WTDmUgtLyQpnP.uG', N'風暴行者52', NULL, N'M', CAST(N'1986-01-05T00:00:00.000' AS DateTime), N'基隆市仁愛區愛三路 200 號', N'user52@outlook.com', N'0996517915', CAST(N'2025-03-14T02:22:08.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user053', N'$2b$12$ID4NtrRi3Sx7g6JVAlXMdOWnnximgmbUrQT/MiYP66jHA.Tz02SL6', N'龍之騎士53', NULL, N'M', CAST(N'2002-01-24T00:00:00.000' AS DateTime), N'高雄市鼓山區美術東三路 12 號', N'user53@outlook.com', N'0948690961', CAST(N'2025-03-14T02:22:08.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user054', N'$2b$12$8Jy1DI2KaCoeXvN9kkfp/.RNAWJjXOAQtrGnzIIkvwmRutZ8hIbWS', N'星辰遊俠54', NULL, N'F', CAST(N'1999-06-12T00:00:00.000' AS DateTime), N'新竹市東區關新路 134 號', N'user54@yahoo.com', N'0946659819', CAST(N'2025-03-14T02:22:09.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user055', N'$2b$12$gGiqvrFiy.rnLrHVsZfA8eWsoOGZPNylNMcZGzeYAyYXWw5ikAgqq', N'LOL高手55', NULL, N'F', CAST(N'1991-08-23T00:00:00.000' AS DateTime), N'彰化市中山路二段 45 巷 5 號', N'user55@gmail.com', N'0974098363', CAST(N'2025-03-14T02:22:09.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user056', N'$2b$12$MWhCT4QXK5pE/ohu5J.7Q.SNDohEdBqctsokjYrKIldtx8/BggaeO', N'星辰遊俠56', NULL, N'F', CAST(N'1997-01-11T00:00:00.000' AS DateTime), N'金門縣金城鎮中正路 55 號', N'user56@outlook.com', N'0986704829', CAST(N'2025-03-14T02:22:09.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user057', N'$2b$12$AuNI1q1I0gxRXXvKKXilvOGPlgHt1xTQujzB89c8mnXuOj7Lz6Qd.', N'龍之騎士57', NULL, N'F', CAST(N'1994-11-05T00:00:00.000' AS DateTime), N'嘉義市東區南京路 68 號', N'user57@gmail.com', N'0991496095', CAST(N'2025-03-14T02:22:10.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user058', N'$2b$12$giD5Xbo7DiQ87ZHxsJRLButFxWzI7ARzXhX.41YAoT6HQZexffq1S', N'LOL高手58', NULL, N'F', CAST(N'1994-01-23T00:00:00.000' AS DateTime), N'桃園市中壢區元化路 76 號', N'user58@outlook.com', N'0957926452', CAST(N'2025-03-14T02:22:10.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user059', N'$2b$12$wEdzVjOpOa/DOCMpFTMJhuUaU0NMx6i716SKrVGZWqxZR7hVsKCAa', N'神秘法師59', NULL, N'M', CAST(N'1994-06-10T00:00:00.000' AS DateTime), N'高雄市鼓山區美術東三路 12 號', N'user59@gmail.com', N'0911092103', CAST(N'2025-03-14T02:22:10.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user060', N'$2b$12$eMPoGFkzz00zeUXKipgWg.WEuad1cDv8N4kGuFAqhWbrusHd/YlUi', N'神秘法師60', NULL, N'M', CAST(N'1985-09-16T00:00:00.000' AS DateTime), N'嘉義市東區南京路 68 號', N'user60@hotmail.com', N'0938765084', CAST(N'2025-03-14T02:22:11.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user061', N'$2b$12$uECO.Lye4OVL81J3Ok1XdOx6.yVLmTsiaJsjZI8j9FqE2Je74jyVi', N'影子刺客61', NULL, N'F', CAST(N'2004-04-02T00:00:00.000' AS DateTime), N'桃園市中壢區元化路 76 號', N'user61@outlook.com', N'0995300037', CAST(N'2025-03-14T02:22:11.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user062', N'$2b$12$HV8.6.GvqW.TZWSbtnN9tujZ.DnW5H9KnkW2Qm2InlR7DSTXq0Ok.', N'火焰術士62', NULL, N'F', CAST(N'2000-10-21T00:00:00.000' AS DateTime), N'高雄市鼓山區美術東三路 12 號', N'user62@hotmail.com', N'0934361759', CAST(N'2025-03-14T02:22:11.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user063', N'$2b$12$rJvbp6Z23Hp63dQgOAJIj.XR8LY3bO5M4OV2/Cp.E0Pi5op30JmjK', N'幻影獵人63', NULL, N'F', CAST(N'1996-06-23T00:00:00.000' AS DateTime), N'宜蘭縣羅東鎮公正路 20 號', N'user63@gmail.com', N'0968635318', CAST(N'2025-03-14T02:22:12.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user064', N'$2b$12$TtsJVXnn4nhE0/D05fS/Eu5u22Gmu21s.d94HLgxTaJSQV3GFbQOC', N'深淵潛行者64', NULL, N'M', CAST(N'2004-03-07T00:00:00.000' AS DateTime), N'基隆市仁愛區愛三路 200 號', N'user64@outlook.com', N'0952922499', CAST(N'2025-03-14T02:22:12.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user065', N'$2b$12$dOxbThOR19fG6N56DKoFpuJUn0jmY0Aea.bSEKAswrYWttUprBHZS', N'雷霆戰將65', NULL, N'M', CAST(N'1997-04-01T00:00:00.000' AS DateTime), N'新竹市東區關新路 134 號', N'user65@yahoo.com', N'0960172761', CAST(N'2025-03-14T02:22:12.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user066', N'$2b$12$We3wWu8svuAXYraSDLToYOknHgjSLL.syImi56Ka19Ecj/FYa.opO', N'深淵潛行者66', NULL, N'M', CAST(N'1998-01-17T00:00:00.000' AS DateTime), N'新竹市東區關新路 134 號', N'user66@outlook.com', N'0910799095', CAST(N'2025-03-14T02:22:13.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user067', N'$2b$12$ZJnLOYRZ4GpwHwXOkKPxw.IgJ8.5eDCIWoJSwkbpR4rPXSHlvnJGa', N'LOL高手67', NULL, N'F', CAST(N'1996-03-23T00:00:00.000' AS DateTime), N'新北市板橋區文化路二段 45 巷 7 號', N'user67@outlook.com', N'0913753208', CAST(N'2025-03-14T02:22:13.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user068', N'$2b$12$YNaiMRHpsej97CmTP1CNF.awLzZfS7D7yGSwD3t1m1B2ju4HmSi4y', N'星辰遊俠68', NULL, N'F', CAST(N'1988-11-02T00:00:00.000' AS DateTime), N'雲林縣斗六市民生路 88 號', N'user68@yahoo.com', N'0957442736', CAST(N'2025-03-14T02:22:13.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user069', N'$2b$12$gxxb97W58Xp20Pw/qKug8O.XPyOUFLq9SaJGFxPdVO4r0sKDLPYoG', N'神秘法師69', NULL, N'F', CAST(N'1997-12-14T00:00:00.000' AS DateTime), N'新竹市東區關新路 134 號', N'user69@hotmail.com', N'0948380894', CAST(N'2025-03-14T02:22:14.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user070', N'$2b$12$rF593RGz3q83FsQ9oXUnS.nZcsJfE4mimC.ZbWs1Mybl0P14IEQe2', N'狂風騎士70', NULL, N'M', CAST(N'2000-05-06T00:00:00.000' AS DateTime), N'高雄市鼓山區美術東三路 12 號', N'user70@yahoo.com', N'0963639315', CAST(N'2025-03-14T02:22:14.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user071', N'$2b$12$pjCcsDOJ/4SO4BUUb2j7lulg8YwabYZv0TvQqpVvm.cxVA7zAhxzu', N'極速射手71', NULL, N'M', CAST(N'1994-10-23T00:00:00.000' AS DateTime), N'台北市士林區中山北路六段 88 號', N'user71@outlook.com', N'0982534649', CAST(N'2025-03-14T02:22:14.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user072', N'$2b$12$5tVd76wGwHWN.DakcnbOWOZBY4M6IGXXzPjjfjdCXY/EBQIHuXvVe', N'狂風騎士72', NULL, N'M', CAST(N'2001-07-14T00:00:00.000' AS DateTime), N'台北市士林區中山北路六段 88 號', N'user72@yahoo.com', N'0938186554', CAST(N'2025-03-14T02:22:15.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user073', N'$2b$12$Pf5Zb/pQ1jiJXv2A21MNGurk0Pac6eEqCPE.uWsDIxZgUaZWgGaaq', N'火焰術士73', NULL, N'F', CAST(N'2000-05-02T00:00:00.000' AS DateTime), N'基隆市仁愛區愛三路 200 號', N'user73@outlook.com', N'0964182901', CAST(N'2025-03-14T02:22:15.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user074', N'$2b$12$JewGqGbFu2qf8znqPygbCOxHQ0934wmsob5Tz.BnXvW9glWRcgnae', N'星辰遊俠74', NULL, N'F', CAST(N'1999-09-14T00:00:00.000' AS DateTime), N'台中市北區學士路 150 巷 10 號', N'user74@yahoo.com', N'0935674838', CAST(N'2025-03-14T02:22:15.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user075', N'$2b$12$hQcQsY5gFhtZEiic5HngJuxK71zhtFE0MQLVcDXM5gcRTcmLcIXVC', N'星辰遊俠75', NULL, N'F', CAST(N'1997-06-10T00:00:00.000' AS DateTime), N'彰化市中山路二段 45 巷 5 號', N'user75@outlook.com', N'0966626146', CAST(N'2025-03-14T02:22:16.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user076', N'$2b$12$k68XcOslRg7X2GxlQSAY5ec.JF5WLwe0J/r0SJwWnCT9z0AzWSvQ2', N'黑夜獵手76', NULL, N'M', CAST(N'1991-09-06T00:00:00.000' AS DateTime), N'屏東市自由路 120 巷 6 號', N'user76@outlook.com', N'0993665086', CAST(N'2025-03-14T02:22:16.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user077', N'$2b$12$0vRK9wfbCcL..RlTpFLJLOAcgkaws1lbe9VYOXMhKsOZ3rrix8WmG', N'狂暴戰士77', NULL, N'M', CAST(N'2002-10-03T00:00:00.000' AS DateTime), N'嘉義市東區南京路 68 號', N'user77@gmail.com', N'0955650739', CAST(N'2025-03-14T02:22:16.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user078', N'$2b$12$.AxMtD9GRC4jTI38I31PZeYvElztKXneEYJbRGzthL0aYqFIUxG3y', N'黑夜獵手78', NULL, N'M', CAST(N'1997-07-27T00:00:00.000' AS DateTime), N'澎湖縣馬公市光華路 33 號', N'user78@gmail.com', N'0969781410', CAST(N'2025-03-14T02:22:17.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user079', N'$2b$12$osFJVNWrUrJrRaak8bBUxutt5vlqf3AaAMmGESLxeqVOObXrgWt/e', N'魔法學徒79', NULL, N'M', CAST(N'1993-03-21T00:00:00.000' AS DateTime), N'雲林縣斗六市民生路 88 號', N'user79@outlook.com', N'0924544946', CAST(N'2025-03-14T02:22:17.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user080', N'$2b$12$3uj6ZV5lAI74mSyKhMHIbOFq9/ebfNDH57KGV2CIXJ6pXXlZTurSC', N'冰霜法師80', NULL, N'M', CAST(N'1987-07-16T00:00:00.000' AS DateTime), N'台中市北區學士路 150 巷 10 號', N'user80@gmail.com', N'0998816492', CAST(N'2025-03-14T02:22:17.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user081', N'$2b$12$suoqgHQJtMD4QbURVfbhI.Re2jXVJA3lz33ThODMzrY./HKle2YXu', N'我愛英雄聯盟81', NULL, N'F', CAST(N'2004-02-11T00:00:00.000' AS DateTime), N'屏東市自由路 120 巷 6 號', N'user81@outlook.com', N'0924819642', CAST(N'2025-03-14T02:22:18.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user082', N'$2b$12$ta/l9LMkp0Hh/hEwWOn/..fnohyOJH3XcX0IgU2t2IOCeIx3/X3ua', N'星辰遊俠82', NULL, N'M', CAST(N'1997-05-04T00:00:00.000' AS DateTime), N'台中市北區學士路 150 巷 10 號', N'user82@yahoo.com', N'0963692932', CAST(N'2025-03-14T02:22:18.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user083', N'$2b$12$PgdOh0rsaV8hPB7V.gGIQOVD/ggN2Y61vDNP6cLyezPtNlHLGQ7Zm', N'鋼鐵守衛83', NULL, N'M', CAST(N'1998-01-07T00:00:00.000' AS DateTime), N'宜蘭縣羅東鎮公正路 20 號', N'user83@outlook.com', N'0946663546', CAST(N'2025-03-14T02:22:18.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user084', N'$2b$12$6KusbaO7jwO1iCbY00qDkeY3b8SC.zuZQjqtw2ccqm0mRYTApOsE.', N'深淵潛行者84', NULL, N'F', CAST(N'1989-07-06T00:00:00.000' AS DateTime), N'台中市西屯區台灣大道三段 255 號', N'user84@outlook.com', N'0936475849', CAST(N'2025-03-14T02:22:19.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user085', N'$2b$12$xR6EenKzNpKBik8a2JCa0OD121eib7ELG0mGKTJmbgesJnGhgwaLO', N'極速射手85', NULL, N'F', CAST(N'2004-07-21T00:00:00.000' AS DateTime), N'新竹市東區關新路 134 號', N'user85@yahoo.com', N'0930090347', CAST(N'2025-03-14T02:22:19.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user086', N'$2b$12$9fBgOO91lBnvR7M3LKqFCuFKLjd2cxmj1XHY7tP/h0lq0YSHyLXtW', N'極速射手86', NULL, N'F', CAST(N'1986-04-25T00:00:00.000' AS DateTime), N'台南市中西區中正路 89 號', N'user86@yahoo.com', N'0999796913', CAST(N'2025-03-14T02:22:19.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user087', N'$2b$12$MotxEjKn09I/9V8pqWAq1uupopiLy67oPmO7n4qEtfTtLrU9PAyw.', N'狂暴戰士87', NULL, N'M', CAST(N'1997-04-06T00:00:00.000' AS DateTime), N'雲林縣斗六市民生路 88 號', N'user87@yahoo.com', N'0920383036', CAST(N'2025-03-14T02:22:20.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user088', N'$2b$12$XKatKVaSPI9U0mX/jq0MHOPxpkVw2nnansX5UP.4vmWISotmZ5VV.', N'上單帝王88', NULL, N'F', CAST(N'2002-05-17T00:00:00.000' AS DateTime), N'新竹市東區關新路 134 號', N'user88@gmail.com', N'0926263327', CAST(N'2025-03-14T02:22:20.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user089', N'$2b$12$4RBvUOgYAUJ.Zpg9DBXWTOFJ1cjyEquWJHOt8fQMSDO1ZINT13xEq', N'戰場指揮官89', NULL, N'M', CAST(N'1985-04-18T00:00:00.000' AS DateTime), N'澎湖縣馬公市光華路 33 號', N'user89@yahoo.com', N'0929705051', CAST(N'2025-03-14T02:22:20.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user090', N'$2b$12$1m2oVGF02Pr77eItsKhGDO6jJJIhLTv3pAGnUnY3TMRSKxtt60Ek6', N'鋼鐵守衛90', NULL, N'M', CAST(N'1987-09-18T00:00:00.000' AS DateTime), N'花蓮市中正路 300 巷 15 號', N'user90@outlook.com', N'0960792849', CAST(N'2025-03-14T02:22:21.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user091', N'$2b$12$0Nl4y3OyS0ekYq/76AaagORWTNo9gW1xYvglNlbquTvtVxog8is3m', N'迅捷刺客91', NULL, N'M', CAST(N'1988-08-02T00:00:00.000' AS DateTime), N'台東市正氣路 99 號', N'user91@gmail.com', N'0938983942', CAST(N'2025-03-14T02:22:21.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user092', N'$2b$12$LBPLseGflWdH92F5x9CDT.q1Dmm1cf5DoUhxGuTE8dKaIdHqfKomW', N'影子刺客92', NULL, N'F', CAST(N'1987-04-15T00:00:00.000' AS DateTime), N'彰化市中山路二段 45 巷 5 號', N'user92@gmail.com', N'0914566131', CAST(N'2025-03-14T02:22:21.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user093', N'$2b$12$SD.GCpWaRvFsg4FI3o/viemVgNYZ4.v7sQCfwumf9/.w42j4oIqky', N'戰場指揮官93', NULL, N'F', CAST(N'2005-03-02T00:00:00.000' AS DateTime), N'新北市板橋區文化路二段 45 巷 7 號', N'user93@hotmail.com', N'0978289892', CAST(N'2025-03-14T02:22:22.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user094', N'$2b$12$w5d30Gkaot1BzV274gsFU.fWw9QpNFiNaRDXpf9aJBKBlQqPVajSa', N'火焰術士94', NULL, N'F', CAST(N'1995-12-20T00:00:00.000' AS DateTime), N'金門縣金城鎮中正路 55 號', N'user94@hotmail.com', N'0948662272', CAST(N'2025-03-14T02:22:22.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user095', N'$2b$12$/H9RyYkZDg0mTQMsmzLr/e6ZrGh5Q6ljL/.8QEU6J4WmKORcvAvda', N'龍之騎士95', NULL, N'M', CAST(N'1996-07-24T00:00:00.000' AS DateTime), N'南投市中興路 68 號', N'user95@hotmail.com', N'0995867165', CAST(N'2025-03-14T02:22:22.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user096', N'$2b$12$FDAphHZ/tyLPmJ4xEozqeedqlYDxbKug3MpWtLyHrBeM6NQ8Zij62', N'鋼鐵守衛96', NULL, N'F', CAST(N'1986-05-22T00:00:00.000' AS DateTime), N'台東市正氣路 99 號', N'user96@yahoo.com', N'0922909821', CAST(N'2025-03-14T02:22:23.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user097', N'$2b$12$UjmSx.XSd4AwwcH0kn34X.zZfvmmL0IA.S8VGe9ZosX5moIgUxDUi', N'幻影獵人97', NULL, N'F', CAST(N'1996-05-17T00:00:00.000' AS DateTime), N'花蓮市中正路 300 巷 15 號', N'user97@yahoo.com', N'0928481451', CAST(N'2025-03-14T02:22:23.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user098', N'$2b$12$FGBN/P5fXuBqmdO1kDs0keZ1h5OQUDuXZSYNtV1HTZCuD2d6aX9YK', N'極速射手98', NULL, N'M', CAST(N'1987-06-02T00:00:00.000' AS DateTime), N'屏東市自由路 120 巷 6 號', N'user98@outlook.com', N'0982984796', CAST(N'2025-03-14T02:22:23.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user099', N'$2b$12$oPDUwq4Tb2ePQLslOYMVkOBVnwcGiFM2tBO4f2ajZv.tYIe9IS2Sy', N'爐石玩家99', NULL, N'F', CAST(N'2002-02-06T00:00:00.000' AS DateTime), N'澎湖縣馬公市光華路 33 號', N'user99@yahoo.com', N'0940988241', CAST(N'2025-03-14T02:22:24.000' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user100', N'$2b$12$E031SYh78sw3/BOYvPH3feP0G2WT8mB9Qp01ytBTOhALgDv0EFv7W', N'深淵潛行者100', NULL, N'M', CAST(N'2002-01-15T00:00:00.000' AS DateTime), N'高雄市鼓山區美術東三路 12 號', N'user100@yahoo.com', N'0912634245', CAST(N'2025-03-14T02:22:24.000' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user888', N'123456', N'大楷', N'/img/User/head.jpg', N'M', CAST(N'1999-02-15T00:00:00.000' AS DateTime), N'台中市北屯區民生路 88 號', N'user888@yahoo.com', N'0911345678', CAST(N'2025-03-20T09:45:54.847' AS DateTime), NULL, NULL)
INSERT [dbo].[User] ([UserID], [Password], [Nickname], [PhotoUrl], [Gender], [Birthdate], [Address], [Email], [Phone], [RegisterDate], [Provider], [ProviderID]) VALUES (N'user999', N'456789', N'小新', N'/img/User/head1.jpg', N'M', CAST(N'2002-08-25T00:00:00.000' AS DateTime), N'台北市大同區迪化 88 號', N'user999@yahoo.com', N'0933345878', CAST(N'2024-08-20T09:45:54.847' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[ViewHistory] ON 

INSERT [dbo].[ViewHistory] ([ViewHistoryID], [UserID], [ProductID], [ViewDate]) VALUES (1, N'user001', 1, CAST(N'2025-02-15T01:01:15.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[ViewHistory] OFF
GO
ALTER TABLE [dbo].[Article] ADD  CONSTRAINT [DF__Article__postDat__59FA5E80]  DEFAULT (getdate()) FOR [PostDate]
GO
ALTER TABLE [dbo].[Article] ADD  CONSTRAINT [DF__Article__editDat__5AEE82B9]  DEFAULT (getdate()) FOR [EditDate]
GO
ALTER TABLE [dbo].[ArticleGroup] ADD  CONSTRAINT [DF__ArticleGr__views__5BE2A6F2]  DEFAULT ((0)) FOR [Views]
GO
ALTER TABLE [dbo].[ArticleMessage] ADD  DEFAULT (getdate()) FOR [EditDate]
GO
ALTER TABLE [dbo].[Discussion] ADD  CONSTRAINT [DF__Discussio__views__5DCAEF64]  DEFAULT ((0)) FOR [Views]
GO
ALTER TABLE [dbo].[News] ADD  DEFAULT (getdate()) FOR [EditDate]
GO
ALTER TABLE [dbo].[NewsMessage] ADD  DEFAULT (getdate()) FOR [EditDate]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Sold]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Rating]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF__User__registerDa__6477ECF3]  DEFAULT (getdate()) FOR [RegisterDate]
GO
ALTER TABLE [dbo].[ViewHistory] ADD  DEFAULT (getdate()) FOR [ViewDate]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK__Article__user_id__66603565] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK__Article__user_id__66603565]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_ArticleGroup1] FOREIGN KEY([ArticleGroupID])
REFERENCES [dbo].[ArticleGroup] ([ArticleGroupID])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_ArticleGroup1]
GO
ALTER TABLE [dbo].[ArticleGroup]  WITH CHECK ADD  CONSTRAINT [FK_ArticleGroup_Discussion] FOREIGN KEY([DiscussionID])
REFERENCES [dbo].[Discussion] ([DiscussionID])
GO
ALTER TABLE [dbo].[ArticleGroup] CHECK CONSTRAINT [FK_ArticleGroup_Discussion]
GO
ALTER TABLE [dbo].[ArticleMessage]  WITH CHECK ADD  CONSTRAINT [FK__ArticleMe__artic__68487DD7] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Article] ([ArticleID])
GO
ALTER TABLE [dbo].[ArticleMessage] CHECK CONSTRAINT [FK__ArticleMe__artic__68487DD7]
GO
ALTER TABLE [dbo].[ArticleMessage]  WITH CHECK ADD  CONSTRAINT [FK__ArticleMe__user___693CA210] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ArticleMessage] CHECK CONSTRAINT [FK__ArticleMe__user___693CA210]
GO
ALTER TABLE [dbo].[CustomerProblems]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProblems_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[CustomerProblems] CHECK CONSTRAINT [FK_CustomerProblems_User]
GO
ALTER TABLE [dbo].[NewsImage]  WITH CHECK ADD FOREIGN KEY([NewsID])
REFERENCES [dbo].[News] ([NewsID])
GO
ALTER TABLE [dbo].[NewsMessage]  WITH CHECK ADD FOREIGN KEY([NewsID])
REFERENCES [dbo].[News] ([NewsID])
GO
ALTER TABLE [dbo].[NewsMessage]  WITH CHECK ADD  CONSTRAINT [FK__NewsMessa__user___6FE99F9F] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[NewsMessage] CHECK CONSTRAINT [FK__NewsMessa__user___6FE99F9F]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([OrderStatusID])
REFERENCES [dbo].[OrderStatus] ([OrderStatusID])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK__Order__user_id__72C60C4A] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK__Order__user_id__72C60C4A]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[ProductCategory] ([ProductCategoryID])
GO
ALTER TABLE [dbo].[ProductAdditionalImage]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK__ShoppingC__user___787EE5A0] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK__ShoppingC__user___787EE5A0]
GO
ALTER TABLE [dbo].[ViewHistory]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ViewHistory]  WITH CHECK ADD  CONSTRAINT [FK__ViewHisto__user___7A672E12] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ViewHistory] CHECK CONSTRAINT [FK__ViewHisto__user___7A672E12]
GO
