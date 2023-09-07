url="https://gitlab.banksinarmas.com/akshayNambiar/simobi-backend-test"
# Split the URL using '/' as the delimiter and store it in an array
IFS='/' read -ra parts <<< "$url"
# Get the last element (last word)
last_word="${parts[${#parts[@]}-1]}"
echo "Last word: $last_word"
