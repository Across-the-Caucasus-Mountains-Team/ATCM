@echo off
setlocal enabledelayedexpansion

:: Input and output files
set INPUT=goals.gfx
set OUTPUT=goals_shine.gfx

:: Clear output file
> %OUTPUT% echo.

:: Read each line of input
for /f "usebackq tokens=* delims=" %%A in ("%INPUT%") do (
    set "line=%%A"

    :: Detect name line
    echo !line! | findstr /c:"name = " >nul && (
        for /f "tokens=2 delims== " %%N in ("!line!") do (
            set "baseName=%%~N"
            set "baseName=!baseName:"=!"
            set "newName=!baseName!_shine"
        )
    )

    :: Detect texturefile line
    echo !line! | findstr /c:"texturefile = " >nul && (
        for /f "tokens=2 delims== " %%T in ("!line!") do (
            set "textureFile=%%~T"
            set "textureFile=!textureFile:"=!"
        )
    )

    :: When closing brace is found, output the full new SpriteType
    echo !line! | findstr /c:"}" >nul && (
        >> %OUTPUT% (
            echo SpriteType = {
            echo.	name = "!newName!"
            echo.	texturefile = "!textureFile!"
            echo.	effectFile = "gfx/FX/buttonstate.lua"
            echo.	animation = {
            echo.		animationmaskfile = "!textureFile!"
            echo.		animationtexturefile = "gfx/interface/goals/shine_overlay.dds"
            echo.		animationrotation = -90.0
            echo.		animationlooping = no
            echo.		animationtime = 0.75
            echo.		animationdelay = 0
            echo.		animationblendmode = "add"
            echo.		animationtype = "scrolling"
            echo.		animationrotationoffset = { x = 0.0 y = 0.0 }
            echo.		animationtexturescale = { x = 1.0 y = 1.0 }
            echo.	}
            echo.	animation = {
            echo.		animationmaskfile = "!textureFile!"
            echo.		animationtexturefile = "gfx/interface/goals/shine_overlay.dds"
            echo.		animationrotation = 90.0
            echo.		animationlooping = no
            echo.		animationtime = 0.75
            echo.		animationdelay = 0
            echo.		animationblendmode = "add"
            echo.		animationtype = "scrolling"
            echo.		animationrotationoffset = { x = 0.0 y = 0.0 }
            echo.		animationtexturescale = { x = 1.0 y = 1.0 }
            echo.	}
            echo.	legacy_lazy_load = no
            echo }
            echo.
        )
    )
)

echo Done. Output saved to %OUTPUT%.
pause
