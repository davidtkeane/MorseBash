#!/bin/bash

# A Simple Bash Script that turns input (lowercase letters only) into dots & dashes

# Regular Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
WHITE='\033[0;37m'
RESET='\033[0m'

# Bold Colors
REDB='\033[1;31m'      # Red
GREENB='\033[1;32m'    # Green
YELLOWB='\033[1;33m'   # Yellow
BLUEB='\033[1;34m'     # Blue
CYANB='\033[1;36m'     # Cyan
PURPLEB='\033[1;35m'   # Purple
WHITEB='\033[1;37m'    # White

# Array of color names
allcolors=("RED" "GREEN" "YELLOW" "BLUE" "CYAN" "PURPLE" "WHITE")

# Function to print banner with a random color
ascii_banner() {

    # Pick a random color from the allcolors array
    random_color="${allcolors[$((RANDOM % ${#allcolors[@]}))]}"

    # Convert the color name to the actual escape code
    case $random_color in
        "RED") color_code=$RED ;;
        "GREEN") color_code=$GREEN ;;
        "YELLOW") color_code=$YELLOW ;;
        "BLUE") color_code=$BLUE ;;
        "CYAN") color_code=$CYAN ;;
        "PURPLE") color_code=$PURPLE ;;
        "WHITE") color_code=$WHITE ;;
    esac

#--------) Display ASCII banner (--------#

   # Print the banner in the chosen color
    echo -e "${color_code}"
    cat << "EOF"
                                                                   ''
                                          __               ..  ....;,.
   ____ ___  ____  _____________    _____/ /_            .c:: .:;,:l:do:.
  / __ `__ \/ __ \/ ___/ ___/ _ \  / ___/ __ \           ;lc,,,,,lol'kOxoxo'
 / / / / / / /_/ / /  (__  )  __/ (__  ) / / /        ''o:;,,;lo:ccllOkc:lOOd
/_/ /_/ /_/\____/_/  /____/\___(_)____/_/ /_/       .':;,;c;,;;;:lodkOOdodOOO:
                                                .;;,;;;:okOkdc;,okkkxkOOO00KXl
                                               .c,:lxdolOOOOOOOdOkddxO00KXOl'
                                             .',lkOO0OOOOOOOOOO0OOO0KKKk:.
                            ..........      ',. .xK00OOOOOOOOOOO0KKKx;.
                  ..............'''''''..'l;'     'oOK00000000KK0d,
               .....'........''''..':''',kNx         .:oxO0KKOl'
             ...................   .OK000Oo'
            ......................    ...
           ........................'.
           ......................''''.
   .;:'       ................''''''''
  'KXXX0o,       .........'''''',,''''
  cXXXXXXX0o.     .'''''''''',,,'''''.
  .KXXXXXXXXK;     .'''''''',;''''.
   :KXXXXXXXXK,     .....    ....
    'xXXXXXXXXO
      .ckKXXXXO
         .;dxd.
EOF
    echo -e "${RESET}"  # Reset color
}

# Check for aplay
if ! command -v aplay &> /dev/null; then
    echo -e "${YELLOW}aplay not found. Please install it with: apt install aplay"
    exit 1
fi

# Wav file should be in the same directory as script:
DOT='./dot.wav'
DASH='./dash.wav'

LETTERSPACE=0.3  # Seconds.
WORDSPACE=0.98  # Seconds.

EXIT_MSG="May the Morse be with you!"
E_NOARGS=75  # No command-line args?

declare -A morse
# ======================================= #
morse[a]="dot; dash"
morse[b]="dash; dot; dot; dot"
morse[c]="dash; dot; dash; dot"
morse[d]="dash; dot; dot"
morse[e]="dot"
morse[f]="dot; dot; dash; dot"
morse[g]="dash; dash; dot"
morse[h]="dot; dot; dot; dot"
morse[i]="dot; dot"
morse[j]="dot; dash; dash; dash"
morse[k]="dash; dot; dash"
morse[l]="dot; dash; dot; dot"
morse[m]="dash; dash"
morse[n]="dash; dot"
morse[o]="dash; dash; dash"
morse[p]="dot; dash; dash; dot"
morse[q]="dash; dash; dot; dash"
morse[r]="dot; dash; dot"
morse[s]="dot; dot; dot"
morse[t]="dash"
morse[u]="dot; dot; dash"
morse[v]="dot; dot; dot; dash"
morse[w]="dot; dash; dash"
morse[x]="dash; dot; dot; dash"
morse[y]="dash; dot; dash; dash"
morse[z]="dash; dash; dot; dot"
morse[0]="dash; dash; dash; dash; dash"
morse[1]="dot; dash; dash; dash; dash"
morse[2]="dot; dot; dash; dash; dash"
morse[3]="dot; dot; dot; dash; dash"
morse[4]="dot; dot; dot; dot; dash"
morse[5]="dot; dot; dot; dot; dot"
morse[6]="dash; dot; dot; dot; dot"
morse[7]="dash; dash; dot; dot; dot"
morse[8]="dash; dash; dash; dot; dot"
morse[9]="dash; dash; dash; dash; dot"
morse[?]="dot; dot; dash; dash; dot; dot"
morse[.]="dot; dash; dot; dash; dot; dash"
morse[,]="dash; dash; dot; dot; dash; dash"
morse[/]="dash; dot; dot; dash; dot"
morse[\@]="dot; dash; dash; dot; dash; dot"
# ======================================= #

# Play the letter sounds
play_letter () {
  local sound_sequence="${morse[$1]}"
  if [ -z "$sound_sequence" ]; then
    echo -n "?"  # Unknown character
    return
  fi
  IFS=';' read -r -a sounds <<< "$sound_sequence"
  for sound in "${sounds[@]}"; do
    [ "$sound" == "dot" ] && echo -n "." || echo -n "-"
    $sound
  done
  echo -n " "  # Space between letters visually
  sleep $LETTERSPACE
}

# Extract letters and play the sounds
extract_letters () {
  local pos=0
  local len=1
  strlen=${#1}

  while [ $pos -lt $strlen ]; do
    letter=${1:pos:len}
    play_letter $letter
    echo -n "*"  # Mark letter just played.
    ((pos++))
  done
}

# Play the sound files
dot() { aplay "$DOT" 2>/dev/null; }
dash() { aplay "$DASH" 2>/dev/null; }

# Handle no arguments
no_args () {
  declare -a usage
  usage=( $0 word1 word2 ... )

  echo -e "${BLUEB}Usage${RESET}:"; echo
  echo ${usage[*]}
  for index in 0 1 2 3; do
    extract_letters ${usage[index]}
    sleep $(echo "$WORDSPACE" | bc -l)  # Convert to seconds for `sleep`
    echo -n " "  # Print space between words.
  done
}

# Main execution
clear
ascii_banner
echo; echo;

# Convert input to lowercase
input_text=$(echo "$*" | tr '[:upper:]' '[:lower:]')

if [ -z "$input_text" ]; then
  no_args
  echo; echo; echo "$EXIT_MSG"; echo
  exit $E_NOARGS
fi

echo; echo -e "${WHITEB}$input_text${RESET}"  # Print text that will be played.

# Process the input text letter by letter
until [ -z "$1" ]; do
  extract_letters $1
  shift  # On to next word.
  sleep $(echo "$WORDSPACE" | bc -l)  # Convert to seconds for `sleep`
  echo -n " "  # Print space between words.
done

echo; echo; echo -e "${CYANB}$EXIT_MSG${RESET}"; echo

exit 0
