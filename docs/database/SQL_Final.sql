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
(N'GameMaster', N'password123', N'https://example.com/avatar1.png', 'M', '1990-05-15', N'�x�_��', N'gamer@example.com', N'0912345678'),
(N'ProPlayer', N'abc123', N'https://example.com/avatar2.png', 'F', '1995-08-22', N'�s�_��', N'pro@example.com', N'0923456789');
INSERT INTO News (Title, Content, ImageURL, EditDate, Category)
VALUES 
(N'�m�^���p���n�s�ɩu��s', N'���s�ɩu�Y�N���{�A�a�ӳ̷s����ʻP�^���վ�I', N'https://example.com/lol.jpg', GETDATE(), N'�C��'),
(N'�m�㺸�n�k���nDLC �o��', N'FromSoftware �ť��Y�N���X�㺸�n�k�����s DLC�I', N'https://example.com/eldenring.jpg', GETDATE(), N'�C��');
INSERT INTO Products (ProductName, Description, ImageURL, Price, Category, Stock)
VALUES 
(N'�m�]�~�@�ɡn���ê�', N'�]�t�Ҧ��X�R���e���S�O����', N'https://example.com/wow.jpg', 1999, N'�C��', 10),
(N'�m�t�¯}�a��IV�n', N'�ɳ��T�֥X�~���ʧ@�����t�C��', N'https://example.com/diablo4.jpg', 1799, N'�C��', 20);
INSERT INTO Discussions (BoardName, BoardDescription, ImageURL, Views, Category)
VALUES 
(N'�^���p���Q�װ�', N'�Q�� LOL �C�������B�^����ܻP�̷s��ʡI', N'https://example.com/lol_board.jpg', 5000, N'�C��'),
(N'Steam �C���Q��', N'���� Steam �C�������P�馩��T�I', N'https://example.com/steam_board.jpg', 3000, N'�C��');
INSERT INTO Articles (BoardID, UserID, Title, Content, EditDate, Category, Views)
VALUES 
(1, 1, N'�s�ɩu�̱j�^������', N'�o�̬O�̷s���^���p���ɩu T1 �^���Ʀ�]�I', GETDATE(), N'�C��', 150),
(2, 2, N'Steam �K�u�S��}�l�I', N'�o�����馩�O�׬۷�j�A���֨Ӭݬݦ����Ǧn�C���I', GETDATE(), N'�C��', 80);
INSERT INTO Orders (UserID, ProductID, Quantity, Price, OrderDate)
VALUES 
(1, 1, 1, 1999, GETDATE()),
(2, 2, 2, 1799, GETDATE());
