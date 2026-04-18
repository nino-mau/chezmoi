function htmlclip --description "Open clipboard HTML in browser"
    set file (mktemp --suffix=.html)

    if wl-paste --list-types | rg -q '^text/html$'
        wl-paste --type text/html > $file
    else
        wl-paste > $file
    end

    xdg-open $file
end
