FUNCTIONS_FILE_LOC="${(%):-%N}" # hacky workaround to replace bash's export

# grep wrapper (even though it's called findhere) that does grep --include "..." --exclude "..." -Rnwi . -e "[pattern]" in an easy function of findhere [pattern] [exclude] [include]
function findhere()
{
	# echo "findhere pattern exclude include e.g. findhere \"hello world\" \"*.o\" \"*.{c,h}\""
	if [ -z "$2" ]; then
		exclude=""
	else
		exclude="--exclude=\"$2\ "
	fi

	if [ -z "$3" ]; then
		include=""
	else
		include="--include=$3"
	fi

	echo "searching for \"$1\" with include of \"$2\" and exclude of \"$3\""

	grep $include $exclude -Rnwi . -e $1 || echo "nothing found"
}

function screen()
{
	# see if there are any arguments
	if [ -z "$@" ]; then
		# no arguments, quiet screen
		command screen -q
	else
		# treat as a normal screen
		command screen $@
	fi

	# if screen exited badly display notification (e.g. it does on ubuntu subsystem for windows)
	if ((?)); then
		echo "Screen Failed"
	fi
}

function psgrep() {
	ps auxww | grep -i $@
}

# some sites that support curl
if (( $+commands[curl] )); then
	function weather() {
		curl -s https://wttr.in/"$1"
	}
	function cheat() {
		curl -s https://cheat.sh/"$1"
	}
	function publicip() {
		curl -s https://ifconfig.co/"$1"
	}
	function qrcode() {
		curl -s -F"-=$1" https://qrenco.de
	}
	function dictionary() {
		curl -s dict://dict.org/d:"$1"
	}
	function crypto() {
		curl -s https://rate.sx/"$1"
	}
	function shorturl() {
		curl -F"shorten=$1" https://0x0.st
	}
	function news() {
		curl getnews.tech/"$1"
	}
fi
