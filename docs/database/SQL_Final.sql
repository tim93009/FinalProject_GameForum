CREATE DATABASE GameForum2;
GO

USE GameForum2;
GO
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    PhotoID INT,
    PhotoURL NVARCHAR(250),
    Gender VARCHAR(1),
    BirthDate DATE,
    Address NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    PhoneNumber NVARCHAR(20)
);
CREATE TABLE News (
    NewsID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(50) NOT NULL,
    Content NVARCHAR(500),
    ImageID INT,
    ImageURL NVARCHAR(250),
    EditDate DATETIME,
    Category NVARCHAR(25)
);
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(500),
    ImageID INT,
    ImageURL NVARCHAR(250),
    Price INT,
    Category NVARCHAR(25),
    Stock INT,
    Sold INT DEFAULT 0
);
CREATE TABLE ProductPictures (
    PictureID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    ImageURL NVARCHAR(250),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Advertisements (
    AdID INT IDENTITY(1,1) PRIMARY KEY,
    AdName NVARCHAR(50),
    Category NVARCHAR(25),
    ImageID INT,
    ImageURL NVARCHAR(250)
);
CREATE TABLE Discussions (
    BoardID INT IDENTITY(1,1) PRIMARY KEY,
    BoardName NVARCHAR(50),
    BoardDescription NVARCHAR(500),
    ImageID INT,
    ImageURL NVARCHAR(250),
    Views INT DEFAULT 0,
    Category NVARCHAR(25)
);
CREATE TABLE Articles (
    ArticleID INT IDENTITY(1,1) PRIMARY KEY,
    BoardID INT,
    UserID INT,
    Title NVARCHAR(50),
    Content NVARCHAR(500),
    EditDate DATETIME,
    Category NVARCHAR(25),
    Views INT DEFAULT 0,
    FOREIGN KEY (BoardID) REFERENCES Discussions(BoardID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
CREATE TABLE ViewHistory (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    ProductID INT,
    ViewDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    ProductID INT,
    Quantity INT,
    Price INT,
    OrderDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Users (Username, Password, PhotoURL, Gender, BirthDate, Address, Email, PhoneNumber)
VALUES 
(N'GameMaster', N'password123', N'https://example.com/avatar1.png', 'M', '1990-05-15', N'台北市', N'gamer@example.com', N'0912345678'),
(N'ProPlayer', N'abc123', N'https://example.com/avatar2.png', 'F', '1995-08-22', N'新北市', N'pro@example.com', N'0923456789');
INSERT INTO News (Title, Content, ImageURL, EditDate, Category)
VALUES 
(N'《英雄聯盟》新賽季更新', N'全新賽季即將來臨，帶來最新的改動與英雄調整！', N'https://example.com/lol.jpg', GETDATE(), N'遊戲'),
(N'《艾爾登法環》DLC 發表', N'FromSoftware 宣布即將推出艾爾登法環全新 DLC！', N'https://example.com/eldenring.jpg', GETDATE(), N'遊戲');
INSERT INTO Products (ProductName, Description, ImageURL, Price, Category, Stock)
VALUES 
(N'《魔獸世界》典藏版', N'包含所有擴充內容的特別版本', N'https://example.com/wow.jpg', 1999, N'遊戲', 10),
(N'《暗黑破壞神IV》', N'暴雪娛樂出品的動作角色扮演遊戲', N'https://example.com/diablo4.jpg', 1799, N'遊戲', 20);
INSERT INTO Discussions (BoardName, BoardDescription, ImageURL, Views, Category)
VALUES 
(N'英雄聯盟討論區', N'討論 LOL 遊戲策略、英雄選擇與最新改動！', N'https://example.com/lol_board.jpg', 5000, N'遊戲'),
(N'Steam 遊戲討論', N'分享 Steam 遊戲評價與折扣資訊！', N'https://example.com/steam_board.jpg', 3000, N'遊戲');
INSERT INTO Articles (BoardID, UserID, Title, Content, EditDate, Category, Views)
VALUES 
(1, 1, N'新賽季最強英雄推薦', N'這裡是最新的英雄聯盟賽季 T1 英雄排行榜！', GETDATE(), N'遊戲', 150),
(2, 2, N'Steam 春季特賣開始！', N'這次的折扣力度相當大，趕快來看看有哪些好遊戲！', GETDATE(), N'遊戲', 80);
INSERT INTO Orders (UserID, ProductID, Quantity, Price, OrderDate)
VALUES 
(1, 1, 1, 1999, GETDATE()),
(2, 2, 2, 1799, GETDATE());
