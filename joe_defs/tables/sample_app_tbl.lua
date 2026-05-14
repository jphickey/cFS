-- Input Table for the Sample App
--
-- NOTE:
-- All table definitions are defined in sample_app.xml

-- Note: The data is also stored in a global of the same name
-- However this gives access to the metadata (e.g. TgtFilename, Description, etc)
TableMeta = Get_CObjectMetaData("SAMPLE_APP.ExampleTable")

Table = TableMeta.Content

-- print the table to see what it looks like before
print(Table)
print(TableMeta.Description)

Table.Int1 = 8
Table.Int2 = -3
TableMeta.Description = "Modified in Lua"

-- print the table to see what it looks like after
print(Table)
