-- Dropping the REPORT table
DROP TABLE REPORT CASCADE CONSTRAINTS;

-- Dropping the PAYMENT table
DROP TABLE PAYMENT CASCADE CONSTRAINTS;

-- Dropping the PAYMENT_METHOD table
DROP TABLE PAYMENT_METHOD CASCADE CONSTRAINTS;

-- Dropping the ORDER_ITEM table
DROP TABLE ORDER_ITEM CASCADE CONSTRAINTS;

-- Dropping the "ORDER" table
DROP TABLE "ORDER" CASCADE CONSTRAINTS;

-- Dropping the COLLECTION_SLOT table
DROP TABLE COLLECTION_SLOT CASCADE CONSTRAINTS;

-- Dropping the CART_ITEM table
DROP TABLE CART_ITEM CASCADE CONSTRAINTS;

-- Dropping the CART table
DROP TABLE CART CASCADE CONSTRAINTS;

-- Dropping the FAVOURITE_ITEM table
DROP TABLE FAVOURITE_ITEM CASCADE CONSTRAINTS;

-- Dropping the REVIEW table
DROP TABLE REVIEW CASCADE CONSTRAINTS;

-- Dropping the PRODUCT table
DROP TABLE PRODUCT CASCADE CONSTRAINTS;

-- Dropping the DISCOUNT table
DROP TABLE DISCOUNT CASCADE CONSTRAINTS;

-- Dropping the PRODUCT_CATEGORY table
DROP TABLE PRODUCT_CATEGORY CASCADE CONSTRAINTS;

-- Dropping the SHOP table
DROP TABLE SHOP CASCADE CONSTRAINTS;

-- Dropping the CUSTOMER table
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;

-- Dropping the TRADER table
DROP TABLE TRADER CASCADE CONSTRAINTS;

-- Dropping the ADMIN table
DROP TABLE ADMIN CASCADE CONSTRAINTS;

-- Dropping the "USER" table
DROP TABLE "USER" CASCADE CONSTRAINTS;

-- Creating user table
CREATE TABLE "USER" (
    User_id NUMBER(6),
    Username VARCHAR2(50) unique,
    Password VARCHAR2(4000),
    Email VARCHAR2(100) unique,
    First_name VARCHAR2(50),
    Last_name VARCHAR2(50),
    Contact_number VARCHAR2(10) unique,
    Role CHAR(1),
    Created_date DATE,
    Last_loggedin_date DATE
);

-- Adding primary key constraint for user_id
ALTER TABLE "USER"
ADD CONSTRAINT PK_USER_ID PRIMARY KEY (User_id);

-- Adding check constraint for role
ALTER TABLE "USER"
ADD CONSTRAINT CHK_USER_ROLE CHECK (Role IN ('A','T','C'));

-- Creating Admin table
CREATE TABLE ADMIN(
    User_id NUMBER(6)
);

-- Adding foreign key constraint for user_id
ALTER TABLE ADMIN
ADD CONSTRAINT FK_ADMIN_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

-- Creating Trader table
CREATE TABLE TRADER(
    User_id NUMBER(6),
    Address VARCHAR2(255),
    Status CHAR(1)
);

-- Adding foreign key constraint for user_id
ALTER TABLE TRADER
ADD CONSTRAINT FK_TRADER_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);
--Adding check constraint status
ALTER TABLE TRADER
ADD CONSTRAINT chk_trader_status check(status in('1','0'));

-- Creating Customer table
CREATE TABLE CUSTOMER(
    User_id NUMBER(6),
    Address VARCHAR2(255),
    Date_of_birth DATE,
    Gender CHAR(1),
    Profile_picture varchar2(100),
    Status CHAR(1)
);

-- Adding foreign key constraint for user_id
ALTER TABLE CUSTOMER
ADD CONSTRAINT FK_CUSTOMER_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

-- Adding check constraint for gender
ALTER TABLE CUSTOMER
ADD CONSTRAINT CHK_CUSTOMER_GENDER CHECK (Gender IN ('M','F','O'));

--Adding check constraint status
ALTER TABLE CUSTOMER
ADD CONSTRAINT chk_customer_status check(status in('1','0'));

-- Creating shop table
CREATE TABLE SHOP (
    Shop_id NUMBER(4),
    Shop_name VARCHAR2(100) unique,
    Shop_description VARCHAR2(2000),
    Location VARCHAR2(255),
    Picture varchar2(100),
    Contact_number VARCHAR2(10) unique,
    User_id NUMBER(6)
);

