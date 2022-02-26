CREATE DATABASE inventory 
USE inventory


CREATE TABLE product_inventory
(
product_id int primary key,
productname varchar(50) not null,
quantity_in_stock int not null,
unitprice int not null
)

INSERT INTO product_inventory VALUES (1,'notebook',500,25)
INSERT INTO product_inventory VALUES (2,'pencil',400,5)
INSERT INTO product_inventory VALUES (3,'rubber',250,3)
INSERT INTO product_inventory VALUES (4,'pen',500,10)
INSERT INTO product_inventory VALUES (5,'gum',100,15)
INSERT INTO product_inventory VALUES (6,'scale',150,8)
INSERT INTO product_inventory VALUES (7,'sharpener',300,4)

CREATE TABLE product_sales
(
trans_id int primary key,
product_id int not null,
quantity_sold int not null,
trans_date  date not null,
constraint fk_product_sales_product_id FOREIGN KEY (product_id) REFERENCES product_inventory (product_id) 
)

-- created a stored procedure that automatically update the inventory of products each time a sales occur
-- and insert each transaction details into the product_sales table

Create Procedure spInventory_Sales_Management
@ProductId int,
@QuantityToSell int,
@t_date date
as
Begin
 -- Check the stock available, for the product we want to sell
 Declare @StockAvailable int
 Select @StockAvailable = quantity_in_stock
                          from product_inventory where product_id = @ProductId
 
 -- Throw an error to the calling application, if enough stock is not available
 if(@StockAvailable < @QuantityToSell)
   Begin
       Raiserror('Not enough stock available',16,1)
   End
 -- If enough stock available
 Else
   Begin
    Begin Tran
         -- First reduce the quantity available
  Update product_inventory set quantity_in_stock = (quantity_in_stock - @QuantityToSell)
  where product_id = @ProductId
  
  Declare @Maxtrans_id int
  -- Calculate MAX ProductSalesId  
  Select @Maxtrans_id  = Case When 
                               MAX(trans_id) IS NULL 
                               Then 0 else MAX(trans_id) end 
                               from product_sales
  -- Increment @Maxtrans_id by 1, so we don't get a primary key violation
  Set @Maxtrans_id = @Maxtrans_id + 1
  Insert into product_sales values(@Maxtrans_id, @ProductId, @QuantityToSell,@t_date)
    Commit Tran
   End
End

execute spInventory_Sales_Management 4,10,'2022-01-15'
execute spInventory_Sales_Management 4,30,'2022-01-15'
execute spInventory_Sales_Management 1,20,'2022-01-16'
execute spInventory_Sales_Management 1,10,'2022-01-17'
execute spInventory_Sales_Management 6,5,'2022-01-17'
execute spInventory_Sales_Management 7,10,'2022-01-17'

select * from product_inventory
select * from product_sales 

