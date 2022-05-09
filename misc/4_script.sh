#!/bin/bash

myArray=("Project created")
arr2=("en_US_Alice"
"sv_SE_Alva"
"fr_CA_Amelie"
"de_DE_Anna"
"en_GB_Daniel"
"nl_BE_Ellen"
"en-scotland_Fiona"
"pt_PT_Joana"
"en_AU_Karen"
"ja_JP_Kyoko"
"it_IT_Luca"
"ru_RU_Milena"
"en_IE_Moira"
"en_US_Samantha"
"fi_FI_Satu"
"fr_FR_Thomas"
"en_US_Victoria")

for ((i = 0; i < ${#myArray[@]}; i++))
do
  accent="en_US"
  echo "${myArray[$i]}"
  s2=$(echo "${myArray[$i]}" | gsed "s/[^[:alnum:]]/_/g")

  for ((i2 = 0; i2 < ${#arr2[@]}; i2++))
  do
    person=$(echo "${arr2[$i2]}" | cut -d '_' -f 3)
    echo say -v "$person" "${myArray[$i]}" -o "./public/audios/${arr2[$i2]}_$s2.aiff"
    say -v "$person" "${myArray[$i]}" -o "/tmp/audios/${arr2[$i2]}_$s2.aiff"
    echo file $s2
    ffmpeg -i "/tmp/audios/${arr2[$i2]}_$s2.aiff" -f mp3 -acodec libmp3lame -ab 192000 -ar 44100 "/tmp/audios/${arr2[$i2]}_$s2.mp3"
  done
done

rm /tmp/audios/*.aiff