-- Adding primary key constraint for shop_id
ALTER TABLE SHOP
ADD CONSTRAINT PK_SHOP_ID PRIMARY KEY (Shop_id);

-- Adding foreign key constraint for user_id
ALTER TABLE SHOP
ADD CONSTRAINT FK_SHOP_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

-- Creating PRODUCT_CATEGORY table
CREATE TABLE PRODUCT_CATEGORY (
    Category_id NUMBER(4),
    Category_name VARCHAR2(100)
);

-- Adding primary key constraint for category_id
ALTER TABLE PRODUCT_CATEGORY
ADD CONSTRAINT PK_CATEGORY_ID PRIMARY KEY (Category_id);


-- Creating PRODUCT table
CREATE TABLE PRODUCT (
    Product_id NUMBER(8),
    Name VARCHAR2(100) unique,
    Image varchar2(100),
    Description VARCHAR2(2000),
    Price NUMBER(10, 2),
    Stock_Available NUMBER(8),
    Min_Order NUMBER(4),
    Max_Order NUMBER(4),
    Allergy_Information VARCHAR2(2000),
    Discount NUMBER(3),
    Status CHAR(1),
    Shop_id NUMBER(4),
    Category_id NUMBER(4)
);

-- Adding primary key constraint for product_id
ALTER TABLE PRODUCT
ADD CONSTRAINT PK_PRODUCT_ID PRIMARY KEY (Product_id);
--Adding check constraint status
ALTER TABLE PRODUCT
ADD CONSTRAINT chk_product_status check(status in('1','0'));

-- Adding foreign key constraints
ALTER TABLE PRODUCT
ADD CONSTRAINT FK_PRODUCT_SHOP_ID FOREIGN KEY (Shop_id) REFERENCES SHOP(Shop_id);

ALTER TABLE PRODUCT
ADD CONSTRAINT FK_PRODUCT_CATEGORY_ID FOREIGN KEY (Category_id) REFERENCES PRODUCT_CATEGORY(Category_id);

-- Creating DISCOUNT table
CREATE TABLE DISCOUNT (
    Discount_id NUMBER(4),
    Dis_percentage NUMBER(5, 2),
    Start_date DATE,
    End_date DATE,
    User_id NUMBER(6),
    Product_id NUMBER(8)
);

-- Adding primary key constraint for discount_id
ALTER TABLE DISCOUNT
ADD CONSTRAINT PK_DISCOUNT_ID PRIMARY KEY (Discount_id);

-- Adding foreign key constraint for user_id
ALTER TABLE DISCOUNT
ADD CONSTRAINT FK_DISCOUNT_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

-- Adding foreign key constraint for product_id
ALTER TABLE DISCOUNT
ADD CONSTRAINT FK_DISCOUNT_PRODUCT_ID FOREIGN KEY (Product_id) REFERENCES PRODUCT(product_id);


-- Creating REVIEW table
CREATE TABLE REVIEW (
    Review_id NUMBER(8),
    Rating NUMBER(5),
    User_comment VARCHAR2(4000),
    Review_Date DATE,
    Status CHAR(1),
    Product_id NUMBER(8),
    User_id NUMBER(6)
);

-- Adding primary key constraint for review_id
ALTER TABLE REVIEW
ADD CONSTRAINT PK_REVIEW_ID PRIMARY KEY (Review_id);

-- Adding foreign key constraints
ALTER TABLE REVIEW
ADD CONSTRAINT FK_REVIEW_PRODUCT_ID FOREIGN KEY (Product_id) REFERENCES PRODUCT(Product_id);

ALTER TABLE REVIEW
ADD CONSTRAINT FK_REVIEW_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

--Adding check constraint status
ALTER TABLE REVIEW
ADD CONSTRAINT chk_review_status check(status in('1','0'));

-- Creating FAVOURITE_ITEM table
CREATE TABLE FAVOURITE_ITEM (
    Favourite_item_id NUMBER(8),
    User_id NUMBER(6),
    Product_id NUMBER(8)
);

-- Adding primary key constraint for favourite_item_id
ALTER TABLE FAVOURITE_ITEM
ADD CONSTRAINT PK_FAVOURITE_ITEM_ID PRIMARY KEY (Favourite_item_id);

