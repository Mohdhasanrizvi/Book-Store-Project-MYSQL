-- Ques 1) Retrive all books in the "Fiction" Genre.
SELECT *
FROM Books
WHERE Genre = "Fiction";

-- Ques 2) Find books published after the year 1950.
SELECT *
FROM Books
WHERE Published_Year > 1950;

-- Ques 3) List all Customers from the Canada.
SELECT *
FROM Customers
WHERE Country = "Canada";

-- Ques 4) Show Orders placed in November 2023.
SELECT *
FROM Orders
WHERE LEFT(Order_Date, 7) = "2023-11"
ORDER BY Order_Date;

-- Ques 5) Retrieve the Total Stock of Books Available.
SELECT SUM(Stock) as Total_Books
FROM Books;

-- Ques 6) Find the details of the most expensive book.
SELECT *
FROM Books
ORDER BY Price desc
LIMIT 1;

-- Ques 7) Show all customers who ordered more than 1 quantity of a book.
SELECT o.Order_ID, c.Customer_ID, c.Name
FROM Customers as c
JOIN Orders as o
ON c.Customer_ID = o.Customer_ID
WHERE Quantity > 1
ORDER BY o.Order_ID;

-- Ques 8) Retrieve all Orders where the total amount exceeds $20.
SELECT *
FROM Orders
WHERE Total_Amount > 20
ORDER BY Order_ID;

-- Ques 9) List all Genres available in the books table.
SELECT DISTINCT Genre
FROM Books
ORDER BY Genre;

-- Ques 10) Find the Books with the Lowest Stock.
SELECT *
FROM Books
ORDER BY Stock;

-- Ques 11) Calculate the Total Revenue generated from all orders.
SELECT ROUND(SUM(Total_Amount), 2) as Total_Revenue
FROM Orders;

-- Ques 12) Retrieve the total number of books sold for each Genre.
SELECT b.Genre, SUM(o.Quantity) as Total_Books
FROM Books as b
JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY b.Genre;

-- Ques 13) Find the Average Price of Books in the "Fantasy" Genre.
SELECT b.Genre, ROUND(AVG(b.Price), 3) as Average_Price
FROM Books as b
WHERE Genre = "Fantasy";

-- Ques 14) List Customers who have placed at least 2 Orders
SELECT c.Customer_ID, c.Name, COUNT(*) as Total_Orders      -- (* = Order_ID) 
FROM Customers as c
JOIN Orders as o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(*) >= 2
ORDER BY c.Customer_ID desc;

-- Ques 15)Find the most frequently ordered book.
SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) as Order_Count
FROM Orders as o
JOIN Books as b
ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Order_Count desc
LIMIT 1;

-- Ques 16) Show the top 3 most expensive books of "Fantasy" Genre.
SELECT b.Book_ID, b.Title, b.Price
FROM Books as b
WHERE Genre = "Fantasy"
ORDER BY b.Price desc
LIMIT 3;

-- Ques 17) List the Cities where Customers who spent over $30 are located.
SELECT DISTINCT c.City, Total_Amount
FROM Customers as c
JOIN Orders as o
ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30
ORDER BY c.City desc;

-- Ques 18) Retrieve the Total Quantity of Books sold by each Author.
SELECT b.Author, SUM(o.Quantity) as Total_Books
FROM Books as b
JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY Total_Books desc;

-- Ques 19) Find the Customer who spent the most on Orders.
SELECT c.Customer_ID, c.Name, ROUND(SUM(o.Total_Amount), 2) as Most_Orders
FROM Customers as c
JOIN Orders as o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Most_Orders desc
LIMIT 1;

-- Ques 20) Calculate the Stock remaining after fulfilling all orders.
SELECT b.Book_ID, b.Title, b.Stock, COALESCE(SUM(o.Quantity), 0) as Order_Quantity, (b.Stock - COALESCE(SUM(o.Quantity), 0)) as Remaining_Stock
FROM Books as b
LEFT JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;

-- Ques 21) Show all orders with customer names and book titles.
SELECT c.Name, b.Title, o.Order_ID, o.Order_Date, o.Quantity
FROM Customers as c
JOIN Orders as o
ON c.Customer_ID = o.Customer_ID
JOIN Books as b
ON b.Book_ID = o.Book_ID
ORDER BY o.Order_Date;

-- Ques 22) Count how many books are in stock per genre.
SELECT b.Genre, COUNT(*) as Books
FROM Books as b
GROUP BY b.Genre;

