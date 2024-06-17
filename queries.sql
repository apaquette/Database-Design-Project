--calculate the average parts consumption per completed repair
SELECT (COUNT(repairs.service_id)/COUNT(req.request_id)) AS "Average Parts Consumption Per Repair" FROM repairs
  INNER JOIN part_requests req ON repairs.service_id=req.service_id
    WHERE req.part_status="consumed" AND repairs.repair_status="completed";

--show how many repairs each technician has completed
SELECT concat(first_name, ' ', last_name) AS Name, count(r.service_id) AS Repairs from employees e
  LEFT JOIN repairs r ON e.employee_id=r.technician_id
    WHERE r.repair_status="completed" GROUP BY Name;

--return all parts of a model that is in repair by a specific technician
SELECT part_id AS "Model Parts" FROM part_inventory WHERE model_id IN
  (SELECT DISTINCT model_id FROM repairs WHERE technician_id IN
    (SELECT employee_id FROM employees FROM concat(first_name, ' ', last_name) = "Tim Cooke")
    AND repair_status LIKE "%progress%");

--calculate the repair fee from sum of part prices for a specific service id + service fee
SELECT SUM(price)+50 AS "Repair Fee" FROM part_inventory WHERE part_id IN
  (SELECT part_id FROM part_requests WHERE service_id=1);

--show customer info of customers who haven't paid their bills for more than three days
SELECT DISTINCT CONCAT(first_name, ' ', last_name) AS Name, email, phone_number FROM customer_contacts WHERE customer_id IN
  (SELECT customer_id FROM billable_quotes WHERE quote_status="sent" AND CURRENT_DATE()-date_sent > 3);

--show the parts that were never ordered
SELECT * FROM part_inventory WHERE part_id NOT IN
  (SELECT part_id FROM part_requests);

--show parts completed in december
SELECT COUNT(service_id) AS "December Repairs" FROM repairs
  WHERE completed_date BETWEEN '2021-12-1' AND '2021-12-31';

--look for parts that have word "board" in it
--this is especially useful for technicians who just want to search
--for all parts with a keyword
--it is easier to search for "board" rather than "system board" or "sub board"
SELECT * FROM part_inventory WHERE part_description LIKE "%board%";

--show parts that are requested, but not in stock
SELECT * FROM part_requests WHERE part_id IN
    (SELECT part_id FROM part_inventory WHERE stock=0);
