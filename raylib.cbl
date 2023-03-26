       copy "cabi.cpy".
      *
      ******************************************************************
      *Initialize Raylib proper, takes a procedure pointer
       identification division.
       program-id. raylib-init.
       data division.
       working-storage section.
       01  ws-title picture x(24) value is z"Raylib-Cobol".
       01  ws-screen-width usage is binary-short value is 1024.
       01  ws-screen-height usage is binary-short value is 720.
       01  ws-fps usage is binary-short value is 30.
       01  ws-should-close usage is binary-short.
       linkage section.
       01  ls-user usage is pointer.
       01  ls-load usage is program-pointer.
       01  ls-prog usage is program-pointer.
       procedure division using by value ls-user
           by value ls-load
           by value ls-prog
           returning omitted.
      *
           call "InitWindow" using
               by value ws-screen-width
               by value ws-screen-height
               by reference ws-title end-call.
           call "SetTargetFPS" using by value ws-fps end-call.
      *
           if ls-load is not equal to null then
               call ls-load using by value ls-user end-call
           end-if.
      *
           perform until ws-should-close is not equal zero
               perform window-loop
           end-perform.
      *
           call "CloseWindow" end-call.
           goback.
       window-loop.
           call "WindowShouldClose"
               returning ws-should-close end-call.
           call ls-prog using by value ls-user end-call.
       end program raylib-init.
      ******************************************************************
      *Draw text onscreen
       identification division.
       program-id. raylib-draw-text.
       data division.
       working-storage section.
       01  ws-text picture is x(81).
       01  ws-count picture is 9(4).
       linkage section.
       01  ls-text picture x(80).
       01  ls-x usage is binary-short.
       01  ls-y usage is binary-short.
       01  ls-size usage is binary-short.
       copy "rcol.cpy" replacing ==:pref:== by ==ls-colour==
                                 ==:level:== by ==01==.
       procedure division using
           by reference ls-text
           by value ls-x
           by value ls-y
           by value ls-size
           by value ls-colour
           returning omitted.
      *
           string ls-text delimited by space into ws-text end-string.
           initialize ws-count.
           inspect ws-text tallying ws-count
               for characters before space.
           add 1 to ws-count giving ws-count end-add.
      *
           call "COB_RayLib_DrawText" using
               by reference ws-text
               by value ls-x
               by value ls-y
               by value ls-size
               by value ls-colour-r
               by value ls-colour-g
               by value ls-colour-b
               by value ls-colour-a end-call.
           goback.
       end program raylib-draw-text.
      ******************************************************************
      *Draw lines onscreen
       identification division.
       program-id. raylib-draw-line.
       data division.
       linkage section.
       01  ls-sx usage is binary-short.
       01  ls-sy usage is binary-short.
       01  ls-ex usage is binary-short.
       01  ls-ey usage is binary-short.
       copy "rcol.cpy" replacing ==:pref:== by ==ls-colour==
                                 ==:level:== by ==01==.
       procedure division using
           by value ls-sx
           by value ls-sy
           by value ls-ex
           by value ls-ey
           by value ls-colour
           returning omitted.
      *
           call "COB_RayLib_DrawLine" using
               by value ls-sx
               by value ls-sy
               by value ls-ex
               by value ls-ey
               by value ls-colour-r
               by value ls-colour-g
               by value ls-colour-b
               by value ls-colour-a end-call.
           goback.
       end program raylib-draw-line.
      ******************************************************************
      *Load a texture given a name
       identification division.
       program-id. raylib-load-texture.
       data division.
       working-storage section.
       01  ws-text picture is x(81).
       01  ws-count picture is 9(4).
       linkage section.
       01  ls-text picture is x(80).
       copy "rtex.cpy" replacing ==:pref:== by ==ls-tex==
                                 ==:level:== by ==01==.
       procedure division using by reference ls-text
           by reference ls-tex
           returning omitted.
      *
           string ls-text delimited by space into ws-text end-string.
           initialize ws-count.
           inspect ws-text tallying ws-count
               for characters before space.
           add 1 to ws-count giving ws-count end-add.
      *
           call "COB_RayLib_LoadTexture" using
               by reference ws-text
               by reference ls-tex end-call.
           goback.
       end program raylib-load-texture.
      ******************************************************************
      *Draw a texture rectangle
       identification division.
       program-id. raylib-draw-texture-rec.
       data division.
       working-storage section.
       linkage section.
       copy "rtex.cpy" replacing ==:pref:== by ==ls-tex==
                                 ==:level:== by ==01==.
       copy "rrec.cpy" replacing ==:pref:== by ==ls-rec==
                                 ==:level:== by ==01==.
       copy "rve2.cpy" replacing ==:pref:== by ==ls-pos==
                                 ==:level:== by ==01==.
       copy "rcol.cpy" replacing ==:pref:== by ==ls-colour==
                                 ==:level:== by ==01==.
       procedure division using by reference ls-tex
           by reference ls-rec
           by reference ls-pos
           by reference ls-colour
           returning omitted.
      *
           call "COB_RayLib_DrawTextureRec" using
               by reference ls-tex
               by value ls-rec-x
               by value ls-rec-y
               by value ls-rec-width
               by value ls-rec-height
               by value ls-pos-x
               by value ls-pos-y
               by value ls-colour-r
               by value ls-colour-g
               by value ls-colour-b
               by value ls-colour-a end-call.
           goback.
       end program raylib-draw-texture-rec.
      ******************************************************************
      *Check if key is being pressed
       identification division.
       program-id. raylib-iskeydown.
       data division.
       working-storage section.
       01  ws-status :tp-int: synchronized.
       linkage section.
       01  ls-key :tp-int: synchronized.
       procedure division using
           by value ls-key.
      *
           call "IsKeyDown" using by value ls-key
               returning ws-status end-call.
           set return-code to ws-status.
           goback.
       end program raylib-iskeydown.
      ******************************************************************
      *Draw lines onscreen
       identification division.
       program-id. raylib-clear-background.
       data division.
       linkage section.
       copy "rcol.cpy" replacing ==:pref:== by ==ls-colour==
                                 ==:level:== by ==01==.
       procedure division using
           by value ls-colour
           returning omitted.
      *
           call "COB_RayLib_ClearBackground" using
               by value ls-colour-r
               by value ls-colour-g
               by value ls-colour-b
               by value ls-colour-a end-call.
           goback.
       end program raylib-clear-background.
      ******************************************************************
      *Begin/End drawing
       identification division.
       program-id. raylib-draw.
       data division.
       working-storage section.
       linkage section.
       01  ls-user usage is pointer.
       01  ls-prog usage is program-pointer.
       procedure division using by value ls-user
           by value ls-prog
           returning omitted.
      *
           call "BeginDrawing" end-call.
           call ls-prog using by value ls-user end-call.
           call "EndDrawing" end-call.
           goback.
       end program raylib-draw.
      ******************************************************************
      *Begin/End 2D drawing
       identification division.
       program-id. raylib-mode-2d.
       data division.
       working-storage section.
       linkage section.
       01  ls-user usage is pointer.
       01  ls-prog usage program-pointer.
       copy "rc2d.cpy" replacing ==:pref:== by ==ls-cam==
                                 ==:level:== by ==01==.
       procedure division using by value ls-user
           by reference ls-cam
           by value ls-prog
           returning omitted.
      *
           call "COB_RayLib_BeginMode2D" using
               by value ls-cam-offset-x
               by value ls-cam-offset-y
               by value ls-cam-target-x
               by value ls-cam-target-y
               by value ls-cam-rotation
               by value ls-cam-zoom end-call.
           call ls-prog using by value ls-user end-call.
           call "EndMode2D" end-call.
           goback.
       end program raylib-mode-2d.
