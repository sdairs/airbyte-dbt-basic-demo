CREATE SCHEMA test AUTHORIZATION postgres;
CREATE TABLE test.test (
	col1 varchar NULL,
	col2 varchar NULL
);

insert into test.test values
('row1_col1', 'row1_col2'),
('row2_col1', 'row2_col2'),
('row3_col1', 'row3_col2'),
('row4_col1', 'row4_col2'),
('row5_col1', 'row5_col2');
