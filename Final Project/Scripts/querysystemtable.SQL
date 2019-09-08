/*SELECT * FROM sys.tables;
SELECT * FROM sys.check_constraints;
SELECT * FROM sys.key_constraints;
SELECT * FROM sys.foreign_keys;*/

SElECT sys.tables.object_id, 
		sys.tables.name 'Table Name', 
		sys.check_constraints.name 'Object Name',
		sys.check_constraints.type_desc 'Object Type',
		sys.check_constraints.definition 'Definition'
		From sys.tables
RIGHT JOIN sys.check_constraints ON sys.tables.object_id=sys.check_constraints.parent_object_id 
UNION ALL
SElECT sys.tables.object_id, 
		sys.tables.name 'Table Name', 
		sys.key_constraints.name 'Object Name',
		sys.key_constraints.type_desc 'Object Type',
		'N/A'
		From sys.tables
Right JOIN sys.key_constraints ON sys.tables.object_id=sys.key_constraints.parent_object_id 
UNION ALL
SElECT sys.tables.object_id, 
		sys.tables.name 'Table Name', 
		sys.foreign_keys.name 'Object Name',
		sys.foreign_keys.type_desc 'Object Type',
		'N/A'
		From sys.tables
Right JOIN sys.foreign_keys ON sys.tables.object_id=sys.foreign_keys.parent_object_id 
ORDER BY sys.tables.name ASC;