-- Ques 23) Find total sales amount per book.
SELECT b.Book_ID, b.Title, ROUND(SUM(o.Total_Amount), 2) as Total_Sales
FROM Books as b
JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY b.Book_ID;

-- Ques 24) List customers who ordered more than 5 books in total.
SELECT c.Customer_ID, c.Name, COUNT(o.Book_ID) as Total_Books
FROM Customers as c
JOIN Orders as o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Book_ID) > 5
ORDER BY c.Customer_ID;

-- Ques 25) List books published before 2000 with price less than $20.
SELECT *
FROM Books
WHERE Published_Year < 2000 AND Price < 20
ORDER BY Price;

-- Ques 26) Count how many orders were made in each year.
SELECT b.Published_Year, COUNT(o.Order_ID) as Total_Orders
FROM Books as b
JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Published_Year
ORDER BY b.Published_Year;

-- Ques 27) Which book has been ordered the most by quantity?
SELECT b.Book_ID, b.Title, SUM(o.Quantity) as Total_Quantity
FROM Books as b
JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Total_Quantity desc
LIMIT 1;
-- Ques 28) Which customer spent the most money overall?
SELECT c.Name, ROUND(SUM(o.Total_Amount), 2) as Total_Spent
FROM Customers as c
JOIN Orders as o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Name
ORDER BY Total_Spent desc
LIMIT 1; 
-- Ques 29) List all books that have never been ordered.
SELECT b.Title
FROM Books as b
LEFT JOIN Orders as o
ON b.Book_ID = o.Book_ID
WHERE o.Order_ID is NULL; 

-- Ques 30) Calculate total stock value per genre (Price × Stock)
SELECT b.Genre, ROUND(SUM(b.Price * b.Stock), 3) as Total_Stock_Value
FROM Books as b
GROUP BY b.Genre
ORDER BY Total_Stock_Value;

-- Ques 31)Show the total revenue generated per year.
SELECT b.Published_Year, ROUND(SUM(o.Total_Amount), 2) as Total_Revenue
FROM Books as b
JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Published_Year
ORDER BY Total_Revenue desc;

-- Ques 32) Rank books by total sales within each genre.
SELECT b.Genre, b.Title, ROUND(SUM(o.Total_Amount), 2) as Total_Sales, RANK() OVER(PARTITION BY b.Genre ORDER BY SUM(o.Total_Amount) desc) as Ranking
FROM Books as b
JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Genre;

-- Ques 33) Show cumulative total sales by order date.
SELECT o.Order_Date, SUM(o.Total_Amount) as Daily_Sales, SUM(SUM(o.Total_Amount)) OVER(ORDER BY o.Order_Date) as Cumulative_Sales
FROM Orders as o
GROUP BY o.Order_Date
ORDER BY o.Order_Date;

-- Ques 34) Get the most recent order for each customer.
SELECT *
FROM(SELECT o.Order_ID, o.Customer_ID, c.Name, o.Order_Date, 
ROW_NUMBER() OVER(PARTITION BY o.Customer_ID ORDER BY o.Order_Date) as Recent_Order
FROM Orders as o
JOIN Customers as c
ON o.Customer_ID = c.Customer_ID) as t
WHERE Recent_Order = 1; 

-- Ques 35) Calculate the running total of books sold per customer by order date.
SELECT o.Customer_ID, c.Name, o.Order_ID, o.Order_Date, o.Quantity, SUM(o.Quantity) OVER(PARTITION BY c.Customer_ID 
ORDER BY o.Order_Date) as Total_Sold_Books
FROM Orders as o
JOIN Customers as c
ON o.Customer_ID = c.Customer_ID
ORDER BY c.Customer_ID, o.Order_Date;

-- Ques 36) Find difference in days between each customer’s orders.
SELECT o.Customer_ID, c.Name, o.Order_ID, o.Order_Date, LAG(o.Order_Date) OVER(PARTITION BY o.Customer_ID 
ORDER BY o.Order_Date) as Previous_Order, DATEDIFF(o.Order_Date, LAG(o.Order_Date) OVER(PARTITION BY o.Customer_ID 
ORDER BY o.Order_Date)) as Date_Difference
FROM Orders as o
JOIN Customers as c
ON o.Customer_ID = c.Customer_ID
ORDER BY o.Customer_ID, o.Order_Date;

-- Ques 37) Top 3 best-selling books per genre
SELECT *
FROM (SELECT o.Book_ID, b.Title, b.Genre, DENSE_RANK() OVER(PARTITION BY b.Genre 
ORDER BY SUM(o.Quantity) desc) as Top_Selling_Books
FROM Orders as o
JOIN Books as b
ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title, b.Genre) as t
WHERE Top_Selling_Books <= 3;


