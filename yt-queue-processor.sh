#!/bin/bash
input="$HOME/Testing/bash/yt-video-queue"
dir="$HOME/Videos/Organize/"

if [ "$1" = "music" ]; then
    input="$HOME/Testing/bash/yt-music-queue"
    dir="$HOME/Music/Organize/"
fi

while IFS= read -r line
do
    while read url subDir
    do 
        if [ -z "$subDir" ]; then
            dir="$vidDir"
        else
            dir="$dir$subDir"
            if [ ! -d "$dir" ]; then
                mkdir "$dir"
            fi
        fi

        # Download
        echo "Downloading $url to $dir"
        cd "$dir"
        /usr/local/bin/youtube-dl "$url";

        # REmove Line
        escapedUrl=$(echo "$line" | sed 's#/#\\/#g')
        echo "Deleting $escapedUrl"
        sed -i "/$escapedUrl/d" "$input"

    done <<< "$line"
done < "$input"
