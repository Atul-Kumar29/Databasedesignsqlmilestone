-- ============================================================================
-- SMART CAMPUS HOSTEL MANAGEMENT - DATABASE DESIGN

-- ============================================================================

-- ============================================================================
-- Table 1: HOSTELS
-- ============================================================================
CREATE TABLE hostels (
    hostel_id INT PRIMARY KEY,
    hostel_name VARCHAR(100) NOT NULL,
    location VARCHAR(200) NOT NULL,
    total_rooms INT NOT NULL,
    warden_name VARCHAR(100) NOT NULL,
    warden_contact VARCHAR(20) NOT NULL
);

-- ============================================================================
-- Table 2: ROOMS
-- ============================================================================
CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    hostel_id INT NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    floor_number INT NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    current_occupancy INT,
    rent_per_semester DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id),
    UNIQUE (hostel_id, room_number)
);

-- ============================================================================
-- Table 3: STUDENTS
-- ============================================================================
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    department VARCHAR(100) NOT NULL,
    year_of_study INT NOT NULL,
    emergency_contact VARCHAR(20) NOT NULL
);

-- ============================================================================
-- Table 4: ROOM_ASSIGNMENTS (Junction Table for M:N Relationship)
-- ============================================================================
CREATE TABLE room_assignments (
    assignment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    room_id INT NOT NULL,
    assignment_date DATE NOT NULL,
    checkout_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    UNIQUE (student_id, status)
);

-- ============================================================================
-- Table 5: MEAL_PLANS
-- ============================================================================
CREATE TABLE meal_plans (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL,
    description TEXT,
    meals_per_day INT NOT NULL,
    monthly_cost DECIMAL(10,2) NOT NULL
);

-- ============================================================================
-- Table 6: STUDENT_MEAL_SUBSCRIPTIONS (Junction Table for M:N Relationship)
-- ============================================================================
CREATE TABLE student_meal_subscriptions (
    subscription_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    is_active BOOLEAN,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (plan_id) REFERENCES meal_plans(plan_id)
);

