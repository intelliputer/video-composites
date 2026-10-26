# Intellivision composite-video amplifier BOM

This BOM covers the reconstructed circuit shown in
[`doc/schematic.jpg`](doc/schematic.jpg) and the corresponding PCB. RCA jacks,
wire, and mounting hardware are installation-specific and are not included.

| Reference | Value / part | Qty. |
| --- | --- | ---: |
| C1, C2, C3, C4 | Panasonic `ECEA1AKS101`, 100 µF, 10 V KS-A radial electrolytic | 4 |
| R1 | 51 kΩ resistor | 1 |
| R2 | 33 kΩ resistor | 1 |
| R3 | 660 Ω resistor | 1 |
| R4 | 330 Ω resistor | 1 |
| R5 | 15 kΩ resistor | 1 |
| R6 | 22 kΩ resistor | 1 |
| R7 | 75 Ω resistor | 1 |
| R8 | 22 Ω resistor | 1 |
| Q1, Q2 | 2N3904 NPN transistor, TO-92 | 2 |

Observe the polarity of C1–C4. For installation, also provide yellow video
and mono-audio RCA jacks, 75 Ω coax or short shielded cable for raw video, and
hookup wire for audio, regulated +5 V, and ground.

## Capacitor footprint verification

The exact capacitor selected above is specified in
[`../datasheets/ABA0000C1059.pdf`](../datasheets/ABA0000C1059.pdf). Its
published dimensions are a 6.3 mm diameter × 5.0 mm high can, 2.50 mm lead
spacing, and 0.45 mm lead diameter. All four board positions use
`CP_Radial_D6.3mm_P2.50mm`: its 6.3 mm body outline and 2.50 mm pad pitch
match the part, and its 0.80 mm plated drill gives 0.35 mm diametral lead
clearance. The footprint's nominal 7 mm height is conservative relative to
the selected 5 mm part and does not reduce board clearance.

Do not substitute the 16 V, 25 V, 35 V, or 50 V 100 µF KS variants without a
PCB change: the cited datasheet specifies those as 8.0 mm diameter parts.
