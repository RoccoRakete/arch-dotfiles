amixer get Master | grep -oP '\[\d+%\]' | head -n 1 | tr -d '[]'