-- Adding foreign key constraints
ALTER TABLE FAVOURITE_ITEM
ADD CONSTRAINT FK_FAVOURITE_ITEM_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

ALTER TABLE FAVOURITE_ITEM
ADD CONSTRAINT FK_FAVOURITE_ITEM_PRODUCT_ID FOREIGN KEY (Product_id) REFERENCES PRODUCT(Product_id);

-- Creating CART table
CREATE TABLE CART (
    Cart_id NUMBER(6),
    User_id NUMBER(6)
);

-- Adding primary key constraint for cart_id
ALTER TABLE CART
ADD CONSTRAINT PK_CART_ID PRIMARY KEY (Cart_id);

-- Adding foreign key constraint for user_id
ALTER TABLE CART
ADD CONSTRAINT FK_CART_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

-- Creating CART_ITEM table
CREATE TABLE CART_ITEM (
    Cart_item_id NUMBER(6),
    Cart_id NUMBER(6),
    Product_id NUMBER(6),
    Quantity NUMBER(2)
);

-- Adding primary key constraint for cart_item_id
ALTER TABLE CART_ITEM
ADD CONSTRAINT PK_CART_ITEM_ID PRIMARY KEY (Cart_item_id);

-- Adding foreign key constraints
ALTER TABLE CART_ITEM
ADD CONSTRAINT FK_CART_ITEM_CART_ID FOREIGN KEY (Cart_id) REFERENCES CART(Cart_id);

ALTER TABLE CART_ITEM
ADD CONSTRAINT FK_CART_ITEM_PRODUCT_ID FOREIGN KEY (Product_id) REFERENCES PRODUCT(Product_id);

-- Creating COLLECTION_SLOT table
CREATE TABLE COLLECTION_SLOT (
    Collection_slot_id NUMBER(4),
    Start_time varchar2(8),
    End_time varchar2(8),
    Slot_Date DATE,
    Day_of_week VARCHAR2(3)
);

-- Adding primary key constraint for collection_slot_id
ALTER TABLE COLLECTION_SLOT
ADD CONSTRAINT PK_COLLECTION_SLOT_ID PRIMARY KEY (Collection_slot_id);

-- Adding check constraint for day_of_week
ALTER TABLE COLLECTION_SLOT
ADD CONSTRAINT CHK_DAY_OF_WEEK CHECK (Day_of_week IN ('WED','THU','FRI'));

-- Creating ORDER table
CREATE TABLE "ORDER" (
    Order_id NUMBER(8),
    Order_Date DATE,
    Total_price NUMBER(10, 2),
    Payment_confirmation CHAR(1),
    User_id NUMBER(6),
    Collection_slot_id NUMBER(4)
 );

-- Adding primary key constraint for order_id
ALTER TABLE "ORDER"
ADD CONSTRAINT PK_ORDER_ID PRIMARY KEY (Order_id);

-- Adding foreign key constraints
ALTER TABLE "ORDER"
ADD CONSTRAINT FK_ORDER_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

ALTER TABLE "ORDER"
ADD CONSTRAINT FK_ORDER_COLLECTION_SLOT_ID FOREIGN KEY (Collection_slot_id) REFERENCES COLLECTION_SLOT(Collection_slot_id);

-- Creating ORDER_ITEM table
CREATE TABLE ORDER_ITEM (
    Order_item_id NUMBER(8),
    Quantity NUMBER(2),
    Price NUMBER(10, 2),
    Discount NUMBER(10, 2),
    Total_Amount NUMBER(10, 2),
    Order_id NUMBER(8),
    Product_id NUMBER(8)
);

-- Adding primary key constraint for order_item_id
ALTER TABLE ORDER_ITEM
ADD CONSTRAINT PK_ORDER_ITEM_ID PRIMARY KEY (Order_item_id);

-- Adding foreign key constraints
ALTER TABLE ORDER_ITEM
ADD CONSTRAINT FK_ORDER_ITEM_ORDER_ID FOREIGN KEY (Order_id) REFERENCES "ORDER"(Order_id);

ALTER TABLE ORDER_ITEM
ADD CONSTRAINT FK_ORDER_ITEM_PRODUCT_ID FOREIGN KEY (Product_id) REFERENCES PRODUCT(Product_id);

