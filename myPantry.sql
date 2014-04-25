
/*
 * SQLITE CREATE TABLE SCRIPT FOR myPantry
 *
 */
 
 drop table Category;
 drop table SubCategory;
 drop table Item;
 drop table ShoppingList;
 drop table ListItems;
 
 --
 -- Category table
 --

create table Category(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name TEXT NOT NULL);


--
-- Sub Category table
--
create table SubCategory(
    subID INTEGER PRIMARY KEY AUTOINCREMENT,
    categoryID INTEGER,
    subName TEXT NOT NULL, 
    FOREIGN KEY(categoryID) REFERENCES Category(id));

--
-- Item table
--
create table Item(
    categoryID INTEGER, 
    subID INTEGER NULL,
    itemName TEXT NOT NULL, 
    weight REAL, 
    brand TEXT, 
    expirationDate INTEGER, 
    --UNIQUE (categoryID, subID),
    FOREIGN KEY(categoryID) REFERENCES Category(id), 
    FOREIGN KEY(subID) REFERENCES SubCategory(subID));

--
-- Shopping List table
--
create table ShoppingList(
    listID INTEGER PRIMARY KEY AUTOINCREMENT, 
    listName TEXT NOT NULL, 
    createDate INTEGER NOT NULL);

--
-- Items belonging to shopping list table
--
create table ListItems(
    itemName TEXT, 
    listID INTEGER,
    FOREIGN KEY(itemName) REFERENCES Item(itemName), 
    FOREIGN KEY(listID) REFERENCES ShoppingList(listID)
    );
    
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
