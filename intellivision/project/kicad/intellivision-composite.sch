EESchema Schematic File Version 4
LIBS:power
LIBS:device
LIBS:Connector_Generic
LIBS:Transistor_BJT
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Intellivision Composite Video Amplifier"
Date "2026-10-17"
Rev "Reconstructed"
Comp "Video Composites"
Comment1 "Reconstructed from intellivision/doc/schematic.jpg"
$EndDescr
$Comp
L power:+5V #PWR01
U 1 1 1
P 3600 1800
F 0 "#PWR01" H 3600 1650 50  0001 C CNN
F 1 "+5V" H 3615 1973 50  0000 C CNN
	1    3600 1800
	1    0    0    -1
$EndComp
$Comp
L power:GND #PWR02
U 1 1 2
P 3600 4200
F 0 "#PWR02" H 3600 3950 50  0001 C CNN
F 1 "GND" H 3605 4027 50  0000 C CNN
	1    3600 4200
	1    0    0    -1
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J1
U 1 1 3
P 2000 3000
F 0 "J1" H 1918 2775 50  0000 C CNN
F 1 "VID IN" H 1918 2866 50  0000 C CNN
	1    2000 3000
	-1   0    0    1
$EndComp
$Comp
L Device:C_Polarized C1
U 1 1 4
P 2800 3000
F 0 "C1" V 2545 3000 50  0000 C CNN
F 1 "100u" V 2636 3000 50  0000 C CNN
	1    2800 3000
	0    1    1    0
$EndComp
$Comp
L Device:R R1
U 1 1 5
P 3600 2400
F 0 "R1" H 3670 2446 50  0000 L CNN
F 1 "51k" H 3670 2355 50  0000 L CNN
	1    3600 2400
	1    0    0    -1
$EndComp
$Comp
L Device:R R2
U 1 1 6
P 3600 3600
F 0 "R2" H 3670 3646 50  0000 L CNN
F 1 "33k" H 3670 3555 50  0000 L CNN
	1    3600 3600
	1    0    0    -1
$EndComp
$Comp
L Transistor_BJT:2N3904 Q1
U 1 1 7
P 4600 3000
F 0 "Q1" H 4791 3046 50  0000 L CNN
F 1 "2N3904" H 4791 2955 50  0000 L CNN
	1    4600 3000
	1    0    0    -1
$EndComp
$Comp
L Device:R R3
U 1 1 8
P 4700 2400
F 0 "R3" H 4770 2446 50  0000 L CNN
F 1 "660R" H 4770 2355 50  0000 L CNN
	1    4700 2400
	1    0    0    -1
$EndComp
$Comp
L Device:R R4
U 1 1 9
P 4700 3600
F 0 "R4" H 4770 3646 50  0000 L CNN
F 1 "330R" H 4770 3555 50  0000 L CNN
	1    4700 3600
	1    0    0    -1
$EndComp
$Comp
L Device:C_Polarized C2
U 1 1 10
P 5400 2800
F 0 "C2" V 5145 2800 50  0000 C CNN
F 1 "100u" V 5236 2800 50  0000 C CNN
	1    5400 2800
	0    1    1    0
$EndComp
$Comp
L Device:R R5
U 1 1 11
P 6000 2400
F 0 "R5" H 6070 2446 50  0000 L CNN
F 1 "15k" H 6070 2355 50  0000 L CNN
	1    6000 2400
	1    0    0    -1
$EndComp
$Comp
L Device:R R6
U 1 1 12
P 6000 3600
F 0 "R6" H 6070 3646 50  0000 L CNN
F 1 "22k" H 6070 3555 50  0000 L CNN
	1    6000 3600
	1    0    0    -1
$EndComp
$Comp
L Transistor_BJT:2N3904 Q2
U 1 1 13
P 6200 3000
F 0 "Q2" H 6391 3046 50  0000 L CNN
F 1 "2N3904" H 6391 2955 50  0000 L CNN
	1    6200 3000
	1    0    0    -1
