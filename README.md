# Movie-Ticket-Booking-System
This project was developed as a group assignment for the CMPE341 - Database Design and Management course at Atılım University. It focuses on the design, analysis, and implementation of a database system for managing cinema operations, including movie schedules, seat availability, and customer reservations.

Project Overview
The system aims to replace manual or inefficient cinema management processes with a well-structured database-driven solution. It allows users to view movies, check showtimes, and reserve specific seats while providing administrators with tools to manage theater data and track sales.

Tech Stack
Database: Oracle SQL 

Interface: Oracle APEX 

Design Tools: ER/EER Modeling 

Database Design
The system consists of seven primary entities:

Movie: Stores titles, genres, and durations.

Customer: Manages user accounts and contact details.

CinemaHall: Represents screening rooms and their capacities.

Seat: Individual seat tracking for each hall.

Showtime: Links movies to halls at specific dates/times.

Reservation: Unites customers, showtimes, and seats.

Payment: Tracks financial transactions for each booking.

Integrity Features
Unique Constraints: Prevents double-booking by ensuring a specific (ShowtimeID, SeatID) combination can only be reserved once.

Referential Integrity: Enforced through foreign keys to maintain consistency across tables.

SQL Examples
The project includes complex queries to validate the design, such as:

Multi-table Joins: Combining customer, movie, seat, and payment data.

Aggregate Queries: Calculating total revenue generated per film.

Subqueries: Filtering customers who have completed successful transactions.

User Interface
The system features a web-based interface built with Oracle APEX, including:

Secure Login/Authentication for customers.

Interactive Dashboards for managing movies and halls.

Data Entry Forms for creating new reservations and processing payments.
