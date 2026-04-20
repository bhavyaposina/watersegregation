CREATE TABLE Users ( 
user_id INTEGER PRIMARY KEY AUTOINCREMENT, 
name TEXT, 
address TEXT, 
phone TEXT 
); 
CREATE TABLE Waste_Type ( 
waste_id INTEGER PRIMARY KEY AUTOINCREMENT, 
type_name TEXT 
); 
CREATE TABLE Staff ( 
staff_id INTEGER PRIMARY KEY AUTOINCREMENT, 
name TEXT, 
role TEXT 
); 
CREATE TABLE Collection ( 
collection_id INTEGER PRIMARY KEY AUTOINCREMENT, 
user_id INTEGER, 
waste_id INTEGER, 
staff_id INTEGER, 
quantity REAL, 
collection_date TEXT, 
FOREIGN KEY (user_id) REFERENCES Users(user_id), 
FOREIGN KEY (waste_id) REFERENCES Waste_Type(waste_id), 
FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) 
); 
CREATE TABLE Recycling ( 
recycle_id INTEGER PRIMARY KEY AUTOINCREMENT, 
waste_id INTEGER, 
quantity REAL, 
status TEXT, 
recycle_date TEXT, 
FOREIGN KEY (waste_id) REFERENCES Waste_Type(waste_id) 
); 
INSERT INTO Users (name, address, phone) VALUES 
('Ravi Kumar', 'Hyderabad', '9876543210'), 
('Anita Sharma', 'Chennai', '9123456780'); 
INSERT INTO Waste_Type (type_name) VALUES 
('Biodegradable'), 
('Plastic'), 
('Metal'); 
INSERT INTO Staff (name, role) VALUES 
('Suresh', 'Collector'), 
('Meena', 'Manager'); 
INSERT INTO Collection (user_id, waste_id, staff_id, quantity, collection_date) VALUES 
(1, 1, 1, 5.5, '2026-04-01'), 
(2, 2, 1, 3.0, '2026-04-02'); 
INSERT INTO Recycling (waste_id, quantity, status, recycle_date) VALUES 
(1, 5.0, 'Processed', '2026-04-03'), 
(2, 2.5, 'Pending', '2026-04-04'); 
SELECT w.type_name, SUM(c.quantity) AS total_quantity 
FROM Collection c 
JOIN Waste_Type w ON c.waste_id = w.waste_id 
GROUP BY w.type_name; 
SELECT u.name, SUM(c.quantity) AS total_waste 
FROM Collection c 
JOIN Users u ON c.user_id = u.user_id 
GROUP BY u.name; 
SELECT * FROM Recycling 
WHERE status = 'Pending'; 
SELECT s.name, SUM(c.quantity) AS total_collected 
FROM Collection c 
JOIN Staff s ON c.staff_id = s.staff_id 
GROUP BY s.name; 
SELECT collection_date, SUM(quantity) AS total_waste 
FROM Collection 
GROUP BY collection_date; 
SELECT s.name, c.collection_date, SUM(c.quantity) AS total 
FROM Collection c 
JOIN Staff s ON c.staff_id = s.staff_id 
GROUP BY s.name, c.collection_date; 
SELECT  
(SELECT SUM(quantity) FROM Collection) AS total_collected, 
(SELECT SUM(quantity) FROM Recycling) AS total_recycled; 
SELECT COUNT(*) AS total_waste_types 
FROM Waste_Type; 
SELECT w.type_name, SUM(c.quantity) AS total 
FROM Collection c 
JOIN Waste_Type w ON c.waste_id = w.waste_id 
GROUP BY w.type_name 
ORDER BY total DESC 
LIMIT 1;