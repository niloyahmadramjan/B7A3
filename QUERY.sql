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
