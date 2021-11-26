On Error Resume Next
Err.Clear
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile2 = objFSO.OpenTextFile("C:\scripts\roblox.log", 8)
Set objShell = CreateObject("Wscript.Shell")
objFile2.WriteLine Now & ",call lock"
objShell.Run "%windir%\System32\rundll32.exe user32.dll,LockWorkStation"
objFile2.WriteLine Now & ",returned from lock"
If Err.Number <> 0 Then
  objFile2.WriteLine Err.Number
  objFile2.WriteLine Err.Source
  objFile2.WriteLine Err.Description
  Err.Clear
End If
On Error Goto 0
objFile2.Close