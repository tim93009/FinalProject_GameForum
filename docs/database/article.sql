USE [GameForum]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 2025/3/20 下午 03:22:09 ******/
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
/****** Object:  Table [dbo].[ArticleGroup]    Script Date: 2025/3/20 下午 03:22:09 ******/
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
/****** Object:  Table [dbo].[ArticleMessage]    Script Date: 2025/3/20 下午 03:22:09 ******/
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
/****** Object:  Table [dbo].[Discussion]    Script Date: 2025/3/20 下午 03:22:09 ******/
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
SET IDENTITY_INSERT [dbo].[Article] ON 

INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (1, N'user099', 1, N'<p>哈囉各位，我是拿塔，這次想跟大家分享一下我在《魔物獵人 荒野》中的經歷。</p><p>原本我只是想輕鬆享受狩獵的樂趣，沒想到卻被那隻名為「白之孤影」的魔物欺負得團團轉！這傢伙總是在我最不注意時出現，讓我屢戰屢敗，真的是氣到不行。</p><p>面對這樣的狀況，我決定發文向各位高手求教，有沒有人能分享一些對付「白之孤影」的實用攻略？也希望能藉此機會認識更多志同道合的獵人，一起討論如何提升技巧。</p>', CAST(N'2025-03-14T13:20:22.000' AS DateTime), CAST(N'2025-03-14T14:11:35.710' AS DateTime), N'存在')
INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (5, N'user100', 1, N'<p><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074198915_n.jpg" class="fr-fic fr-dii" status="success"></p><p><br></p><p><span style="font-size: 18px;">護鎖刃龍資訊</span></p><p><span style="font-size: 18px;">古代文明創造出的造龍種，帶有鎖刃龍之力。既沒有生殖能力，也不會捕食，而是直接攝取龍乳作為能量來源。除了與其他護龍一樣能夠吸收和釋放能量之外，還能通過翼上的鎖刃吸收屬性能量，轉化為自身的養分。</span></p><p><br></p><p><span style="font-size: 18px;">出現位置 : 龍都遺跡</span></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖刃龍資訊</span></p><p><span style="font-size: 18px;">公會保存的文獻指出，這種飛龍早已滅絕。翅膀的一部分有獨特的刀刃，形如鎖鏈，能夠自由伸縮並橫掃獵物。不僅如此，它還能通過鎖刃吸收屬性能量，作為自己的能源，甚至能夠將吸收的能量轉化為龍屬性並釋放出來。</span></p><p><br></p><p><span style="font-size: 18px;">出現位置 : 全地圖皆會出現</span></p><p><br></p><p><br></p><p><span style="font-size: 18px;">弱點</span></p><p><span style="font-size: 18px;">鎖刃龍的頭部是弱點，身體兩側的鎖刃可以被破壞，尾巴可以單獨被切斷，以上所有部位都有較高幾率掉落素材。</span></p><p><br></p><p><span style="font-size: 24px;"><strong>掉落材料</strong></span></p><p><span style="font-size: 18px;">【護鎖刃龍】下位護龍的鱗：</span></p><p><span style="font-size: 18px;">目標報酬【20%】、破壞頭部部位【100%】、破壞傷口掉落【45%】、剝取屍體【50%】。護龍的毛皮：目標報酬【20%】、破壞左右鎖刃【100%】、破壞傷口掉落【43%】、剝取屍體【30%】。護龍的血：目標報酬【10%】、剝取切斷的尾巴【100%】、破壞傷口掉落【12%】、剝取屍體【20%】。滋養精華：目標報酬【30%】。精壯護骨：目標報酬【20%】。</span></p><p><br></p><p><span style="font-size: 18px;">【鎖刃龍】上位無情鎖刃甲：</span></p><p><span style="font-size: 18px;">破壞鎖刃部位【100%】。鎖刃龍的上等鱗：目標報酬【20%】、破壞傷口掉落【45%】、剝取屍體【30%】。鎖刃龍的尖角：目標報酬【8%】、破壞頭部部位【100%】、剝取屍體【13%】。鎖刃龍的尾巴：目標報酬【8%】、剝取切斷的尾巴部位【93%】、剝取屍體【11%】。鎖刃龍的堅鎧殼：目標報酬【20%】、破壞傷口掉落【43%】、剝取屍體【23%】。鎖刃龍的白毛：目標報酬【15%】、破壞傷口掉落【12%】、剝取屍體【18%】。堅龍骨：目標報酬【18%】。鎖刃龍狩獵證S：目標報酬【8%】。鎖刃龍的龍玉：目標報酬【3%】、剝取切斷的尾巴部位【7%】、剝取屍體【5%】。</span></p><p><br></p><p><br></p><p><span style="font-size: 24px;"><strong>如何躲避招式</strong></span></p><p><span style="font-size: 18px;">後撤步鎖刃擊</span></p><p><span style="font-size: 18px;">護鎖刃龍先抬起側面的肢體開始蓄力，然後立刻躍起配合後撤步將身上的鎖鏈甩到目標位置，攻擊範圍不算大，只需要稍稍移動便可躲過攻擊。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074216810_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">單爪鎖鏈擊</span></p><p><span style="font-size: 18px;">比較常用的招式，鎖刃龍先是將要攻擊的翅膀與鎖刃蜷縮起來蓄力，然後朝玩家方向直接甩去。看到前搖動作就需要準備防禦或移動躲避了。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074219085_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖連甩擊</span></p><p><span style="font-size: 18px;">零幀起手，直接抬高手臂並依靠慣性朝下揮舞手臂將鎖鏈甩向玩家，鎖鏈本身較細攻擊判定範圍也不算大，但難以預判落點且前搖太短容易反應不及時，需要多打形成肌肉記憶才好打。同時這個召喚還有一個二連擊的變體，怪物會通過不同的爪子攻擊兩次。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074222047_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖鏈突刺</span></p><p><span style="font-size: 18px;">鎖刃龍跳到半空，擺出下圖所示姿勢將身上的鎖鏈甩到目標位置處，也就是突進一下再甩鎖鏈。可以靠地形直接躲過去，但這招的前搖不太明顯，容易在大意的時候直接被來一下。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074224366_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">甩尾</span></p><p><span style="font-size: 18px;">零幀起手且基本沒有前搖，躲避難度很高，需要有一定的肌肉記憶與對自身武器較高的熟練度才能應對。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/17407422634_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖刃爆擊</span></p><p><span style="font-size: 18px;">無需揮動雙爪即可進行的鎖刃攻擊，當鎖刃龍將某手臂的鎖刃揮動出去後暫時處於罰站狀態，揮出鎖刃的位置稍後會產生爆炸傷害。因此就算未被揮出的鎖刃打到也需要立刻遠離鎖刃的位置。</span></p><p><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074228990_n.jpg" class="fr-fic fr-dii" status="success"></p><p><br></p><p><br></p><p><span style="font-size: 18px;">爆氣</span></p><p><span style="font-size: 18px;">隨著高昂的嚎叫聲，護鎖刃龍的身體開始冒出白色火焰然後快速轉變為紅色並對其前方區域造成大範圍爆炸傷害，我們需要在顏色轉變為紅色前離開鎖刃龍的前方。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/17407423113_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">連跳</span></p><p><span style="font-size: 18px;">護鎖刃龍先是張開白色的鎖鏈並散發白色火焰，短暫蓄力後跳到半空中以不規則的路徑在空中使用鎖刃攻擊地面。看到鎖刃龍張開鎖刃並附有白色火焰時基本都是大範圍攻擊，需要立刻準備防禦或召喚坐騎遠離。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074233262_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">鎖刃三連擊</span></p><p><span style="font-size: 18px;">護鎖刃龍以半身傾斜的姿勢開始蓄力，對前方區域先是左右兩連砍，然後跳到半空向下舞動鎖刃進行一次重擊，這招無論是前方還是側面都有極遠的傷害判定，看懂姿勢前搖建議立刻呼叫坐騎離開鎖刃龍附近範圍躲避。</span></p><p><span style="font-size: 18px;"><img alt="《魔物獵人 : 荒野》 護鎖刃龍與鎖刃龍打法教學" src="https://img.league-funny.com/imgur/174074235543_n.jpg" class="fr-fic fr-dii" status="success"></span><br></p><p><br></p><p><br></p><p><span style="font-size: 18px;">來源：遊民星空</span></p>', CAST(N'2025-03-15T00:01:16.000' AS DateTime), CAST(N'2025-03-15T00:01:16.000' AS DateTime), N'存在')
INSERT [dbo].[Article] ([ArticleID], [UserID], [ArticleGroupID], [ArticleContent], [PostDate], [EditDate], [Status]) VALUES (35, N'user001', 2, N'「能夠再次奪冠，我感到非常高興。這次勝利對我和隊伍都有著特殊的意義。」「感謝一直以來支持我們的粉絲，這個冠軍屬於你們。」', CAST(N'2025-03-20T15:20:34.657' AS DateTime), CAST(N'2025-03-20T15:20:34.657' AS DateTime), N'存在')
SET IDENTITY_INSERT [dbo].[Article] OFF
GO
SET IDENTITY_INSERT [dbo].[ArticleGroup] ON 

