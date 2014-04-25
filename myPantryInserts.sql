/*
 * SQLite INSERT statement for myPantry App
 *
 */
 
 --
 -- Category
 --
 
 INSERT INTO Category VALUES(null, 'Meats');
 INSERT INTO Category VALUES(null, 'Seafood');
 INSERT INTO Category VALUES(null, 'Dairy');
 INSERT INTO Category VALUES(null, 'Dry Goods');
 INSERT INTO Category VALUES(null, 'Fruits/Vegetables');
 INSERT INTO Category VALUES(null, 'Frozen Foods');
 
 --
 -- SubCategory
 --
 INSERT INTO SubCategory VALUES(null, 1, 'Beef');
 INSERT INTO SubCategory VALUES(null, 1, 'Poultry');
 INSERT INTO SubCategory VALUES(null, 1, 'Pork');
 INSERT INTO SubCategory VALUES(null, 1, 'Bison');
 INSERT INTO SubCategory VALUES(null, 1, 'Elk');
 INSERT INTO SubCategory VALUES(null, 2, 'Fish');
 
 --
 -- Item
 --
 INSERT INTO Item VALUES (1, 1, 'Short Ribs', 2, 'Morris GrassFed Beef', null);
 INSERT INTO Item VALUES (1, 1, 'Rib Eye', 1, 'Marin Sun Farms', null);
 INSERT INTO Item VALUES (1, 2, 'Chicken Thighs', 1, 'Marin Sun Farms', null);
 INSERT INTO Item VALUES (1, 2, 'Whole Chicken', 2, 'Early Bird Ranch', null);
 INSERT INTO Item VALUES (1, 3, 'Chops', .5, 'Full of Life Farm', null);
