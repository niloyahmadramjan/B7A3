-- SCHEMA CREATION 


-- create users table 

create table Users (
    user_id serial primary key,
    full_name varchar(100) not null,
    email varchar(150) unique not null,
    role varchar(50) not null check( role in ('Ticket Manager', 'Football Fan')),
    phone_number varchar(20) null
)

-- create matches table 

create table Matches(
  match_id serial primary key,
  fixture varchar(200) not null,
  tournament_category varchar(100) not null,
  base_ticket_price numeric(10,2) not null,
  match_status varchar(20) not null
  check(match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
)

-- create Booking table 
create table Bookings(
  booking_id serial primary key, 
  user_id int not null references Users(user_id) on delete cascade,
  match_id int not null references Matches(match_id) on delete cascade,
  seat_number varchar(20) null,
  payment_status varchar(20) null,
  check (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
  total_cost numeric(10,2) not null
);


-- Users data insert query
insert into Users (user_id, full_name, email, role, phone_number) values
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan',   '+8801711111111'),
(2, 'Asif Haque',    'asif@mail.com',   'Football Fan',   '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara',    'jannat@mail.com', 'Football Fan',   NULL);


-- created matches data insert query 

insert into Matches(match_id, fixture, tournament_category, base_ticket_price, match_status) values
(101, 'Real Madrid vs Barcelona',  'Champions League', 150, 'Available'),
(102, 'Man City vs Liverpool',     'Premier League',   120, 'Selling Fast'),
(103, 'Bayern Munich vs PSG',      'Champions League', 130, 'Available'),
(104, 'AC Milan vs Inter Milan',   'Serie A',           90, 'Sold Out'),
(105, 'Juventus vs Roma',          'Serie A',           80, 'Available');



insert into Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) values
(501, 1, 101, 'A-12', 'Confirmed', 150),
(502, 1, 102, 'B-04', 'Confirmed', 120),
(503, 2, 101, 'A-13', 'Confirmed', 150),
(504, 2, 101,  NULL,   NULL,       150),
(505, 3, 102, 'C-20', 'Pending',   120);


-------------------------------------------------
--------------------------------------------------
-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.

select match_id, fixture,base_ticket_price
  from Matches
  where tournament_category = 'Champions League' 
  and match_status = 'Available'

-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
select user_id, full_name, email from Users 
where full_name ilike 'Tanvir%'
or full_name ilike '%Haque%'


-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.
select booking_id, user_id, match_id, coalesce(payment_status, 'Action Required') as systematic_status
from Bookings where payment_status is null



  --  Query 4
  --  Retrieve match booking details along with the user's full
  --  name and the scheduled match fixture teams.
SELECT
  b.booking_id,
  u.full_name,
  m.fixture,
  b.total_cost
FROM
  Bookings b
  INNER JOIN Users u ON b.user_id = u.user_id
  INNER JOIN Matches m ON b.match_id = m.match_id
ORDER BY
  b.booking_id;


--  Query 5
--  Display ALL users and their booking IDs, ensuring fans
--  who have NEVER bought a ticket are still listed.
select u.user_id, u.full_name, b.booking_id from Users u
left join Bookings b on u.user_id = b.user_id 
order by u.user_id , b.booking_id;


--  Query 6
--  Find all ticket bookings where the total cost is STRICTLY
--  HIGHER than the average cost of ALL ticket bookings.


select booking_id, match_id, total_cost from Bookings 
where total_cost > (select avg(total_cost) from Bookings)
order by booking_id;