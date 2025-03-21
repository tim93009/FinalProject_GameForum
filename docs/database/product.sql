USE [GameForum]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2025/3/19 下午 04:22:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO*/
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
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (27, N'《寶可夢傳說 Z-A》中文版', N'《寶可夢傳說 Z-A》中文版 NS版', N'../img/product/mainImg/c3e31c072302c6787a27d354cb1tb835.jfif', 1950, 6, 100, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (29, N'《瑪利歐 & 路易吉 RPG 兄弟齊航！》中文版', N'《瑪利歐 & 路易吉 RPG 兄弟齊航！》中文版 NS版', N'../img/product/mainImg/ed53f5558e4f572831d1625ba61qf535.jfif', 1590, 6, 50, 15, 4.9)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (30, N'《死亡擱淺 2：冥灘之上》中文一般版', N'《死亡擱淺 2：冥灘之上》中文一般版 （附贈預購特典）', N'../img/product/mainImg/7f1bdb440c79c792290d3d31731tgil5.jfif', 1990, 5, 100, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (31, N'SteelSeries Nimbus+ Apple 專用無線遊戲控制器', N'SteelSeries Nimbus+ Apple 專用無線遊戲控制器 一個', N'../img/product/mainImg/c515f74084441a1527808b06c71q8195.jfif', 2290, 1, 10, 2, 5)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (32, N'ASUS ROG Pelta 無線電競耳機麥克風', N'ASUS ROG Pelta 無線電競耳機麥克風', N'../img/product/mainImg/80e81c3955c108e307a0fd81c51sp3c5.jfif', 4590, 1, 10, 1, 5)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (33, N'《初音未來 Project DIVA MEGA39''s+》中文一般版', N'《初音未來 Project DIVA MEGA39''s+》中文一般版（數位下載版', N'../img/product/mainImg/cb3995bdea0bc3000c25df20d51gedp5.jfif', 436, 4, 50, 15, 5)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (34, N'《人中之龍 7 外傳 英雄無名》中文版', N'《人中之龍 7 外傳 英雄無名》中文版（數位下載版）', N'../img/product/mainImg/c38cdb10d4687c125f38c809561nhq95.jfif', 476, 4, 50, 25, 5)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (36, N'《靈魂駭客 2》中文豪華版', N'《靈魂駭客 2》中文豪華版（數位下載版）', N'../img/product/mainImg/f1ea44901c2344c284ef6a54661h83r5.jfif', 498, 4, 30, 3, 4.7)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (37, N'《超次元戰記 戰機少女 Game Maker R:Evolution》中文一般版', N'《超次元戰記 戰機少女 Game Maker R:Evolution》中文一般版 PS版', N'../img/product/mainImg/44c83c71d3397cc70dc26e4ee61t3tq5.jfif', 1690, 5, 20, 0, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDescription], [MainImageUrl], [Price], [ProductCategoryID], [Stock], [Sold], [Rating]) VALUES (38, N'《奧咕和秘密森林》中文豪華版', N'《奧咕和秘密森林》中文豪華版（附贈預購特典）', N'../img/product/mainImg/487e0cf6760356e788a07fb4911t8zm5.jfif', 1790, 6, 50, 0, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Sold]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Rating]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[ProductCategory] ([ProductCategoryID])
GO
