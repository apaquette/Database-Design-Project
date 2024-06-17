CREATE TABLE departments
	(department_name VARCHAR(20),
	PRIMARY KEY(department_name));

CREATE TABLE quote_statuses
	(quote_status VARCHAR(12),
	PRIMARY KEY(quote_status));

CREATE TABLE repair_statuses
	(repair_status VARCHAR(15), status_description VARCHAR(50),
	PRIMARY KEY(repair_status));

CREATE TABLE part_request_statuses
	(part_request_status VARCHAR(12), status_description VARCHAR(50),
	PRIMARY KEY(part_request_status));

CREATE TABLE computer_models
	(model_id VARCHAR(20), product_name VARCHAR(50), brand VARCHAR(30),
	PRIMARY KEY(model_id));

CREATE TABLE employees
	(employee_id INT, first_name VARCHAR(20), last_name VARCHAR(20), salary DOUBLE(8, 2) NOT NULL, manager INT, department VARCHAR(20) NOT NULL,
	PRIMARY KEY(employee_id),
	FOREIGN KEY(manager) REFERENCES employees(employee_id),
	FOREIGN KEY(department) REFERENCES departments(department_name));

CREATE TABLE customer_contacts
	(customer_id INT, first_name VARCHAR(20), last_name VARCHAR(20), email VARCHAR(50), phone_number VARCHAR(15),
	PRIMARY KEY(customer_id));

CREATE TABLE repairs
	(service_id INT,  technician_id INT,  model_id VARCHAR(20), repair_summary VARCHAR(300), serial_number VARCHAR(50) NOT NULL, received_date DATE NOT NULL, completed_date DATE, repair_status VARCHAR(15) NOT NULL DEFAULT 'received',
	PRIMARY KEY (service_id),
	FOREIGN KEY(technician_id) REFERENCES employees(employee_id),
	FOREIGN KEY(model_id) REFERENCES computer_models(model_id),
	FOREIGN KEY(repair_status) REFERENCES repair_statuses(repair_status));

CREATE TABLE billable_quotes
	(quote_id INT, csr_id INT, customer_id INT, total DOUBLE(7,2), quote_status VARCHAR(12) NOT NULL DEFAULT 'pending', date_sent DATE, date_paid DATE,
	PRIMARY KEY (quote_id),
	FOREIGN KEY (quote_id) REFERENCES repairs(service_id),
	FOREIGN KEY (csr_id) REFERENCES employees(employee_id),
	FOREIGN KEY (customer_id) REFERENCES customer_contacts(customer_id),
	FOREIGN KEY (quote_status) REFERENCES quote_statuses(quote_status));

CREATE TABLE part_inventory
	(part_id VARCHAR(20), model_id VARCHAR(20), part_description VARCHAR(300), stock INT NOT NULL DEFAULT 0, price DOUBLE(7,2) NOT NULL,
	PRIMARY KEY (part_id),
	FOREIGN KEY (model_id) REFERENCES computer_models(model_id));

CREATE TABLE part_requests
	(request_id INT, clerk_id INT, technician_id INT, service_id INT, part_id VARCHAR(20), date_submitted DATE NOT NULL, date_processed DATE, part_status VARCHAR(15) NOT NULL DEFAULT 'pending',
	PRIMARY KEY (request_id),
	FOREIGN KEY (clerk_id) REFERENCES employees(employee_id),
	FOREIGN KEY (technician_id) REFERENCES employees(employee_id),
	FOREIGN KEY (service_id) REFERENCES repairs(service_id),
	FOREIGN KEY (part_id) REFERENCES part_inventory(part_id),
	FOREIGN KEY (part_status) REFERENCES part_request_statuses(part_request_status));

	INSERT INTO departments VALUES("admin");
	INSERT INTO departments VALUES("warehouse");
	INSERT INTO departments VALUES("repair");
	INSERT INTO departments VALUES("csr");

	INSERT INTO quote_statuses VALUES("sent");
	INSERT INTO quote_statuses VALUES("pending");
	INSERT INTO quote_statuses VALUES("paid");
	INSERT INTO quote_statuses VALUES("rejected");

	INSERT INTO repair_statuses VALUES("received", "received for repair");
	INSERT INTO repair_statuses VALUES("in progress", "in repair with technician");
	INSERT INTO repair_statuses VALUES("completed", "repair completed");
	INSERT INTO repair_statuses VALUES("hfp", "hold for parts");
	INSERT INTO repair_statuses VALUES("hfi", "hold for customer info");
	INSERT INTO repair_statuses VALUES("hfm", "hold for recovery media");
	INSERT INTO repair_statuses VALUES("hfb", "hold for billable");
	INSERT INTO repair_statuses VALUES("hfe", "hold for engineering");
	INSERT INTO repair_statuses VALUES("sbu", "ship back unrepaired");

	INSERT INTO part_request_statuses(part_request_status) VALUES("pending");
	INSERT INTO part_request_statuses(part_request_status) VALUES("shortage");
	INSERT INTO part_request_statuses(part_request_status) VALUES("delivered");
	INSERT INTO part_request_statuses VALUES("consumed", "consumed for repair");
	INSERT INTO part_request_statuses VALUES("doa", "part dead on arrival");
	INSERT INTO part_request_statuses VALUES("rts", "returned to stock");


	CREATE INDEX repairs_index
		ON repairs (received_date);
	CREATE INDEX part_requests_index
		ON part_requests (date_submitted);
	CREATE INDEX part_inventory_index
		ON part_inventory (model_id);
	CREATE INDEX billable_quote_index
		ON billable_quotes (date_sent);

	CREATE VIEW technician_manager_view AS
		SELECT * FROM employees WHERE department = "repair";

	CREATE VIEW csr_manager_view AS
		SELECT * FROM employees WHERE department = "csr";

	CREATE VIEW warehouse_manager_view AS
		SELECT * FROM employees WHERE department = "warehouse";