-- Ques 38) Display the percentage of total revenue contributed by each book.
SELECT b.Title, SUM(o.Total_Amount) as Book_Sales, ROUND((100.0 * SUM(o.Total_Amount)) / SUM(SUM(o.Total_Amount)) 
OVER(), 2)  as Percentage_Sales
FROM Books as b
JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Title
ORDER BY Percentage_Sales desc;

-- Ques 39) Assign all books into price quartiles.
SELECT b.Book_ID, b.Title, b.Price, NTILE(4) OVER(ORDER BY b.Price) as Price_Quartiles
FROM Books as b
ORDER BY b.Price asc;

-- Ques 40) Rank customers by total money spent on orders.
SELECT Customer_ID, Name, Total_Spent, RANK() OVER(ORDER BY Total_Spent desc) as Ranking
FROM (SELECT c.Customer_ID, c.Name, ROUND(SUM(o.Total_Amount), 2) as Total_Spent
FROM Customers as c
JOIN Orders as o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name) as t;

-- Ques 41) Rank books by quantity sold within each published year.
SELECT b.Book_ID, b.Title, b.Published_Year, SUM(o.Quantity) as Total_Quantity, 
RANK() OVER(PARTITION BY b.Published_Year ORDER BY SUM(o.Quantity) desc) as Rnk 
FROM Books as b
JOIN Orders as o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Published_Year;

-- Ques 42) Partition books by author and rank them by price.
SELECT b.Book_ID, b.Title, b.Author, RANK() OVER(PARTITION BY b.Author ORDER BY b.Price desc) as Price_Rank
FROM Books as b
ORDER BY b.Author;

-- Ques 43) For each order, show how much more or less the customer spent compared to their previous order.
SELECT o.Order_ID, o.Customer_ID, o.Order_Date, o.Total_Amount, LAG(o.Total_Amount) OVER(PARTITION BY o.Customer_ID
ORDER BY o.Order_Date) as Previous_Amount, (o.Total_Amount - LAG(o.Total_Amount) OVER(PARTITION BY o.Customer_ID
ORDER BY o.Order_Date)) as Difference_Orders
FROM Orders as o
ORDER BY o.Customer_ID, o.Order_Date;

-- Ques 44) For each genre, show the second highest grossing book.
SELECT *
FROM (SELECT o.Book_ID, b.Title, b.Genre, ROUND(SUM(o.Total_Amount), 2) as Total_Spent, RANK() OVER(PARTITION BY
b.Genre ORDER BY SUM(o.Total_Amount) desc) as Second_Highest
FROM Orders as o
JOIN Books as b
ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title, b.Genre) as t
WHERE Second_Highest = 2
ORDER BY Genre, Total_Spent desc;

-- Ques 45) Show a moving average of daily sales (3-day window).
SELECT o.Order_Date, SUM(o.Total_Amount) as Daily_Sales, ROUND(AVG(SUM(o.Total_Amount)) OVER(ORDER BY o.Order_Date 
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) as Average_Daily_Sales
FROM Orders as o
GROUP BY o.Order_Date
ORDER BY o.Order_Date;

-- Ques 46) Show each customer's rank based on the total number of books ordered.
SELECT o.Customer_ID, c.Name, SUM(o.Quantity) as Total_Books, RANK() OVER(ORDER BY SUM(o.Quantity) desc) as Ranking
FROM Orders as o
JOIN Customers as c
ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
ORDER BY Ranking, o.Customer_ID; 

-- Ques 47) Show the first book each customer ever bought.
SELECT *
FROM (SELECT o.Customer_ID, c.Name, o.Book_ID, b.Title, o.Order_Date, ROW_NUMBER() OVER(PARTITION BY o.Customer_ID
ORDER BY o.Order_Date) as First_Book
FROM Orders as o
JOIN Customers as c
ON o.Customer_ID = o.Customer_ID
JOIN Books as b
ON o.Book_ID = b.Book_ID) as t
WHERE First_Book = 1
ORDER BY Order_Date;

-- Ques 48) Show cumulative quantity of books ordered per book over time.
SELECT o.Book_ID, b.Title, o.Order_Date, o.Quantity, SUM(o.Quantity) OVER(PARTITION BY o.Book_ID, b.Title ORDER BY
o.Order_Date) as Book_Count
FROM Orders as o
JOIN Books as b
ON o.Book_ID = b.Book_ID;

