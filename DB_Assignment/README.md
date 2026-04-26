# Database Design Assignment

**Student:** Atul Kumar | **USN:** 4SF24IS023

---

## Scenario 1: Smart Campus Hostel Management

### Tables (7)
- hostels, rooms, students, room_assignments, meal_plans, student_meal_subscriptions, complaints

### Relationships
- HOSTELS → ROOMS (1:N)
- STUDENTS ↔ ROOMS (M:N) via room_assignments
- STUDENTS ↔ MEAL_PLANS (M:N) via student_meal_subscriptions
- STUDENTS → COMPLAINTS (1:N)

### Queries (8)
1. Student room details with hostel info
2. Students with hostel wardens
3. Room details with hostel info
4. Student room rent details
5. Complaint details with room info
6. Student meal plan details
7. Students and complaints using left join
8. Students with room and meal plan details

---

## Scenario 2: Mini E-Commerce Platform

### Tables (7)
- categories, products, customers, addresses, orders, order_items, reviews

### Relationships
- CATEGORIES → PRODUCTS (1:N)
- CATEGORIES self-reference (1:N)
- CUSTOMERS → ADDRESSES (1:N)
- CUSTOMERS → ORDERS (1:N)
- ORDERS ↔ PRODUCTS (M:N) via order_items
- CUSTOMERS → REVIEWS (1:N)

### Queries (8)
1. Order details with customer info
2. Customers with their order details
3. Products included in each order
4. Orders with shipping address details
5. Category and ordered product details
6. Customer addresses with related orders
7. Product reviews with customer details
8. Products and categories using right join

---

## Normalization
- 1NF:  Atomic values
- 2NF:  No partial dependencies
- 3NF:  No transitive dependencies

---

## Requirements Met
-  7 tables per scenario
-  2 many-to-many relationships per scenario
-  Primary keys in all tables
-  Foreign keys with constraints
-  Minimum sample records included for joins
-  8 queries per scenario
-  Normalized to 3NF
