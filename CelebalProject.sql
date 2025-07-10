
-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Address NVARCHAR(100),
    City NVARCHAR(50),
    State NVARCHAR(50),
    PostalCode NVARCHAR(20),
    Email NVARCHAR(100) UNIQUE,
    PhoneNumber NVARCHAR(20),
    DateCreated DATETIME DEFAULT GETDATE()
);

-- Create Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    Price DECIMAL(10, 2) NOT NULL,
    Category NVARCHAR(50),
    DateAdded DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

-- Create Order table
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(12, 2) NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Pending',
    ShippingAddress NVARCHAR(100),
    CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Create OrderDetail table (to handle multiple products per order)
CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    CONSTRAINT FK_OrderDetail_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    QuantityInStock INT NOT NULL,
    LastStockUpdate DATETIME DEFAULT GETDATE(),
    Location NVARCHAR(50),
    ReorderLevel INT DEFAULT 10,
    CONSTRAINT FK_Inventory_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Insert sample customers
INSERT INTO Customer (FirstName, LastName, Address, City, State, PostalCode, Email, PhoneNumber)
VALUES 
('John', 'Abraham', '123 Main St', 'New York', 'NY', '10001', 'john.abraham@email.com', '555-123-4567'),
('Stive', 'Smith', '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'stive.smith@email.com', '555-987-6543'),
('Robert', 'Downey', '789 Pine Rd', 'Chicago', 'IL', '60601', 'robert.d@email.com', '555-456-7890');

-- Insert sample products
INSERT INTO Product (ProductName, Description, Price, Category)
VALUES 
('Laptop', '15-inch business laptop with 16GB RAM', 999.99, 'Electronics'),
('Smartphone', 'Latest model with 128GB storage', 799.99, 'Electronics'),
('Desk Chair', 'Ergonomic office chair', 249.99, 'Furniture'),
('Coffee Mug', 'Ceramic mug with company logo', 9.99, 'Kitchenware');

-- Insert inventory data
INSERT INTO Inventory (ProductID, QuantityInStock, Location, ReorderLevel)
VALUES 
(1, 50, 'Warehouse A', 5),
(2, 100, 'Warehouse B', 10),
(3, 30, 'Warehouse C', 3),
(4, 200, 'Warehouse A', 20);

-- Insert sample orders
INSERT INTO [Order] (CustomerID, TotalAmount, Status, ShippingAddress)
VALUES 
(1, 1799.98, 'Shipped', '123 Main St, New York, NY 10001'),
(2, 259.98, 'Processing', '456 Oak Ave, Los Angeles, CA 90001');

-- Insert order details
INSERT INTO OrderDetail (OrderID, ProductID, Quantity, UnitPrice)
VALUES 
(1, 1, 1, 999.99),
(1, 2, 1, 799.99),
(2, 3, 1, 249.99),
(2, 4, 1, 9.99);

Select * from [dbo].[Customer]

Select * from [dbo].[Product]

Select * from [dbo].[Order]

Select * from [dbo].[OrderDetail]

Select * from [dbo].[Inventory]