INSERT INTO employees(employee_id, first_name, last_name, salary, department)
VALUES(1, "Michael", "Scott", 89500, "admin");

INSERT INTO employees
VALUES(2, "Dwight", "Schrute", 82000, 1, "repair");

INSERT INTO employees
VALUES(3, "Jim", "Halpert", 82000, 1, "csr");

INSERT INTO employees
VALUES(4, "Darryl", "Philbin", 82000, 1, "warehouse");


INSERT INTO employees
VALUES(5, "Tim", "Cooke", 71000, 2, "repair");

INSERT INTO employees
VALUES(6, "Rebecca", "Schuler", 68500, 2, "repair");

INSERT INTO employees
VALUES(7, "Kelly", "Kapoor", 67750, 2, "repair");


INSERT INTO employees
VALUES(8, "John", "Jacobs", 73000, 3, "csr");

INSERT INTO employees
VALUES(9, "Yu", "Mi", 78000, 3, "csr");

INSERT INTO employees
VALUES(10, "Paulo", "Kang", 69550, 3, "csr");


INSERT INTO employees
VALUES(11, "Patrick", "O\'Brien", 58500, 4, "warehouse");

INSERT INTO employees
VALUES(12, "David", "Levy", 52150, 4, "warehouse");

INSERT INTO employees
VALUES(13, "Sean", "Cooper", 51950, 4, "warehouse");



INSERT INTO customer_contacts
VALUES(1, "Jimmy", "Clementine", "JC@hotmail.com", "786-555-8912");

INSERT INTO customer_contacts
VALUES(2, "Wanda", "Baker", "Wanda_Baker@gmail.ca", "786-555-1564");

INSERT INTO customer_contacts
VALUES(3, "Jotaro", "Kujo", "Kujojoyo@aol.com", "364-555-9884");


INSERT INTO computer_models
VALUES("ZA6F0008CA", "IdeaPad Duet Chromebook (CT-X636F)", "Lenovo");

INSERT INTO computer_models
VALUES("82B1000AUS", "Legion 5-15ARH05H Laptop", "Lenovo");

INSERT INTO computer_models
VALUES("82BHCTO1WW", "Yoga 7-14ITL5 Laptop (ideapad) - Type 82BH", "Lenovo");



INSERT INTO repairs
VALUES(1, 5, "ZA6F0008CA", "Customer said that their computer won't turn on after spilling grape soda in speakers", "P2069P9V", "2021-12-06", NULL, "hfp");

INSERT INTO repairs
VALUES(2, 6, "82B1000AUS", "Customer said that the battery overheats, windows alerts overheating warning and then shuts down.", "R90R4QBN", "2021-12-06", "2021-12-07", "completed");

INSERT INTO repairs
VALUES(3, 7, "82BHCTO1WW", "Customer's data is locked behind malicious software demanding money for decryption.", "PF1VY4ZT", "2021-12-05", "2021-12-06", "completed");

INSERT INTO repairs
VALUES(4, 5, "ZA6F0008CA", "", "P105989V", "2021-12-07", NULL, "in progress");

INSERT INTO repairs
VALUES(5, 6, "82B1000AUS", "", "R80R3QAN", "2021-12-07", NULL, "in progress");

