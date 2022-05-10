#!/bin/bash -x

rm /tmp/audios/*

arr1=(
  "Project created"
  "Comment added"
  "Repcee signed"
  "Repcee signed by seller"
  "Offer viewed by seller"
  "Listing added"
  "Listing removed"
  "Marketing mail sent"
  "File added"
  "Addendum sent"
  "Offer sent"
  "Property analysis started"
  "Repcee received feedback"
  "Addendum received feedback")

arr2=(
  "it_IT_Alice"
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

for ((i = 0; i < ${#arr1[@]}; i++))
do
  accent="en_US"
  echo "${arr1[$i]}"
  s2=$(echo "${arr1[$i]}" | gsed "s/[^[:alnum:]]/_/g")

  for ((i2 = 0; i2 < ${#arr2[@]}; i2++))
  do
    person=$(echo "${arr2[$i2]}" | cut -d '_' -f 3)
    say -v "$person" "${arr1[$i]}" -o "/tmp/audios/${arr2[$i2]}_$s2.aiff"
    ffmpeg -i "/tmp/audios/${arr2[$i2]}_$s2.aiff" -f mp3 -acodec libmp3lame -ab 192000 -ar 44100 "/tmp/audios/${arr2[$i2]}_$s2.mp3" 2>/dev/null
  done
done

rm /tmp/audios/*.aiff
cp /tmp/audios/*.mp3 ~/silica-bucket/neutral/neutral/audios/
