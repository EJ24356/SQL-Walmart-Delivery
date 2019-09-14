
#CREATE PROCEDURE TP_Q01()
SELECT Orders.Order_ID, status, Customer.First_name, Customer.Last_name
FROM OrderDetails
JOIN Items ON Items.Item_ID = OrderDetails.Item_ID
JOIN Orders ON Orders.Order_ID = OrderDetails.Order_ID
JOIN Customer ON Orders.Customer_ID = Customer.Customer_ID
WHERE status IN('In Process')
GROUP BY Orders.Order_ID;
#Select the orders, status, and customers that are 'In Process' 

#CREATE PROCEDURE TP_Q02()
SELECT Customer.Last_name,Customer.First_name,
	(SELECT COUNT(Orders.Order_ID) FROM Orders
	 WHERE Orders.Customer_ID = Customer.Customer_ID) AS 'Number of Orders'
FROM Customer, Orders
GROUP BY Customer.Customer_ID
ORDER BY Customer.Last_name;
#Count the number of orders from each customer, ordered by lastName

#CREATE PROCEDURE TP_Q03()
SELECT item_name,price,description
FROM Promotions
JOIN Items on Promotions.Item_ID = Items.Item_ID
WHERE EXISTS (SELECT Items.Item_ID 
			  FROM Items 
              WHERE Items.Item_ID = Promotions.Item_ID)
ORDER BY price DESC; 
# Show the item name, price, and description of items that have a promotion


#CREATE PROCEDURE TP_Q04()
SELECT item_name
FROM OrderDetails
JOIN Items ON OrderDetails.Item_ID = Items.Item_ID
WHERE item_name REGEXP ('^b|i$');  
# Display the item_name for items that start with a 'b' or End with an 'i'

#CREATE PROCEDURE TP_Q05()
SELECT First_name,Last_name
FROM Customer
JOIN Favorites ON Favorites.Customer_ID = Customer.Customer_ID
GROUP BY Customer.Customer_ID
HAVING COUNT(Favorites.Favorites_ID) >= 3 ; 
# List the name of customer with 3 or more favorite items

#CREATE PROCEDURE TP_Q06()
SELECT item_name, price, Category.category_name
FROM Items
JOIN Category ON Items.Category_ID = Category.Category_ID
WHERE price <= (SELECT AVG(price) FROM Items); 
#List item_name, price, category_name of items that are less than the Average price of all items

#CREATE PROCEDURE TP_Q07()
SELECT item_name, price, Category.category_name
FROM Items
JOIN Category ON Items.Category_ID = Category.Category_ID
WHERE price <= (SELECT AVG(price) FROM Items WHERE Items.Category_ID = Category.Category_ID)
GROUP BY item_name, price, Category.category_name
HAVING category_name REGEXP('s$'); 
 
#List item_name, price, category_name of items that are less than the Average price of all items in 
#that category, which the restriction of the category_name ending with an 's'

#CREATE PROCEDURE TP_Q08()
SELECT First_name, Last_name, Car_model, Country, State, City, status
FROM Employee
JOIN Stores ON Employee.Store_ID = Stores.Store_ID
JOIN Orders ON Orders.Delivered_By = Employee.Employee_ID
WHERE estimated_delivery_Date REGEXP ('2018')
GROUP BY First_name, Last_name, Car_model, Country, State, City, status
ORDER BY Last_name ASC;
#Display the First_name, Last_name, Car_model, Country, State, City, and status of employees whose
#estimated delivery date was in the year of 2018

#CREATE PROCEDURE TP_Q09()
SELECT First_name, Last_name
FROM Employee
JOIN Rating ON Employee.Employee_ID = Rating.Employee_Rated
WHERE NOT EXISTS (SELECT Rating FROM Rating WHERE Employee.Employee_ID = Rating.Employee_Rated AND Rating > 3 )
GROUP BY  First_name, Last_name ;
#Show the name of the employee(s) that does not have a rating greater than 3 

#[an employee can be rated multiple
#times by different customers, so even though a person might be rated under 3, another customer can rate them 
#over 3, thus they meet the criteria]

#CREATE PROCEDURE TP_Q10()
SELECT SUM(price) 'Sum of Promoted items'
FROM Items
JOIN Promotions ON Promotions.Item_ID = Items.Item_ID
WHERE EXISTS (SELECT Promotion_ID FROM Promotions WHERE Promotions.Item_ID = Items.Item_ID);

#Find the Sum of all the prices of items that have a discount [ discount is a varchar because it isn't so much
#a numerical value all the time, but more of a description of a bargain]
