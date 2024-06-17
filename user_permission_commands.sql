CREATE USER admin;
GRANT ALL PRIVILEGES ON * TO admin;

CREATE USER technician_manager;

GRANT SELECT ON technician_manager_view TO technician_manager;
GRANT INSERT ON technician_manager_view TO technician_manager;
GRANT UPDATE ON technician_manager_view TO technician_manager;

GRANT SELECT ON repairs TO technician_manager;
GRANT INSERT ON repairs TO technician_manager;
GRANT UPDATE ON repairs TO technician_manager;
GRANT DELETE ON repairs TO technician_manager;

GRANT SELECT ON part_inventory TO technician_manager;

GRANT INSERT ON part_requests TO technician_manager;

CREATE USER csr_manager;

GRANT SELECT ON csr_manager_view TO csr_manager;
GRANT INSERT ON csr_manager_view TO csr_manager;
GRANT UPDATE ON csr_manager_view TO csr_manager;


GRANT SELECT ON billable_quotes TO csr_manager;
GRANT INSERT ON billable_quotes TO csr_manager;
GRANT UPDATE ON billable_quotes TO csr_manager;
GRANT DELETE ON billable_quotes TO csr_manager;

GRANT SELECT ON customer_contacts TO csr_manager;
GRANT INSERT ON customer_contacts TO csr_manager;
GRANT UPDATE ON customer_contacts TO csr_manager;
GRANT DELETE ON customer_contacts TO csr_manager;

GRANT SELECT ON computer_models TO csr_manager;
GRANT INSERT ON computer_models TO csr_manager;

GRANT SELECT ON part_inventory TO csr_manager;
GRANT INSERT ON part_inventory TO csr_manager;

GRANT SELECT ON part_requests TO csr_manager;

CREATE USER warehouse_manager;

GRANT SELECT ON warehouse_manager_view TO warehouse_manager;
GRANT INSERT ON warehouse_manager_view TO warehouse_manager;
GRANT UPDATE ON warehouse_manager_view TO warehouse_manager;

GRANT SELECT ON part_inventory TO warehouse_manager;
GRANT INSERT ON part_inventory TO warehouse_manager;
GRANT UPDATE ON part_inventory TO warehouse_manager;
GRANT DELETE ON part_inventory TO warehouse_manager;

GRANT SELECT ON part_requests TO warehouse_manager;
GRANT UPDATE ON part_requests TO warehouse_manager;
GRANT DELETE ON part_requests TO warehouse_manager;

CREATE USER technician;

GRANT SELECT ON repairs TO technician;
GRANT INSERT ON repairs TO technician;
GRANT UPDATE ON repairs TO technician;

GRANT SELECT ON part_inventory TO technician;

GRANT INSERT ON part_requests TO technician;

CREATE USER warehouse_clerk;

GRANT SELECT ON part_inventory TO warehouse_clerk;
GRANT INSERT ON part_inventory TO warehouse_clerk;
GRANT UPDATE ON part_inventory TO warehouse_clerk;

GRANT SELECT ON part_requests TO warehouse_clerk;
GRANT UPDATE ON part_requests TO warehouse_clerk;

CREATE USER csr;

GRANT SELECT ON billable_quotes TO csr;
GRANT INSERT ON billable_quotes TO csr;
GRANT UPDATE ON billable_quotes TO csr;

GRANT SELECT ON customer_contacts TO csr;
GRANT INSERT ON customer_contacts TO csr;
GRANT UPDATE ON customer_contacts TO csr;

GRANT INSERT ON computer_models TO csr;

GRANT SELECT ON part_inventory TO csr;
GRANT INSERT ON part_inventory TO csr;

GRANT SELECT ON part_requests TO csr;

GRANT SELECT ON repairs TO csr;

FLUSH PRIVILEGES;