-- Creating PAYMENT_METHOD table
CREATE TABLE PAYMENT_METHOD (
    Payment_method_id NUMBER(1),
    Method VARCHAR2(6)
);

-- Adding primary key constraint for payment_method_id
ALTER TABLE PAYMENT_METHOD
ADD CONSTRAINT PK_PAYMENT_METHOD_ID PRIMARY KEY (Payment_method_id);

-- Adding check constraint for method
ALTER TABLE PAYMENT_METHOD
ADD CONSTRAINT CHK_PAYMENT_METHOD CHECK (Method IN ('PAYPAL', 'STRIPE'));

-- Creating PAYMENT table
CREATE TABLE PAYMENT (
    Payment_id NUMBER(8),
    Amount NUMBER(10, 2),
    Payment_Date DATE,
    User_id NUMBER(6),
    Order_id NUMBER(6),
    Payment_method_id NUMBER(1)
);

-- Adding primary key constraint for payment_id
ALTER TABLE PAYMENT
ADD CONSTRAINT PK_PAYMENT_ID PRIMARY KEY (Payment_id);

-- Adding foreign key constraints
ALTER TABLE PAYMENT
ADD CONSTRAINT FK_PAYMENT_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

ALTER TABLE PAYMENT
ADD CONSTRAINT FK_PAYMENT_ORDER_ID FOREIGN KEY (Order_id) REFERENCES "ORDER"(Order_id);

ALTER TABLE PAYMENT
ADD CONSTRAINT FK_PAYMENT_PAYMENT_METHOD_ID FOREIGN KEY (Payment_method_id) REFERENCES PAYMENT_METHOD(Payment_method_id);

-- Creating REPORT table
CREATE TABLE REPORT (
    Report_id NUMBER(8),
    Report_Date DATE,
    Report_type VARCHAR2(100),
    User_id NUMBER(6),
    Order_id NUMBER(8),
    Product_id NUMBER(8)
);

-- Adding primary key constraint for report_id
ALTER TABLE REPORT
ADD CONSTRAINT PK_REPORT_ID PRIMARY KEY (Report_id);

-- Adding foreign key constraints
ALTER TABLE REPORT
ADD CONSTRAINT FK_REPORT_USER_ID FOREIGN KEY (User_id) REFERENCES "USER"(User_id);

ALTER TABLE REPORT
ADD CONSTRAINT FK_REPORT_ORDER_ID FOREIGN KEY (Order_id) REFERENCES "ORDER"(Order_id);

ALTER TABLE REPORT
ADD CONSTRAINT FK_REPORT_PRODUCT_ID FOREIGN KEY (Product_id) REFERENCES PRODUCT(Product_id);


--Trigger for User table
CREATE OR REPLACE TRIGGER tr_pkuserid
BEFORE INSERT ON "USER"
FOR EACH ROW
BEGIN
    -- Generate a new user id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(user_id), 0) + 1 INTO :NEW.user_id FROM "USER";
END;
/

--Trigger for Shop table
CREATE OR REPLACE TRIGGER tr_pkshopid
BEFORE INSERT ON SHOP
FOR EACH ROW
BEGIN
    -- Generate a new shop id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(shop_id), 0) + 1 INTO :NEW.shop_id FROM shop;
END;
/

-- Trigger for PRODUCT_CATEGORY table
CREATE OR REPLACE TRIGGER tr_pkcategoryid
BEFORE INSERT ON PRODUCT_CATEGORY
FOR EACH ROW
BEGIN
    -- Generate a new category id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Category_id), 0) + 1 INTO :NEW.Category_id FROM PRODUCT_CATEGORY;
END;
/

-- Trigger for DISCOUNT table
CREATE OR REPLACE TRIGGER tr_pkdiscountid
BEFORE INSERT ON DISCOUNT
FOR EACH ROW
BEGIN
    -- Generate a new discount id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Discount_id), 0) + 1 INTO :NEW.Discount_id FROM DISCOUNT;
END;
/

-- Trigger for PRODUCT table
CREATE OR REPLACE TRIGGER tr_pkproductid
BEFORE INSERT ON PRODUCT
FOR EACH ROW
BEGIN
    -- Generate a new product id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Product_id), 0) + 1 INTO :NEW.Product_id FROM PRODUCT;
END;
/

-- Trigger for REVIEW table
CREATE OR REPLACE TRIGGER tr_pkreviewid
BEFORE INSERT ON REVIEW
FOR EACH ROW
BEGIN
    -- Generate a new review id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Review_id), 0) + 1 INTO :NEW.Review_id FROM REVIEW;