-- ============================================================================
-- Table 7: COMPLAINTS
-- ============================================================================
CREATE TABLE complaints (
    complaint_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    room_id INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(20),
    priority VARCHAR(20),
    submitted_at TIMESTAMP,
    resolved_at TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- ============================================================================
-- SAMPLE DATA
-- ============================================================================

-- Insert Hostels
INSERT INTO hostels (hostel_id, hostel_name, location, total_rooms, warden_name, warden_contact) VALUES
(1, 'Sunrise Boys Hostel', 'Campus Block A', 100, 'Dr. Rajesh Kumar', '9876543210'),
(2, 'Moonlight Girls Hostel', 'Campus Block B', 80, 'Mrs. Priya Sharma', '9876543211');

-- Insert Rooms
INSERT INTO rooms (room_id, hostel_id, room_number, floor_number, room_type, capacity, current_occupancy, rent_per_semester) VALUES
(101, 1, '101-A', 1, 'Single', 1, 1, 25000.00),
(103, 1, '102-A', 1, 'Double', 2, 2, 18000.00),
(107, 2, '101-A', 1, 'Single', 1, 1, 25000.00),
(108, 2, '101-B', 1, 'Single', 1, 0, 25000.00);

-- Insert Students
INSERT INTO students (student_id, first_name, last_name, email, phone_number, date_of_birth, gender, department, year_of_study, emergency_contact) VALUES
(1001, 'Amit', 'Patel', 'amit.patel@campus.edu', '9123456789', '2003-05-15', 'Male', 'Computer Science', 3, '9876543210'),
(1002, 'Rahul', 'Sharma', 'rahul.sharma@campus.edu', '9123456790', '2003-08-22', 'Male', 'Electronics', 3, '9876543211'),
(1003, 'Sneha', 'Reddy', 'sneha.reddy@campus.edu', '9123456791', '2003-03-10', 'Female', 'Computer Science', 2, '9876543212'),
(1004, 'Priya', 'Singh', 'priya.singh@campus.edu', '9123456792', '2004-01-25', 'Female', 'Information Science', 2, '9876543213');

-- Insert Room Assignments
INSERT INTO room_assignments (assignment_id, student_id, room_id, assignment_date, checkout_date, status) VALUES
(1, 1001, 101, '2024-01-15', NULL, 'Active'),
(2, 1002, 103, '2024-01-15', NULL, 'Active'),
(3, 1003, 107, '2024-01-15', NULL, 'Active'),
(4, 1004, 108, '2024-01-15', NULL, 'Active');

-- Insert Meal Plans
INSERT INTO meal_plans (plan_id, plan_name, description, meals_per_day, monthly_cost) VALUES
(1, 'Basic Plan', 'Breakfast and Dinner', 2, 2500.00),
(2, 'Standard Plan', 'Breakfast, Lunch and Dinner', 3, 3500.00);

-- Insert Student Meal Subscriptions
INSERT INTO student_meal_subscriptions (subscription_id, student_id, plan_id, start_date, end_date, is_active) VALUES
(1, 1001, 2, '2024-01-15', '2024-06-30', TRUE),
(2, 1002, 1, '2024-01-15', '2024-06-30', TRUE),
(3, 1003, 2, '2024-01-15', '2024-06-30', TRUE),
(4, 1004, 1, '2024-01-15', '2024-06-30', TRUE);

-- Insert Complaints
INSERT INTO complaints (complaint_id, student_id, room_id, category, description, status, priority, submitted_at) VALUES
(1, 1001, 101, 'Electrical', 'Light not working in room', 'Resolved', 'Normal', '2024-02-10 10:30:00'),
(2, 1002, 103, 'Plumbing', 'Tap leaking in bathroom', 'Resolved', 'High', '2024-02-15 14:20:00'),
(3, 1003, 107, 'Furniture', 'Chair is broken', 'Pending', 'Low', '2024-03-01 09:15:00'),
(4, 1004, 108, 'Electrical', 'Fan not working properly', 'InProgress', 'Normal', '2024-03-05 11:45:00');

-- ============================================================================
-- SQL QUERIES
-- ============================================================================

-- Query 1: List all students with their room assignments and hostel details
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    s.email,
    s.department,
    h.hostel_name,
    r.room_number,
    r.room_type,
    ra.assignment_date,
    ra.status
FROM students s
JOIN room_assignments ra ON s.student_id = ra.student_id
JOIN rooms r ON ra.room_id = r.room_id
JOIN hostels h ON r.hostel_id = h.hostel_id;

-- Query 2: List students with hostel wardens
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    h.hostel_name,
    h.warden_name,
    h.warden_contact
FROM students s
JOIN room_assignments ra ON s.student_id = ra.student_id
JOIN rooms r ON ra.room_id = r.room_id
JOIN hostels h ON r.hostel_id = h.hostel_id;

-- Query 3: Find available rooms in each hostel
SELECT 
    h.hostel_name,
    r.room_number,
    r.floor_number,
    r.room_type,
    r.capacity,
    r.current_occupancy,
    r.rent_per_semester
FROM rooms r
JOIN hostels h ON r.hostel_id = h.hostel_id;

-- Query 4: Room rent details for active student assignments
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    h.hostel_name,
    r.room_number,
    r.room_type,
    r.rent_per_semester
FROM students s
JOIN room_assignments ra ON s.student_id = ra.student_id
JOIN rooms r ON ra.room_id = r.room_id
JOIN hostels h ON r.hostel_id = h.hostel_id;

-- Query 5: Complaint details with student and room information
SELECT 
    c.complaint_id,
    s.first_name,
    s.last_name,
    h.hostel_name,
    r.room_number,
    c.category,
    c.status,
    c.priority
FROM complaints c
JOIN students s ON c.student_id = s.student_id
JOIN rooms r ON c.room_id = r.room_id
JOIN hostels h ON r.hostel_id = h.hostel_id;

-- Query 6: Student meal plan details
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    mp.plan_name,
    mp.description,
    mp.meals_per_day,
    mp.monthly_cost,
    sms.start_date,
    sms.end_date
FROM student_meal_subscriptions sms
JOIN students s ON sms.student_id = s.student_id
JOIN meal_plans mp ON sms.plan_id = mp.plan_id;

-- Query 7: Students with pending complaints
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    s.phone_number,
    c.complaint_id,
    c.category,
    c.description,
    c.status,
    c.priority,
    c.submitted_at
FROM students s
LEFT JOIN complaints c ON s.student_id = c.student_id;

-- Query 8: Students with room and meal plan details
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    s.department,
    s.year_of_study,
    r.room_number,
    h.hostel_name,
    mp.plan_name
FROM students s
LEFT JOIN room_assignments ra ON s.student_id = ra.student_id
LEFT JOIN rooms r ON ra.room_id = r.room_id
LEFT JOIN hostels h ON r.hostel_id = h.hostel_id
LEFT JOIN student_meal_subscriptions sms ON s.student_id = sms.student_id
LEFT JOIN meal_plans mp ON sms.plan_id = mp.plan_id;
