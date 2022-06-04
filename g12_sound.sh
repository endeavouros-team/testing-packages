#!/bin/sh


mixer() {
  parm=${4:-on}
  amixer -c "$1" sset "$2" "$3" $parm >/dev/null 2>&1
  amixer -c "$1" sset "$2" $parm >/dev/null 2>&1
}


if [ -f $HOME/.config/sound.conf ]; then

  alsactl restore -f $HOME/.config/sound.conf

else

# get card num
#card=`echo $1 | sed 's/[^0-9]*//g'`
card1=`aplay -l | grep "device 0" | awk '{print $3}'`
#echo $card

for card in $card1 
do

echo $card

# set common mixer params
  mixer $card Master 0db
  mixer $card Front 100%
  mixer $card PCM 0db
  mixer $card Synth 100%

# mute CD, since using digital audio instead
  mixer $card CD 0% mute

# Only unmute Line and Aux if they are possibly used.
#  mixer $card Line 100%
#  mixer $card Aux 100%

# mute mic
  mixer $card Mic 0% mute

# ESS 1969 chipset has 2 PCM channels
  mixer $card PCM,1 100%

# Trident/YMFPCI/emu10k1
  mixer $card Wave 100%
  mixer $card Music 100%
  mixer $card AC97 100%
  mixer $card Surround 90%
  mixer $card 'Surround Digital' 90%
  mixer $card 'Wave Surround' 90%
  mixer $card 'Duplicate Front' 90%
  mixer $card 'Sigmatel 4-Speaker Stereo' 90%

# CS4237B chipset:
  mixer $card 'Master Digital' 100%

# DRC
  mixer $card 'Dynamic Range Compression' 90%

# Envy24 chips with analog outs
  mixer $card DAC 100%
  mixer $card DAC,0 100%
  mixer $card DAC,1 100%

# some notebooks use headphone instead of master
  mixer $card Headphone 100%
  mixer $card Speaker 100%
  mixer $card 'Internal Speaker' 0% mute
  mixer $card Playback 100%
  mixer $card Headphone 100%
  mixer $card Speaker 100%
  mixer $card Center 100%
  mixer $card LFE 100%
  mixer $card Center/LFE 100%

# Intel P4P800-MX  (Ubuntu bug #5813)
  mixer $card 'Master Playback Switch' on

# set digital output mixer params
  mixer $card 'IEC958' 100% on
  mixer $card 'IEC958 Output' 100%
  mixer $card 'IEC958 Coaxial' 100%
  mixer $card 'IEC958 LiveDrive' 100%
  mixer $card 'IEC958 Optical Raw' 100%
  mixer $card 'SPDIF Out' 100%
  mixer $card 'SPDIF Front' 100%
  mixer $card 'SPDIF Rear' 100%
  mixer $card 'SPDIF Center/LFE' 100%
  mixer $card 'Master Digital' 100%

  mixer $card 'Analog Front' 100%
  mixer $card 'Analog Rear' 100%
  mixer $card 'Analog Center/LFE' 100%

# ASRock ION 330 (and perhaps others) has 2 IEC958 channels
  mixer $card IEC958,0 on
  mixer $card IEC958,1 on

# some ION2 has much more IEC958 channels ...
  mixer $card IEC958,2 on
  mixer $card IEC958,3 on

# ASRock ION 330 has Master Front set to 0
  mixer $card 'Master Front' 100%

# Shuttle XS35GT needs this too
  mixer $card 'Master',0 100% on

# and this for various Fusion devices like Zotac ZBOX
  mixer $card 'Front',0 100% on

# NVidia CK804 sound devices
  mixer $card 'IEC958 Playback AC97-SPSA' 100%

# Allwinner H3 Analog
  mixer $card 'Line Out' 0db on

# Allwinner A20 Analog
  mixer $card 'Power Amplifier' 0db
  mixer $card 'Power Amplifier DAC' on
  mixer $card 'Power Amplifier Mute' on

# Allwinner A64 Analog
  mixer $card Headphone 0db on
  mixer $card 'AIF1 Slot 0 Digital DAC' on

# Amlogic G12 HDMI to PCM0 - OLD CONF
  mixer $card 'FRDDR_A SINK 1 SEL' 'OUT 1'
  mixer $card 'FRDDR_A SRC 1 EN' on
  mixer $card 'TDMOUT_B SRC SEL' 'IN 0'
  mixer $card 'TOHDMITX I2S SRC' 'I2S B'
  mixer $card 'TOHDMITX' on

# Amlogic G12 HDMI to PCM0 - NEW CONF
#   mixer $card 'FRDDR_A SINK 1 SEL' 'OUT 0'
#   mixer $card 'FRDDR_A SRC 1 EN' on
#   mixer $card 'TDMOUT_A SRC SEL' 'IN 0'
#   mixer $card 'TOHDMITX' on
#   mixer $card 'TOHDMITX I2S SRC' 'I2S A'

# Amlogic G12 S/PDIF to PCM1
  mixer $card 'FRDDR_B SINK 1 SEL' 'OUT 3'
  mixer $card 'FRDDR_B SRC 1 EN' on
  mixer $card 'SPDIFOUT SRC SEL' 'IN 1'
  mixer $card 'SPDIFOUT Playback' on

# Amlogic GX HDMI and S/PDIF
  mixer $card 'AIU HDMI CTRL SRC' 'I2S'
  mixer $card 'AIU SPDIF SRC SEL' 'SPDIF'

# RockPI 4B Analog
  mixer $card 'Right Headphone Mixer Right DAC' on
  mixer $card 'Left Headphone Mixer Left DAC' on

# NanoPC T4 Analog
  mixer $card 'HPO L' on
  mixer $card 'HPO R' on
  mixer $card 'HPOVOL L' on
  mixer $card 'HPOVOL R' on
  mixer $card 'HPO MIX HPVOL' on
  mixer $card 'OUT MIXL DAC L1' on
  mixer $card 'OUT MIXR DAC R1' on
  mixer $card 'Stereo DAC MIXL DAC L1' on
  mixer $card 'Stereo DAC MIXR DAC R1' on

done

fi

exit 0
