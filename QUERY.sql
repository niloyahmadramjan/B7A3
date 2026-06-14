-- SCHEMA CREATION 


-- create users table 

create table Users (
    user_id serial primary key,
    full_name varchar(100) not null,
    email varchar(150) unique not null,
    role varchar(50) not null check( role in ('Ticket Manager', 'Football Fan')),
    phone_number varchar(20) null
)