INSERT INTO repairs
VALUES(6, 7, "82BHCTO1WW", "", "PF2VY5AT", "2021-12-07", NULL, "in progress");



INSERT INTO part_inventory
VALUES("5SB0T45109", "ZA6F0008CA", "Speakers", 3, 32.96);

INSERT INTO part_inventory
VALUES("5C20T79484", "ZA6F0008CA", "Webcam", 5, 34.95);

INSERT INTO part_inventory
VALUES("02DL101", "ZA6F0008CA", "Charger", 30, 29.95);

INSERT INTO part_inventory
VALUES("5C10T70886", "ZA6F0008CA", "LCD Cable", 10, 16.95);

INSERT INTO part_inventory
VALUES("5D10T79593", "ZA6F0008CA", "LCD Panel", 20, 248.95);

INSERT INTO part_inventory
VALUES("5B20T79600", "ZA6F0008CA", "System Board", 0, 399.99);

INSERT INTO part_inventory
VALUES("5B10S73397", "ZA6F0008CA", "Battery", 50, 69.95);



INSERT INTO part_inventory
VALUES("01AV493", "82B1000AUS", "Laptop Battery", 18, 65.99);

INSERT INTO part_inventory
VALUES("00UP490", "82B1000AUS", "M.2 SSD", 5, 587.95);

INSERT INTO part_inventory
VALUES("01YR477", "82B1000AUS", "Speakers", 10, 32.77);

INSERT INTO part_inventory
VALUES("01HW018", "82B1000AUS", "Webcam", 12, 37.69);

INSERT INTO part_inventory
VALUES("01FR031", "82B1000AUS", "Charger", 18, 19.99);

INSERT INTO part_inventory
VALUES("01ER030", "82B1000AUS", "LCD Cable", 10, 15.35);

INSERT INTO part_inventory
VALUES("00UR894", "82B1000AUS", "LCD Panel", 18, 223.87);

INSERT INTO part_inventory
VALUES("01YR306", "82B1000AUS", "System Board", 18, 1124.95);

INSERT INTO part_inventory
VALUES("01LX200", "82BHCTO1WW", "Storage Device (SSD)", 20, 100.95);

INSERT INTO part_inventory
VALUES("5SB0V25485", "82BHCTO1WW", "Speakers", 15, 43.95);

INSERT INTO part_inventory
VALUES("01HW060", "82BHCTO1WW", "Webcam", 5,31.95);

INSERT INTO part_inventory
VALUES("02DL127", "82BHCTO1WW", "Charger", 12, 29.95);

INSERT INTO part_inventory
VALUES("5C10V25068", "82BHCTO1WW", "LCD Cable", 7, 21.95);

INSERT INTO part_inventory
VALUES("01YN157", "82BHCTO1WW", "LCD Panel", 4, 183.95);

INSERT INTO part_inventory
VALUES("01YU350", "82BHCTO1WW", "System Board", 3, 656.95);

INSERT INTO part_inventory
VALUES("02DL004", "82BHCTO1WW", "Battery", 8, 72.95);



INSERT INTO part_requests
VALUES(1, 11, 5, 1, "5SB0T45109", "2021-12-06", "2021-12-06", "delivered");

INSERT INTO part_requests
VALUES(2, 11, 5, 1, "5B20T79600", "2021-12-06", NULL, "shortage");

INSERT INTO part_requests
VALUES(3, 12, 6, 2, "01AV493", "2021-12-06", "2021-12-06", "consumed");

INSERT INTO part_requests
VALUES(4, 13, 7, 3, "01LX200", "2021-12-07", "2021-12-07", "consumed");

INSERT INTO part_requests
VALUES(5, 11, 5, 4, "01LX200", "2021-12-05", "2021-12-05", "consumed");



INSERT INTO billable_quotes
VALUES(1, 8, 1, 482.95, "pending", "2021-12-06", NULL);

INSERT INTO billable_quotes
VALUES(2, 9, 2, 115.99, "paid", "2021-12-06", "2021-12-06");

INSERT INTO billable_quotes
VALUES(3, 10, 3, 150.95, "paid", "2021-12-06", "2021-12-06");

INSERT INTO billable_quotes
VALUES(4, 8, 1, NULL, "pending", NULL, NULL);

INSERT INTO billable_quotes
VALUES(5, 8, 2, NULL, "pending", NULL, NULL);

INSERT INTO billable_quotes
VALUES(6, 8, 3, NULL, "pending", NULL, NULL);
