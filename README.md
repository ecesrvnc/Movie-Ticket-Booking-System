# Movie-Ticket-Booking-System

# Project Overview 
This project presents a comprehensive database management system designed to automate movie ticket reservations and cinema operations. Developed for the CMPE341 course at Atılım University, the system addresses real-world challenges such as data redundancy, seat reservation conflicts, and inefficient scheduling.

# Database Architecture
The system architecture is built upon a rigorous design process, transitioning from a conceptual EER model to a normalized relational schema.

# 1. Conceptual Design (EER Modeling)
The conceptual model identifies seven core entities that represent the full transaction cycle of a cinema:

Customer: Stores user identification and contact information.

Movie: Contains film metadata including title, genre, and duration.

Showtime: Manages the scheduling of movies in specific halls and times.

Hall: Defines the physical screening rooms and their capacities.

Seat: Tracks individual seat availability for each hall.

Reservation: Acts as the central entity linking customers, showtimes, and seats.

Payment: Records financial transactions linked to specific reservations.

# 2. Logical Design and Normalization
The ER diagram was mapped to a relational model to ensure data integrity:

Integrity Constraints: Primary and foreign keys are explicitly defined to maintain referential integrity.

Conflict Prevention: A unique constraint is implemented on the (ShowtimeID, SeatID) pair within the Reservation table to prevent double-booking.

Relational Chain: Every reservation is systematically linked to a payment record, facilitating a seamless data flow.

# Technical Implementation
RDBMS: Oracle SQL.

Interface: Oracle APEX (Application Express).

Key Operations: Support for dynamic seat checking, automated reservation status updates, and administrative reporting.

# SQL Validations
The implementation includes advanced SQL queries to verify system functionality:

Complex Joins: Consolidating data across multiple tables for detailed reporting.

Aggregation: Revenue analysis per movie using GROUP BY and ORDER BY clauses.

Subqueries: Identifying active customers based on successful payment transactions.