END;
/

-- Trigger for FAVOURITE_ITEM table
CREATE OR REPLACE TRIGGER tr_pkfavouriteitemid
BEFORE INSERT ON FAVOURITE_ITEM
FOR EACH ROW
BEGIN
    -- Generate a new favourite item id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Favourite_item_id), 0) + 1 INTO :NEW.Favourite_item_id FROM FAVOURITE_ITEM;
END;
/

-- Trigger for CART table
CREATE OR REPLACE TRIGGER tr_pkcartsid
BEFORE INSERT ON CART
FOR EACH ROW
BEGIN
    -- Generate a new cart id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Cart_id), 0) + 1 INTO :NEW.Cart_id FROM CART;
END;
/

-- Trigger for CART_ITEM table
CREATE OR REPLACE TRIGGER tr_pkcartitemid
BEFORE INSERT ON CART_ITEM
FOR EACH ROW
BEGIN
    -- Generate a new cart item id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Cart_item_id), 0) + 1 INTO :NEW.Cart_item_id FROM CART_ITEM;
END;
/

-- Trigger for COLLECTION_SLOT table
CREATE OR REPLACE TRIGGER tr_pkcollectionslotid
BEFORE INSERT ON COLLECTION_SLOT
FOR EACH ROW
BEGIN
    -- Generate a new collection slot id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Collection_slot_id), 0) + 1 INTO :NEW.Collection_slot_id FROM COLLECTION_SLOT;
END;
/

-- Trigger for "ORDER" table
CREATE OR REPLACE TRIGGER tr_pkorderid
BEFORE INSERT ON "ORDER"
FOR EACH ROW
BEGIN
    -- Generate a new order id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Order_id), 0) + 1 INTO :NEW.Order_id FROM "ORDER";
END;
/

-- Trigger for ORDER_ITEM table
CREATE OR REPLACE TRIGGER tr_pkorderitemid
BEFORE INSERT ON ORDER_ITEM
FOR EACH ROW
BEGIN
    -- Generate a new order item id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Order_item_id), 0) + 1 INTO :NEW.Order_item_id FROM ORDER_ITEM;
END;
/

-- Trigger for PAYMENT table
CREATE OR REPLACE TRIGGER tr_pkpaymentid
BEFORE INSERT ON PAYMENT
FOR EACH ROW
BEGIN
    -- Generate a new payment id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Payment_id), 0) + 1 INTO :NEW.Payment_id FROM PAYMENT;
END;
/

-- Trigger for REPORT table
CREATE OR REPLACE TRIGGER tr_pkreportid
BEFORE INSERT ON REPORT
FOR EACH ROW
BEGIN
    -- Generate a new report id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(Report_id), 0) + 1 INTO :NEW.Report_id FROM REPORT;
END;
/

Drop table contact_us cascade constraint;
CREATE TABLE Contact_us (
    Contactus_id NUMBER(4),
    name varchar2(60),
    email varchar2(100),
    subject varchar2(100),
    message varchar2(2000)
);

ALTER TABLE Contact_us
ADD CONSTRAINT PK_Contactus_ID PRIMARY KEY (Contactus_id);

CREATE OR REPLACE TRIGGER tr_pkcontactusid
BEFORE INSERT ON Contact_us
FOR EACH ROW
BEGIN
    -- Generate a new shop id by finding the maximum existing ID and incrementing it by 1
    SELECT NVL(MAX(contactus_id), 0) + 1 INTO :NEW.contactus_id FROM contact_us;
END;
/

--Drop Jobs
BEGIN
  dbms_scheduler.drop_job(job_name => 'COLLECTION_SLOT_JOB');
END;
/
--Creating job// executes the fn_new_slot function every Saturday at midnight
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'Collection_Slot_JOB',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'DECLARE BEGIN dbms_output.put_line(fn_new_slot);END;',
        start_date      => sysdate,
        repeat_interval => 'freq=weekly; byday= TUE; BYHOUR=0; BYMINUTE=0; BYSECOND=0;',
        enabled         => TRUE
    );
END;
/

--Function to insert new collection slot after friday
create or replace function fn_new_slot 
return number 
is 
    v_next_wednesday date; 
    v_next_thursday date; 
    v_next_friday date; 
    v_count number;
