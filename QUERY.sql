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
