TableMeta = Get_CObjectMetaData("SCH_LAB.Schedule")

Table = TableMeta.Content

-- print the table to see what it looks like before
print(Table)
print(TableMeta.Description)

TableMeta.Description = "Modified in Lua"

-- print the table to see what it looks like after
print(Table)
