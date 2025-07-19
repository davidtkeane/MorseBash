#!/bin/bash

# MorseBash Cross-Platform (macOS/Linux) Version - FAST Edition
# Author: David Keane 🧠
# Modified for ~3 codes per second playback

# ==== COLORS ====
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; PURPLE='\033[0;35m'; WHITE='\033[0;37m'
REDB='\033[1;31m'; GREENB='\033[1;32m'; YELLOWB='\033[1;33m'
BLUEB='\033[1;34m'; CYANB='\033[1;36m'; PURPLEB='\033[1;35m'; WHITEB='\033[1;37m'
RESET='\033[0m'

# ==== AUDIO FILES ====
DOT='Audio/dot.wav'
DASH='Audio/dash.wav'

# ==== SOUND PLAYER DETECTION ====
if command -v afplay &>/dev/null; then
    SOUND_PLAYER="afplay"
elif command -v aplay &>/dev/null; then
    SOUND_PLAYER="aplay"
elif command -v play &>/dev/null; then
    SOUND_PLAYER="play"
else
    echo -e "${YELLOW}⚠️ No supported sound player found (afplay/aplay/play). Sound will be skipped.${RESET}"
    SOUND_PLAYER=""
fi

# ==== TIMING with Speed Control ====
# Default speed multiplier (1.0 = normal, 0.5 = twice as fast, 2.0 = twice as slow)
SPEED_MULTIPLIER=${MORSE_SPEED:-3.0}

# Base timing values optimized for ~3 codes per second
# These are MUCH faster than before!
BASE_LETTERSPACE=0.03    # 30ms between letters (was 0.3)
BASE_WORDSPACE=0.15      # 150ms between words (was 0.98)

# Calculate actual timing based on speed multiplier
if command -v bc &>/dev/null; then
    LETTERSPACE=$(echo "$BASE_LETTERSPACE * $SPEED_MULTIPLIER" | bc -l)
    WORDSPACE=$(echo "$BASE_WORDSPACE * $SPEED_MULTIPLIER" | bc -l)
else
    # Fallback if bc is not installed
    LETTERSPACE=$BASE_LETTERSPACE
    WORDSPACE=$BASE_WORDSPACE
    echo -e "${YELLOW}Note: Install 'bc' for speed control support${RESET}"
fi

EXIT_MSG="May the Morse be with you!"
E_NOARGS=75

#--------) Display ASCII banner (--------#

# Function to print banner with a random color
ascii_banner() {
   # Print the banner in the chosen color
    echo -e "${GREENB}"
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
    echo -e "${RESET}"
    
    # Display current speed setting
    echo -e "${CYAN}Speed: ${YELLOWB}${SPEED_MULTIPLIER}x${RESET} | Letter gap: ${LETTERSPACE}s | Word gap: ${WORDSPACE}s"
    echo -e "${PURPLE}Target: ~3 codes/second at 1.0x speed${RESET}"
    echo ""
}


# ==== ASCII RANGER BANNER ====
ascii_banner_ranger() {
    echo -e "${GREENB}"
    cat << "EOF"
  ██████╗  █████╗ ███╗   ██╗ ██████╗ ███████╗██████╗ 
  ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔════╝██╔══██╗
  ██████╔╝███████║██╔██╗ ██║██║  ███╗█████╗  ██████╔╝
  ██╔══██╗██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██╔══██╗
  ██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗██║  ██║
  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
EOF
    echo -e "${RESET}"
    
    # Display current speed setting
    echo -e "${CYAN}Speed: ${YELLOWB}${SPEED_MULTIPLIER}x${RESET} | Letter gap: ${LETTERSPACE}s | Word gap: ${WORDSPACE}s"
    echo -e "${PURPLE}Target: ~3 codes/second at 1.0x speed${RESET}"
    echo ""
}

# ==== MORSE CODE DICTIONARY ====
declare -A morse
morse[a]="dot; dash";                   morse[b]="dash; dot; dot; dot"
morse[c]="dash; dot; dash; dot";        morse[d]="dash; dot; dot"
morse[e]="dot";                         morse[f]="dot; dot; dash; dot"
morse[g]="dash; dash; dot";             morse[h]="dot; dot; dot; dot"
morse[i]="dot; dot";                    morse[j]="dot; dash; dash; dash"
morse[k]="dash; dot; dash";             morse[l]="dot; dash; dot; dot"
morse[m]="dash; dash";                  morse[n]="dash; dot"
morse[o]="dash; dash; dash";            morse[p]="dot; dash; dash; dot"
morse[q]="dash; dash; dot; dash";       morse[r]="dot; dash; dot"
morse[s]="dot; dot; dot";               morse[t]="dash"
morse[u]="dot; dot; dash";              morse[v]="dot; dot; dot; dash"
morse[w]="dot; dash; dash";             morse[x]="dash; dot; dot; dash"
morse[y]="dash; dot; dash; dash";       morse[z]="dash; dash; dot; dot"
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

