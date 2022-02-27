DROP DATABASE IF EXISTS invoice;
CREATE DATABASE invoice; 
USE invoice;

CREATE TABLE payment_methods 
(
  payment_method_id int NOT NULL,
  pname varchar(50) NOT NULL,
  PRIMARY KEY (payment_method_id)
);
INSERT INTO payment_methods VALUES (1,'Credit Card');
INSERT INTO payment_methods VALUES (2,'Cash');
INSERT INTO payment_methods VALUES (3,'PayPal');
INSERT INTO payment_methods VALUES (4,'Razorpay');

CREATE TABLE clients 
(
  client_id int NOT NULL,
  cname varchar(50) NOT NULL,
  address varchar(50) NOT NULL,
  city varchar(50) NOT NULL,
  state char(2) NOT NULL,
  phone varchar(50) NOT NULL,
  PRIMARY KEY (client_id)
);
INSERT INTO clients VALUES (1,'Vinte','3 Nevada Parkway','Syracuse','NY','315-252-7305');
INSERT INTO clients VALUES (2,'Myworks','34267 Glendale Parkway','Huntington','WV','304-659-1170');
INSERT INTO clients VALUES (3,'Yadel','096 Pawling Parkway','San Francisco','CA','415-144-6037');
INSERT INTO clients VALUES (4,'Kwideo','81674 Westerfield Circle','Waco','TX','254-750-0784');
INSERT INTO clients VALUES (5,'Topiclounge','0863 Farmco Road','Portland','OR','971-888-9129');

CREATE TABLE invoices
(
  invoice_no char(11) NOT NULL,
  client_id int NOT NULL,
  invoice_total decimal(9,2) NOT NULL,
  payment_total decimal(9,2) NOT NULL,
  invoice_date date NOT NULL,
  due_date date NOT NULL,
  PRIMARY KEY (invoice_no),
  CONSTRAINT `FK_client_id` FOREIGN KEY (client_id) REFERENCES clients (client_id) ON UPDATE CASCADE
);
INSERT INTO invoices VALUES ('91-953-3396',2,101.79,100.00,'2019-03-09','2019-03-29');
INSERT INTO invoices VALUES ('03-898-6735',5,175.32,170.00,'2019-06-11','2019-07-01');
INSERT INTO invoices VALUES ('20-228-0335',5,147.99,140.00,'2019-07-31','2019-08-20');
INSERT INTO invoices VALUES ('56-934-0748',3,152.21,150.00,'2019-03-08','2019-03-28');
INSERT INTO invoices VALUES ('87-052-3121',5,169.36,160.00,'2019-07-18','2019-08-07');
INSERT INTO invoices VALUES ('75-587-6626',1,157.78,137.55,'2019-01-29','2019-02-18');

CREATE TABLE payments
 (
  payment_id int NOT NULL,
  client_id int NOT NULL,
  invoice_no char(11) NOT NULL,
  payment_date date NOT NULL,
  amount decimal(9,2) NOT NULL,
  payment_method int NOT NULL,
  PRIMARY KEY (payment_id),
  CONSTRAINT fk_payment_client FOREIGN KEY (client_id) REFERENCES clients (client_id) ON UPDATE CASCADE,
  CONSTRAINT fk_payment_invoice FOREIGN KEY (invoice_no) REFERENCES invoices (invoice_no) ON UPDATE CASCADE,
  CONSTRAINT fk_payment_payment_method FOREIGN KEY (payment_method) REFERENCES payment_methods (payment_method_id)
);
INSERT INTO payments VALUES (1,5,'91-953-3396','2019-02-12',8.18,1);
INSERT INTO payments VALUES (2,1,'03-898-6735','2019-01-03',74.55,1);
INSERT INTO payments VALUES (3,3,'20-228-0335','2019-01-11',0.03,1);
INSERT INTO payments VALUES (4,5,'56-934-0748','2019-01-26',87.44,1);
INSERT INTO payments VALUES (5,3,'87-052-3121','2019-01-15',80.31,1);
INSERT INTO payments VALUES (6,3,'75-587-6626','2019-01-15',68.10,1);

select * from payment_methods;
select * from clients;
select * from invoices;
select * from payments;






