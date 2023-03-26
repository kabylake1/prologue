       copy "cabi.cpy".
      *
       identification division.
       program-id. kgame.
       data division.
       working-storage section.
       copy "gstt.cpy" replacing ==:pref:== by ==ws-gs==
                                 ==:level:== by ==01==.
       01  ws-load-prog usage program-pointer.
       01  ws-loop-prog usage program-pointer.
       copy "rcol.cpy" replacing ==:pref:== by ==ws-colour==
                                 ==:level:== by ==01==.
       procedure division.
           initialize ws-gs.
           set ws-gs-screen-width to 1024.
           set ws-gs-screen-height to 720.
           set ws-gs-target-fps to 30.
      *
           set ws-load-prog to entry "kgame-load".
           set ws-loop-prog to entry "kgame-loop".
           call "raylib-init" using by reference ws-gs
               by value ws-load-prog
               by value ws-loop-prog end-call.
           goback.
       end program kgame.
      *
       identification division.
       program-id. kgame-load.
       environment division.
       input-output section.
       file-control.
           select fs-inputs assign to "map.txt"
           organization is line sequential.
       data division.
       file section.
       fd  fs-inputs.
       01  fs-input picture x(1024).
       working-storage section.
       01  i picture is 9(4) computational.
       01  ws-row picture is 9(8).
       01  ws-tile picture is 99.
       01  ws-offset picture is 9(8).
       copy "rtex.cpy" replacing ==:pref:== by ==ws-cat==
                                 ==:level:== by ==01==.
       copy "rtex.cpy" replacing ==:pref:== by ==ws-tileset==
                                 ==:level:== by ==01==.
       linkage section.
       copy "gstt.cpy" replacing ==:pref:== by ==ls-gs==
                                 ==:level:== by ==01==.
       procedure division using by reference ls-gs
           returning omitted.
      *
           set ls-gs-tilesize to 16.
      *
           set ls-gs-tileset to address of ws-tileset.
           call "raylib-load-texture" using by reference "tileset.png"
               by value ls-gs-tileset end-call.
      *
           set ls-gs-cat-walk-frames to 10.
           set ls-gs-cat-walk-left to 2.
           add ls-gs-cat-walk-frames to ls-gs-cat-walk-left
               giving ls-gs-cat-walk-right end-add.
           set ls-gs-cat to address of ws-cat.
           call "raylib-load-texture" using by reference "cat.png"
               by value ls-gs-cat end-call.
      *
           move 300 to ls-gs-map-width.
           move 180 to ls-gs-map-height.
           move 150 to ls-gs-player-pos-x.
           multiply ls-gs-player-pos-x by ls-gs-tilesize
               giving ls-gs-player-pos-x end-multiply.
           move 32 to ls-gs-player-pos-y.
           multiply ls-gs-player-pos-y by ls-gs-tilesize
               giving ls-gs-player-pos-y end-multiply.
      *
           open input sharing with all fs-inputs.
           perform forever
               read fs-inputs
                   not at end perform read-map-row
                   at end exit perform
               end-read
           end-perform.
           close fs-inputs.
           goback.
       read-map-row.
           perform varying i from 1 by 1
           until i is greater than function length(fs-input)
               evaluate fs-input(i:1)
                   when 'A' move 0 to ws-tile
                   when 'B' move 1 to ws-tile
                   when 'C' move 2 to ws-tile
                   when 'D' move 3 to ws-tile
                   when 'E' move 4 to ws-tile
                   when 'F' move 5 to ws-tile
                   when 'G' move 6 to ws-tile
                   when 'H' move 7 to ws-tile
                   when 'I' move 8 to ws-tile
                   when 'J' move 9 to ws-tile
                   when 'K' move 10 to ws-tile
                   when 'L' move 11 to ws-tile
                   when 'M' move 12 to ws-tile
                   when 'N' move 13 to ws-tile
                   when 'O' move 14 to ws-tile
                   when 'P' move 15 to ws-tile
                   when 'Q' move 16 to ws-tile
                   when 'R' move 17 to ws-tile
                   when 'S' move 18 to ws-tile
                   when 'T' move 19 to ws-tile
                   when 'U' move 20 to ws-tile
                   when 'V' move 21 to ws-tile
                   when 'W' move 22 to ws-tile
                   when 'X' move 23 to ws-tile
                   when 'Y' move 24 to ws-tile
                   when 'Z' move 25 to ws-tile
                   when other exit perform
               end-evaluate
      *
               move ws-row to ws-offset
               multiply ws-offset by ls-gs-map-width giving ws-offset
               end-multiply
               add i to ws-offset giving ws-offset end-add
      *
               move ws-tile to ls-gs-map-tiles(ws-offset)
           end-perform.
           add 1 to ws-row giving ws-row end-add.
       end program kgame-load.
      *
       identification division.
       program-id. kgame-loop.
       data division.
       working-storage section.
       01  ws-loop-prog usage program-pointer.
       copy "rcol.cpy" replacing ==:pref:== by ==ws-colour==
                                 ==:level:== by ==01==.
       copy "rkey.cpy" replacing ==:pref:== by ==ws-key==
                                 ==:level:== by ==01==.
       01  ws-has-moved picture is 9.
       01  ws-status :tp-int:.
       linkage section.
       copy "gstt.cpy" replacing ==:pref:== by ==ls-gs==
                                 ==:level:== by ==01==.
       procedure division using by reference ls-gs.
      *
           initialize ws-has-moved.
      *
           set ws-loop-prog to entry "kgame-draw-loop".
           call "raylib-draw" using by reference ls-gs
               by value ws-loop-prog end-call.
      *
           call "raylib-iskeydown" using by value ws-key-up
               returning ws-status end-call.
           if ws-status is not equal to zero then
               perform key-up
           end-if.
           call "raylib-iskeydown" using by value ws-key-down
               returning ws-status end-call.
           if ws-status is not equal to zero then
               perform key-down
           end-if.
           call "raylib-iskeydown" using by value ws-key-left
               returning ws-status end-call.
           if ws-status is not equal to zero then
               perform key-left
           end-if.
           call "raylib-iskeydown" using by value ws-key-right
               returning ws-status end-call.
           if ws-status is not equal to zero then
               perform key-right
           end-if.
      *Put correct animation state for cat
           if ws-has-moved is equal to zero then
               if ls-gs-is-facing-left is equal to zero then
                   set ls-gs-cat-anim-frame to 1
               else
                   set ls-gs-cat-anim-frame to 0
               end-if
           else
               if ls-gs-is-facing-left is equal to zero then
                   call "kgame-cat-animation-step" using
                       by reference ls-gs
                       by reference ls-gs-cat-walk-right
                       by reference ls-gs-cat-walk-frames end-call
               else
                   call "kgame-cat-animation-step" using
                       by reference ls-gs
                       by reference ls-gs-cat-walk-left
                       by reference ls-gs-cat-walk-frames end-call
               end-if
           end-if.
           goback.
       key-up.
           subtract 2.75 from ls-gs-player-pos-y
               giving ls-gs-player-pos-y end-subtract.
           move 1 to ws-has-moved.
       key-down.
           add 2.75 to ls-gs-player-pos-y giving ls-gs-player-pos-y
               end-add.
           move 1 to ws-has-moved.
       key-left.
           subtract 2.75 from ls-gs-player-pos-x
               giving ls-gs-player-pos-x end-subtract.
           move 1 to ls-gs-is-facing-left, ws-has-moved.
       key-right.
           add 2.75 to ls-gs-player-pos-x giving ls-gs-player-pos-x
               end-add.
           move 0 to ls-gs-is-facing-left.
           move 1 to ws-has-moved.
       end program kgame-loop.
      *
       identification division.
       program-id. kgame-draw-loop.
       data division.
       working-storage section.
       01  ws-loop-prog usage program-pointer.
       copy "rcol.cpy" replacing ==:pref:== by ==ws-bg-colour==
                                 ==:level:== by ==01==.
       copy "rcol.cpy" replacing ==:pref:== by ==ws-black-colour==
                                 ==:level:== by ==01==.
       copy "rcol.cpy" replacing ==:pref:== by ==ws-white-colour==
                                 ==:level:== by ==01==.
       copy "rc2d.cpy" replacing ==:pref:== by ==ws-cam==
                                 ==:level:== by ==01==.
       linkage section.
       copy "gstt.cpy" replacing ==:pref:== by ==ls-gs==
                                 ==:level:== by ==01==.
       procedure division using by reference ls-gs.
      *
           set ws-bg-colour-r,
               ws-bg-colour-g,
               ws-bg-colour-b,
               ws-bg-colour-a to 128.
           call "raylib-clear-background" using by content ws-bg-colour
           end-call.
      *
           set ws-loop-prog to entry "kgame-mode-2d-loop".
           initialize ws-cam.
           move 4.0 to ws-cam-zoom.
           move ls-gs-player-pos-x to ws-cam-target-x.
           move ls-gs-player-pos-y to ws-cam-target-y.
           divide ls-gs-screen-width by 2 giving ws-cam-offset-x
               end-divide.
           divide ls-gs-screen-height by 2 giving ws-cam-offset-y
               end-divide.
           call "raylib-mode-2d" using by reference ls-gs
               by reference ws-cam
               by value ws-loop-prog end-call.
      *
           set ws-black-colour-r,
               ws-black-colour-g,
               ws-black-colour-b to 0.
           set ws-black-colour-a to 255.
      *
           set ws-white-colour-r,
               ws-white-colour-g,
               ws-white-colour-b,
               ws-white-colour-a to 255.
      *
           call "raylib-draw-text" using by reference "Prologue"
               by value 64
               by value 200
               by value 64
               by content ws-black-colour end-call.
           call "raylib-draw-text" using by reference "Prologue"
               by value 56
               by value 190
               by value 64
               by content ws-white-colour end-call.
      *
           goback.
       end program kgame-draw-loop.
      *
       identification division.
       program-id. kgame-mode-2d-loop.
       data division.
       working-storage section.
       copy "rcol.cpy" replacing ==:pref:== by ==ws-colour==
                                 ==:level:== by ==01==.
       copy "rrec.cpy" replacing ==:pref:== by ==ws-tile-rec==
                                 ==:level:== by ==01==.
       copy "rve2.cpy" replacing ==:pref:== by ==ws-tile-pos==
                                 ==:level:== by ==01==.
       copy "rrec.cpy" replacing ==:pref:== by ==ws-player-rec==
                                 ==:level:== by ==01==.
       copy "rve2.cpy" replacing ==:pref:== by ==ws-player-pos==
                                 ==:level:== by ==01==.
       01  ws-mx picture 9(4) computational.
       01  ws-my picture 9(4) computational.
       01  ws-index picture 9(8).
       01  ws-tileindex picture 9(8).
       linkage section.
       copy "gstt.cpy" replacing ==:pref:== by ==ls-gs==
                                 ==:level:== by ==01==.
       procedure division using by reference ls-gs.
      *
           perform varying ws-mx from 0 by 1
           until ws-mx is greater than or equal to ls-gs-map-width
               perform varying ws-my from 0 by 1
               until ws-my is greater than or equal to ls-gs-map-height
                   perform draw-tile
               end-perform
           end-perform.
      *
           perform draw-player.
      *
           goback.
       draw-player.
           move ls-gs-player-pos-x to ws-player-pos-x.
           move ls-gs-player-pos-y to ws-player-pos-y.
      *
           initialize ws-player-rec.
           multiply ls-gs-cat-anim-frame by ls-gs-tilesize
               giving ws-player-rec-y end-multiply.
           add ls-gs-tilesize to 0 giving ws-player-rec-width end-add.
           set ws-player-rec-height to ws-player-rec-width.
      *
           set ws-colour-r,
               ws-colour-g,
               ws-colour-b,
               ws-colour-a to 255.
           call "raylib-draw-texture-rec" using by value ls-gs-cat
               by content ws-player-rec
               by content ws-player-pos
               by content ws-colour end-call.
       draw-tile.
           multiply ws-mx by ls-gs-tilesize giving ws-tile-pos-x
               end-multiply.
           multiply ws-my by ls-gs-tilesize giving ws-tile-pos-y
               end-multiply.
      *
           initialize ws-index.
           multiply ws-my by ls-gs-map-width giving ws-index
               end-multiply.
           add ws-mx to ws-index giving ws-index end-add.
      *
           initialize ws-tileindex.
           move ls-gs-map-tiles(ws-index) to ws-tileindex.
      *
           initialize ws-tile-rec.
           multiply ws-tileindex by ls-gs-tilesize giving ws-tile-rec-y
               end-multiply.
           add ls-gs-tilesize to 0 giving ws-tile-rec-width end-add.
           set ws-tile-rec-height to ws-tile-rec-width.
      *
           set ws-colour-r,
               ws-colour-g,
               ws-colour-b,
               ws-colour-a to 255.
           call "raylib-draw-texture-rec" using by value ls-gs-tileset
               by content ws-tile-rec
               by content ws-tile-pos
               by content ws-colour end-call.
       end program kgame-mode-2d-loop.
      *
       identification division.
       program-id. kgame-cat-animation-step.
       data division.
       working-storage section.
       01  ws-end-frame picture is 99.
       linkage section.
       copy "gstt.cpy" replacing ==:pref:== by ==ls-gs==
                                 ==:level:== by ==01==.
       01  ls-offset picture is 99.
       01  ls-num-frames picture is 99.
       procedure division using by reference ls-gs
           by reference ls-offset
           by reference ls-num-frames.
      *
           initialize ws-end-frame.
           add ls-num-frames to ls-offset giving ws-end-frame end-add.
      *
           if ls-gs-cat-anim-frame is >= ls-offset then
               if ls-gs-cat-anim-frame is < ws-end-frame then
                   perform next-frame
               else
                   set ls-gs-cat-anim-frame to ls-offset
               end-if
           else
               set ls-gs-cat-anim-frame to ls-offset
           end-if.
           goback.
       next-frame.
           add 1 to ls-gs-cat-anim-frame
               giving ls-gs-cat-anim-frame end-add.
           if ls-gs-cat-anim-frame >= ws-end-frame then
               set ls-gs-cat-anim-frame to ls-offset
           end-if.
       end program kgame-cat-animation-step.