$EndComp
$Comp
L Device:R R7
U 1 1 14
P 6300 2400
F 0 "R7" H 6370 2446 50  0000 L CNN
F 1 "75R" H 6370 2355 50  0000 L CNN
	1    6300 2400
	1    0    0    -1
$EndComp
$Comp
L Device:R R8
U 1 1 15
P 6300 3600
F 0 "R8" H 6370 3646 50  0000 L CNN
F 1 "22R" H 6370 3555 50  0000 L CNN
	1    6300 3600
	1    0    0    -1
$EndComp
$Comp
L Device:C_Polarized C3
U 1 1 16
P 7000 2800
F 0 "C3" V 6745 2800 50  0000 C CNN
F 1 "100u" V 6836 2800 50  0000 C CNN
	1    7000 2800
	0    1    1    0
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J2
U 1 1 17
P 7800 2800
F 0 "J2" H 7880 2842 50  0000 L CNN
F 1 "VID OUT" H 7880 2751 50  0000 L CNN
	1    7800 2800
	1    0    0    -1
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J3
U 1 1 18
P 2800 5200
F 0 "J3" H 2718 4975 50  0000 C CNN
F 1 "AUD IN" H 2718 5066 50  0000 C CNN
	1    2800 5200
	-1   0    0    1
$EndComp
$Comp
L Device:C_Polarized C4
U 1 1 19
P 4000 5200
F 0 "C4" V 3745 5200 50  0000 C CNN
F 1 "100u" V 3836 5200 50  0000 C CNN
	1    4000 5200
	0    1    1    0
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J4
U 1 1 20
P 5200 5200
F 0 "J4" H 5280 5242 50  0000 L CNN
F 1 "AUD OUT" H 5280 5151 50  0000 L CNN
	1    5200 5200
	1    0    0    -1
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J5
U 1 1 21
P 2800 1800
F 0 "J5" H 2718 1575 50  0000 C CNN
F 1 "+5V IN" H 2718 1666 50  0000 C CNN
	1    2800 1800
	-1   0    0    1
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J6
U 1 1 22
P 2800 4000
F 0 "J6" H 2718 3775 50  0000 C CNN
F 1 "GND IN" H 2718 3866 50  0000 C CNN
	1    2800 4000
	-1   0    0    1
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J7
U 1 1 23
P 7800 4000
F 0 "J7" H 7880 4042 50  0000 L CNN
F 1 "GND OUT" H 7880 3951 50  0000 L CNN
	1    7800 4000
	1    0    0    -1
$EndComp
Wire Wire Line
	3000 1800 7200 1800
Wire Wire Line
	3600 1800 3600 2250
Wire Wire Line
	4700 1800 4700 2250
Wire Wire Line
	6000 1800 6000 2250
Wire Wire Line
	6300 1800 6300 2250
Wire Wire Line
	2200 3000 2650 3000
Wire Wire Line
	2950 3000 4400 3000
Wire Wire Line
	3600 2550 3600 3450
Connection ~ 3600 3000
Wire Wire Line
	4700 2550 4700 2800
Wire Wire Line
	4700 2800 5250 2800
Wire Wire Line
	4700 3200 4700 3450
Wire Wire Line
	5550 2800 6000 2800
Wire Wire Line
	6000 2550 6000 3450
Wire Wire Line
	6000 2800 6000 3000
Connection ~ 6000 2800
Wire Wire Line
	6300 2550 6300 2800
Wire Wire Line
	6300 2800 6850 2800
Wire Wire Line
	6300 3200 6300 3450
Wire Wire Line
	7150 2800 7600 2800
Wire Wire Line
	3000 4000 7600 4000
Wire Wire Line
	3600 3750 3600 4200
Wire Wire Line
	4700 3750 4700 4000
Wire Wire Line
	6000 3750 6000 4000
Wire Wire Line
	6300 3750 6300 4000
Wire Wire Line
	3000 5200 3850 5200
Wire Wire Line
	4150 5200 5000 5200
Connection ~ 3600 1800
Connection ~ 4700 1800
Connection ~ 6000 1800
Connection ~ 6300 1800
Connection ~ 4700 4000
Connection ~ 6000 4000
Connection ~ 6300 4000
$EndSCHEMATC