# ==== SOUND PLAYERS ====
play_sound() {
    local file="$1"
    [[ -z "$SOUND_PLAYER" ]] && return
    # Play sound in background to avoid blocking
    "$SOUND_PLAYER" "$file" > /dev/null 2>&1 &
}

dot()  { play_sound "$DOT"; }
dash() { play_sound "$DASH"; }

# ==== LETTER AND WORD PROCESSING ====
play_letter() {
    local seq="${morse[$1]}"
    [[ -z "$seq" ]] && echo -n "?" && return
    IFS=';' read -r -a parts <<< "$seq"
    for part in "${parts[@]}"; do
        [[ "$part" == "dot" ]] && echo -n "." && dot
        [[ "$part" == "dash" ]] && echo -n "-" && dash
    done
    echo -n " "
    sleep $LETTERSPACE
}

extract_letters() {
    local text="$1"
    for (( i=0; i<${#text}; i++ )); do
        char="${text:$i:1}"
        play_letter "$char"
    done
}

# ==== Help Function ====
show_help() {
    echo -e "${BLUEB}Usage:${RESET}"
    echo "  ./morseBash.sh [options] 'Your text here'"
    echo ""
    echo -e "${GREENB}Options:${RESET}"
    echo "  -s, --speed <multiplier>  Set speed multiplier (default: 1.0)"
    echo "                           0.5 = twice as fast, 2.0 = twice as slow"
    echo "  -h, --help               Show this help message"
    echo ""
    echo -e "${YELLOWB}Speed Examples:${RESET}"
    echo "  ./morseBash.sh 'normal speed'       # ~3 codes/second"
    echo "  ./morseBash.sh -s 0.5 'very fast'   # ~6 codes/second"
    echo "  ./morseBash.sh -s 2.0 'learning'    # ~1.5 codes/second"
    echo "  ./morseBash.sh -s 3.0 'slow'        # ~1 code/second"
    echo ""
    echo -e "${CYANB}Environment Variable:${RESET}"
    echo "  MORSE_SPEED=0.5 ./morseBash.sh 'hello'"
    echo ""
    echo -e "${PURPLEB}Note:${RESET} Default speed is optimized for ~3 codes per second"
}

# ==== DEFAULT EXAMPLE IF NO INPUT ====
no_args() {
    echo -e "${BLUEB}Usage:${RESET}"
    echo "./morseBash.sh 'Your text here'"
    echo "Example: ./morseBash.sh 'hello world'"
    echo ""
    echo -e "${YELLOWB}Demo at current speed:${RESET}"
    for w in "hello" "world"; do
        extract_letters "$w"
        echo -n "   "
        sleep $WORDSPACE
    done
}

# ==== Parse Arguments ====
parse_args() {
    local text=""
    while [[ $# -gt 0 ]]; do
        case $1 in
            -s|--speed)
                if [[ -n "$2" ]] && [[ "$2" =~ ^[0-9]+\.?[0-9]*$ ]]; then
                    SPEED_MULTIPLIER="$2"
                    # Recalculate timing
                    if command -v bc &>/dev/null; then
                        LETTERSPACE=$(echo "$BASE_LETTERSPACE * $SPEED_MULTIPLIER" | bc -l)
                        WORDSPACE=$(echo "$BASE_WORDSPACE * $SPEED_MULTIPLIER" | bc -l)
                    else
                        echo -e "${YELLOW}Warning: bc not found, speed control disabled${RESET}"
                    fi
                    shift 2
                else
                    echo -e "${REDB}Error: Speed must be a positive number${RESET}"
                    exit 1
                fi
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                text="$text $1"
                shift
                ;;
        esac
    done
    echo "$text"
}

# ==== MAIN ====
clear
ascii_banner_ranger

# Parse command line arguments
input_text=$(parse_args "$@" | xargs | tr '[:upper:]' '[:lower:]')

if [[ -z "$input_text" ]]; then
    no_args
    echo -e "\n${CYANB}$EXIT_MSG${RESET}"
    exit $E_NOARGS
fi

echo -e "\n${WHITEB}Transmitting: $input_text${RESET}\n"

# Optional: Show timing info
echo -e "${BLUE}Timing: ${LETTERSPACE}s/letter, ${WORDSPACE}s/word${RESET}\n"

for word in $input_text; do
    extract_letters "$word"
    echo -n "   "
    sleep $WORDSPACE
done

# Final message
clear

echo -e "\n${GREENB}Transmission complete!${RESET}"
echo
echo -e "\n\n${CYANB}$EXIT_MSG${RESET}\n"
ascii_banner
echo
exit 0