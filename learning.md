# Vim learnings 2022-12-11j
 1. ciw and diw are pretty cool. you don't have to hop back to the word boundary, you can just delete or change the word. You get yiw too, etc etc.
 2. `#` aend `*` over a word will highlight all occurrences of that word and move backward and forward
 3. t/T and f/F are for hop, basically, and t stops before, f stops on, the character.
 4. `C-r` is redo
 5. Don't forget `o` and `O`, which open a line abovebelow
 6. A gets you to the end of the line and into insert mode
 7. Remember to use your old friends `^` and `$` and their additional buddy `0`
 8. the `%` character in normal mode lets you hop to a bracket's pair
 9. `[m` and `]m` take you to top and bottom of method. 
 10. `g;` and `g,` jump to previous/next change (on change list) 
 11. The quickfix list is `:cl` and `:cc` `:cn` etc. Also there is the local list ll, which is like a buffer local quickfix list.
 12. `CTRL-o` and `CTRL-i` to walk the jump list (a list of where you've been in the buffer)
 13. `gi` takes you to your last insert; `gv` the last visual mode selection; `gn` the last search match; `gI` insert text at beginning of line 
 14. in Visual mode, `ip` and `ap` (also `Ip` and `Ap`) take yuou to the paragraph boundaries; you can also config function and class (it's textobj treesitter plugin)
 15. Ranges also matter. Rangers can be:
  - Line numbers
  - The current line, `.`
  - The last line of the current buffer, `$`
  - The entire file, `%`
  - The last selection, `*`
 16. Here are some cool registers:
   - The unnamed register "
   - The read-only registers `.`, `%`, `:`, las:e ~t insert, current filename, most recent command
   - Alternate buffer register `#`
   - Black hole register `_`
   - Last search pattern register `/`
   - you already know about `=`, `system()`, etc. and `+` and `*`
 16. `:&&` and `:~` repeat the last sbustitute and redo the substitute with the last search (whew) 
 17. `&` in normal mode repeats last sub without its range and flags. `g&` uses last search instead
 18. Marks. Don't forget marks. Special marks:
   `'<` `'>`
 19. `\`[` `]`  first/last character previousl yyanked content marks
 20. Double-backslash move to position before the latest jump
 21. Move the position to where closed file last time
 22. ``^` 
 23. Fuck. Digraphs with `CTRL+K` are a thing
