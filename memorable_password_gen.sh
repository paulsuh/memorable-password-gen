#!/bin/sh

# Copyright ©2007, 2025 Paul Suh
# 
# A short shell script that will print out any desired number of random
# passwords of the form <word1><digit><punctuation><word2>. 
#
# The second argument will ensure that the password is at least
# that many characters long. Default minimum length is 15. 
#
# usage: ./password_gen.sh [num passwords] [min length]
#
# This example will print out 5 random passwords, each of which is at
# least 12 characters long. 
#
# ./password_gen 5 12
#
# The words used come from the Moby list downloaded from here:
#   https://ai1.ai.uga.edu/ftplib/natural-language/moby/moby.tar.Z
#
# The passwords are based on open compound nouns (two-word compound nouns), 
# filtered so that each element contains at least four letters and 
# does not contain any capital letters (removes proper nouns). 
#
# The punctuation is from the list -/:;()$&@".,?!' which are the 
# punctuation characters that can be typed on an iOS keyboard with only
# shifting to numerics. 

random_line_from_file() {
    local source_filename
    local filename_lines_count
    
    source_filename="$1"
    filename_lines_count=$(wc -l < "${source_filename}")
    line_num=$(jot -r 1 1 ${filename_lines_count})
    RANDOM_LINE_RESULT=$(head -$line_num < ${source_filename} | tail -1)
}


random_punctuation() {
    local phone_friendly_punctuation
	
    # These can be typed on an iOS keyboard from the digits keyboard
    phone_friendly_punctuation=( \- \/ \: \; \( \) \$ \& \@ \" \. \, \? \! \' )
    PUNCTUATION_RESULT=${phone_friendly_punctuation[ $(($RANDOM % ${#phone_friendly_punctuation[*]} )) ]}

}

generate_random_password() {
    local word1
    local word2
    local punctuation
    local digit
    local local_result
    local minimum_length
    
    declare -i minimum_length="$1"
    
    local_result=""
    while [ ${#local_result} -lt ${minimum_length} ]; do
        random_line_from_file base_compound_nouns.txt
        word1=$(echo "${RANDOM_LINE_RESULT}" | egrep --only-matching '^\w+')
        word2=$(echo "${RANDOM_LINE_RESULT}" | egrep --only-matching '\w+$')
    
        random_punctuation    
        punctuation="${PUNCTUATION_RESULT}"
        
        digit=$(jot -r 1 0 9)
        
        local_result="${word1}${digit}${punctuation}${word2}"
    
    done
    RANDOM_PASSWORD_RESULT="${local_result}"
}

usage() {
    echo "Usage: $0 [number of passwords to generate (default 10)] [minimum password length (default 15)]"
}

is_int() {
    case ${1#[-+]} in
        '' | *[!0-9]*)
            return 1
            ;;
        *)
            return 0
            ;;
    esac
}


# Check the arguments for sanity
if [ "$#" -gt 2 ]; then
    usage
    exit 0
fi
if [ $1 ] && ! is_int $1; then
    echo "arg 1"
    usage
    exit 0
fi
if [ $2 ] && ! is_int $2; then
    echo "arg 2"
    usage
    exit 0
fi

# default number of passwords to 10
if [ $1 ]; then
    declare -i NUM_PASSWORDS=$1
else
    declare -i NUM_PASSWORDS=10
fi    
# default password minimum length to 15
if [ $2 ]; then
    declare -i MINIMUM_LENGTH=$2
else
    declare -i MINIMUM_LENGTH=15
fi

COUNT=0
while [ $COUNT -lt $NUM_PASSWORDS ] 
do 
	((COUNT++)) 

    generate_random_password $MINIMUM_LENGTH
    echo $RANDOM_PASSWORD_RESULT

done
