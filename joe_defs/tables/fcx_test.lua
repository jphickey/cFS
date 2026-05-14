-- Input File for FCX

Header = EdsDB.NewObject("CFE_FS/FileObject")

CmdIf = EdsDB.GetInterface("SAMPLE_APP/Application/CMD")
Cmd1 = EdsDB.NewMessage(CmdIf, "ProcessCmd")

CmdMeta = EdsDB.GetMetaData(Cmd1)

Header.SubType = 0x00004643
Header.Length = CmdMeta.BitSize / 8
Header.Description = "FCX test command"

-- print the Cmd to see what it looks like after
print(Header)

Write_GenericFile("fcx_test.bin", { Header, Cmd1 })
