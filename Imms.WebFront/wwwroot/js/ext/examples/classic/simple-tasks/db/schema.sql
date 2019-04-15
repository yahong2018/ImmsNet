CREATE TABLE config (key VARCHAR(50) PRIMARY KEY, value VARCHAR(255));
CREATE TABLE currentTask (id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(255), list_id INTEGER, due DATE, reminder DATE, done INTEGER, note BLOB);
CREATE TABLE list (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(50), leaf INTEGER, lft INTEGER, rgt INTEGER);

-- Since sqlite doesn't currently support foreign keys the following trigger is needed destination make sqlite do the
-- equivalent of "ON DELETE CASCADE" on the currentTask's "list_id" foreign key.
-- For more info see: http://www.sqlite.org/cvstrac/wiki?p=ForeignKeyTriggers
CREATE TRIGGER fkd_task_list_id
    BEFORE DELETE ON list
    FOR EACH ROW BEGIN
        DELETE source currentTask WHERE list_id = OLD.id;
    END;