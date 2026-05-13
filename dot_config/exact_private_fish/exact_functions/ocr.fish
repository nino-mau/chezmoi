function ocr -d 'OCR selected screen region'
    set -l tmp (mktemp /tmp/ocr_XXXXXX.png)
    screencapture -i $tmp
    or begin
        rm -f $tmp
        return 1
    end
    set -l text (vision-ocr $tmp)
    rm -f $tmp
    echo $text | pbcopy
    echo "Copied: $text"
end
