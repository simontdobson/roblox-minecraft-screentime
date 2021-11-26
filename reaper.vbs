Option Explicit
Dim objLoc
Set objLoc = CreateObject("wbemscripting.swbemlocator")
objLoc.Security_.privileges.addasstring "sedebugprivilege", true
    Dim args
    Set args = Wscript.Arguments
    Dim objFile2, objFSO, result,resultCode
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set objFile2 = objFSO.OpenTextFile("C:\scripts\roblox.log", 8)
    Dim objWMIService, colProcess, objProcess
    set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _ 
    & ".\root\cimv2")
    Set colProcess = objWMIService.ExecQuery _
    ("Select * from Win32_Process Where ProcessId = '" & args(0) & "'")
    For Each objProcess in colProcess
	
        resultCode=objProcess.Terminate()
        Select Case resultCode
        Case 0 result="Success"
        Case 2 result="Access Denied"
        Case 3 result="Insufficient privilege"
        Case 8 result="Unknown Failure"
        Case 9 result="Path Not Found"
        Case 21 result="Invalid Parameter"
        End Select
        objFile2.WriteLine "Reaper Stopping," & objProcess.Name & "," & objProcess.ProcessId & "," & result
    Next
    objFile2.Close