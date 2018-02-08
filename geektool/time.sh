#!/bin/bash
# time.sh
#   


colorEnabled=1

# systemUptime=`uptime`

tputColors(){
	if [[ -z "$TERM" ]]; then
		export TERM="dumb"
	fi

	tput_nrml=`tput sgr0`
	tput_dim=`tput dim`
	tput_bold=`tput bold`
	tput_undl=`tput smul`
	tput_revE=`tput rev`
	tput_blnk=`tput blink`
	
	tput_black=`tput setaf 0`
	tput_red=`tput setaf 1`
	tput_green=`tput setaf 2`
	tput_yellow=`tput setaf 3`
	tput_blue=`tput setaf 4`
	tput_magenta=`tput setaf 5`
	tput_cyan=`tput setaf 6`
	tput_white=`tput setaf 7`
}


loadStyles(){
	themeDefault=$tput_white
	
	themeUptime=$tput_cyan
	themeUsers=$tput_white
	themeLoad=$tput_cyan
	themeLoadNumbers=$tput_cyan$tput_test
	
	themeDay=$tput_red
	themeDate=$themeDefault
	themeJulian=$tput_yellow
	
	themeLocalTime=$tput_green
	themeLocalTimeZone=$tput_cyan
	
	themeUtcTime=$tput_green
	themeUtcTimeZone=$tput_cyan
	
	themeUnixTime=$tput_white
}

main () {

	if (( colorEnabled )); then
		tputColors
		loadStyles
	fi

	echo -n ${themeDefault}
	echo -n ${themeUptime}
	echo `uptime` | perl -pe "s/, /${themeDefault}\n /g" | perl -pe "s/: /:${themeDefault}\n  ${themeLoadNumbers}/g"
	echo -n ${themeDefault}

	date    "+${themeDay}%A${themeDefault}%n${themeDate}%Y-%m-%d${themeDefault} ${themeJulian}%j${themeDefault}"
	date    "+ L ${themeLocalTime}%H:%M:%S${themeDefault} ${themeLocalTimeZone}%z${themeDefault}"
	date -u "+ U ${themeUtcTime}%H:%M:%S${themeDefault} ${themeUtcTimeZone}%z${themeDefault}"
	date    "+ ${themeUnixTime}%s${themeDefault}"
}


main