
DROP TABLE Payment CASCADE CONSTRAINTS;
DROP TABLE Reservation CASCADE CONSTRAINTS;
DROP TABLE Showtime CASCADE CONSTRAINTS;
DROP TABLE Seat CASCADE CONSTRAINTS;
DROP TABLE CinemaHall CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Movie CASCADE CONSTRAINTS;


CREATE TABLE Movie (
    MovieID NUMBER PRIMARY KEY,
    Title VARCHAR2(100) NOT NULL,
    Genre VARCHAR2(50),
    Duration NUMBER CHECK (Duration > 0),
    Language VARCHAR2(30),
    Description VARCHAR2(255)
);

CREATE TABLE Customer (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    Surname VARCHAR2(50) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Password VARCHAR2(100) NOT NULL
);

CREATE TABLE CinemaHall (
    HallID NUMBER PRIMARY KEY,
    HallName VARCHAR2(20) NOT NULL,
    SeatingCapacity NUMBER CHECK (SeatingCapacity > 0)
);

CREATE TABLE Seat (
    SeatID NUMBER PRIMARY KEY,
    SeatNumber VARCHAR2(10) NOT NULL,
    HallID NUMBER,
    CONSTRAINT fk_seat_hall FOREIGN KEY (HallID)
        REFERENCES CinemaHall(HallID)
);

CREATE TABLE Showtime (
    ShowtimeID NUMBER PRIMARY KEY,
    MovieID NUMBER,
    HallID NUMBER,
    ShowDate DATE,
    StartTime VARCHAR2(10),
    CONSTRAINT fk_show_movie FOREIGN KEY (MovieID)
        REFERENCES Movie(MovieID),
    CONSTRAINT fk_show_hall FOREIGN KEY (HallID)
        REFERENCES CinemaHall(HallID)
);

CREATE TABLE Reservation (
    ReservationID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    ShowtimeID NUMBER,
    SeatID NUMBER,
    ReservationDate DATE,
    Status VARCHAR2(20),
    CONSTRAINT fk_res_customer FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID),
    CONSTRAINT fk_res_showtime FOREIGN KEY (ShowtimeID)
        REFERENCES Showtime(ShowtimeID),
    CONSTRAINT fk_res_seat FOREIGN KEY (SeatID)
        REFERENCES Seat(SeatID),
    CONSTRAINT unique_seat_reservation UNIQUE (ShowtimeID, SeatID)
);

CREATE TABLE Payment (
    PaymentID NUMBER PRIMARY KEY,
    Amount NUMBER(8,2) CHECK (Amount > 0),
    PaymentDate DATE,
    PaymentMethod VARCHAR2(30),
    ReservationID NUMBER,
    CONSTRAINT fk_payment_reservation FOREIGN KEY (ReservationID)
        REFERENCES Reservation(ReservationID)
);


INSERT INTO Movie VALUES (1, 'Inception', 'Sci-Fi', 148, 'English', 'Dream within a dream');
INSERT INTO Movie VALUES (2, 'Interstellar', 'Sci-Fi', 169, 'English', 'Space exploration');
INSERT INTO Movie VALUES (3, 'Gladiator', 'Action', 155, 'English', 'Roman Empire');

INSERT INTO Customer VALUES (101, 'Ali', 'Yilmaz', 'ali@mail.com', '1234');
INSERT INTO Customer VALUES (102, 'Ayse', 'Kaya', 'ayse@mail.com', 'abcd');
INSERT INTO Customer VALUES (103, 'Mehmet', 'Demir', 'mehmet@mail.com', 'pass');

INSERT INTO CinemaHall VALUES (10, 'Hall A', 100);
INSERT INTO CinemaHall VALUES (11, 'Hall B', 80);
INSERT INTO CinemaHall VALUES (12, 'Hall C', 60);

INSERT INTO Seat VALUES (1, 'A1', 10);
INSERT INTO Seat VALUES (2, 'A2', 10);
INSERT INTO Seat VALUES (3, 'B1', 11);

INSERT INTO Showtime VALUES (201, 1, 10, DATE '2025-01-10', '18:00');
INSERT INTO Showtime VALUES (202, 2, 11, DATE '2025-01-11', '20:00');
INSERT INTO Showtime VALUES (203, 3, 12, DATE '2025-01-12', '19:00');

INSERT INTO Reservation VALUES (301, 101, 201, 1, SYSDATE, 'Confirmed');
INSERT INTO Reservation VALUES (302, 102, 202, 3, SYSDATE, 'Confirmed');
INSERT INTO Reservation VALUES (303, 103, 203, 2, SYSDATE, 'Cancelled');

INSERT INTO Payment VALUES (401, 120.00, SYSDATE, 'Credit Card', 301);
INSERT INTO Payment VALUES (402, 100.00, SYSDATE, 'Debit Card', 302);
INSERT INTO Payment VALUES (403,  80.00, SYSDATE, 'Cash', 303);

COMMIT;


SELECT c.Name, c.Surname,
       m.Title,
       se.SeatNumber,
       p.Amount,
       p.PaymentMethod
FROM Payment p
JOIN Reservation r ON p.ReservationID = r.ReservationID
JOIN Customer c ON r.CustomerID = c.CustomerID
JOIN Showtime s ON r.ShowtimeID = s.ShowtimeID
JOIN Movie m ON s.MovieID = m.MovieID
JOIN Seat se ON r.SeatID = se.SeatID;

SELECT m.Title, SUM(p.Amount) AS TotalRevenue
FROM Payment p
JOIN Reservation r ON p.ReservationID = r.ReservationID
JOIN Showtime s ON r.ShowtimeID = s.ShowtimeID
JOIN Movie m ON s.MovieID = m.MovieID
GROUP BY m.Title
ORDER BY TotalRevenue DESC;

SELECT Name, Surname
FROM Customer
WHERE CustomerID IN (
    SELECT r.CustomerID
    FROM Reservation r
    JOIN Payment p ON r.ReservationID = p.ReservationID
);