INSERT [dbo].[ArticleGroup] ([ArticleGroupID], [DiscussionID], [Category], [Views], [CoverImage], [ArticleTitle]) VALUES (1, 2, N'問題', 556, NULL, N'被「白之孤影」欺負，我決定要變強！')
INSERT [dbo].[ArticleGroup] ([ArticleGroupID], [DiscussionID], [Category], [Views], [CoverImage], [ArticleTitle]) VALUES (2, 1, N'情報', 1000, NULL, N'T1勝利宣言')
SET IDENTITY_INSERT [dbo].[ArticleGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[ArticleMessage] ON 

INSERT [dbo].[ArticleMessage] ([ArticleMessageID], [ArticleID], [UserID], [MessageContent], [EditDate]) VALUES (1, 1, N'user098', N'這代魔物比較簡單還打不過', CAST(N'2025-03-19T09:39:20.740' AS DateTime))
INSERT [dbo].[ArticleMessage] ([ArticleMessageID], [ArticleID], [UserID], [MessageContent], [EditDate]) VALUES (2, 1, N'user095', N'樓上很兇', CAST(N'2025-03-19T09:40:31.653' AS DateTime))
INSERT [dbo].[ArticleMessage] ([ArticleMessageID], [ArticleID], [UserID], [MessageContent], [EditDate]) VALUES (3, 5, N'user097', N'素晴らしい！', CAST(N'2025-03-19T09:43:47.517' AS DateTime))
SET IDENTITY_INSERT [dbo].[ArticleMessage] OFF
GO
SET IDENTITY_INSERT [dbo].[Discussion] ON 

INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (1, N'英雄聯盟', N'英雄聯盟LOL', NULL, 1000, N'PC')
INSERT [dbo].[Discussion] ([DiscussionID], [DiscussionName], [DiscussionDescription], [ImageUrl], [Views], [Category]) VALUES (2, N'魔物獵人', N'魔物獵人', NULL, 5566, N'多平台')
SET IDENTITY_INSERT [dbo].[Discussion] OFF
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