begin 
 
    -- Calculate the dates for the upcoming Wednesday, Thursday, and Friday 
    select NEXT_DAY(TRUNC(SYSDATE), 'WEDNESDAY'), 
           NEXT_DAY(TRUNC(SYSDATE), 'THURSDAY'), 
           NEXT_DAY(TRUNC(SYSDATE), 'FRIDAY') 
    into v_next_wednesday, v_next_thursday, v_next_friday 
    from DUAL; 
 
select count(*) into v_count from collection_slot  where Slot_Date in (v_next_wednesday, v_next_thursday, v_next_friday);
 
 
        -- insert collection slots for the upcoming wednesday 
        insert into collection_slot 
        values (null,'10:00', '13:00', v_next_wednesday, 'WED'); 
 
        insert into collection_slot  
        values (null,'13:00', '16:00', v_next_wednesday, 'WED'); 
 
        insert into collection_slot  
        values (null,'16:00', '19:00', v_next_wednesday, 'WED'); 
        -- insert collection slots for the upcoming thursday 
        insert into collection_slot  
        values (null, '10:00', '13:00', v_next_thursday, 'THU'); 
 
        insert into collection_slot  
        values (null, '13:00', '16:00', v_next_thursday, 'THU'); 
 
        insert into collection_slot  
        values (null, '16:00', '19:00', v_next_thursday, 'THU'); 
        -- insert collection slots for the upcoming friday 
        insert into collection_slot  
        values (null, '10:00', '13:00', v_next_friday, 'FRI'); 
 
        insert into collection_slot  
        values (null,'13:00', '16:00', v_next_friday, 'FRI'); 
 
        insert into collection_slot  
        values (null, '16:00', '19:00', v_next_friday, 'FRI'); 
 
    return 1; 
exception 
    when others then 
        return 0; 
end; 
/


Create or replace function password_encrypt
(pword in varchar2)
return varchar2  is
l_password varchar2(4000);
l_salt varchar2(4000):= utl_raw.cast_to_raw('WRGFCVBJFXCVF543234568CFCBVCF'); 
begin
-- Hash the password with the salt using SHA-256 algorithm
    l_password := utl_raw.cast_to_raw(pword) ||l_salt;

-- Convert the hashed result to a hexadecimal string
    return l_password;
end;
/


CREATE OR REPLACE TRIGGER tr_new_cart
AFTER INSERT ON "USER"
FOR EACH ROW
BEGIN
    IF :NEW.Role = 'C' THEN
        INSERT INTO cart
        VALUES (null, :NEW.User_id);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_no_of_traders
BEFORE INSERT ON "USER"
FOR EACH ROW
DECLARE
num number(6);
BEGIN
    select count(user_id) into num from "USER" where role = 'T';
    IF num = 10 THEN
    raise_application_error(20001, 'Number of traders cannot exceed 10.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_orders_per_collectionslot
BEFORE INSERT ON "ORDER"
FOR EACH ROW
DECLARE
num number(6);
BEGIN
    select count(Collection_slot_id) into num from "ORDER" where Collection_slot_id = :NEW.Collection_slot_id;
    IF num = 20 THEN
    raise_application_error(20001, 'There can be only 20 orders per collection slot.');
    END IF;
END;
/

-- Creating a trigger to encrypt the password before inserting into user table
CREATE OR REPLACE TRIGGER tr_password_encrypt
BEFORE INSERT ON "USER"
FOR EACH ROW
BEGIN
    -- Call the encryption function and update the password field with the encrypted password
    :new.Password :=  password_encrypt(:new.Password);
END;
/

CREATE OR REPLACE TRIGGER tr_products_in_cart
BEFORE INSERT ON cart_item
FOR EACH ROW
DECLARE
num number(6);
BEGIN
    select count(cart_id) into num from cart_item where cart_id = :NEW.cart_id;
    IF num = 20 THEN
    raise_application_error(20001, 'There can be only 20 products in a cart at a time.');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER tr_stock_change
BEFORE INSERT ON order_item
FOR EACH ROW
DECLARE
old_qua number(6);
new_qua number(6);
BEGIN

    select stock_available into old_qua from product where product_id = :NEW.product_id;
    new_qua := old_qua - :NEW.quantity;
    update product
    set stock_available = new_qua where product_id = :NEW.product_id;
END;
/