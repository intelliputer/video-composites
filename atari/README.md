# Atari 2600 composite-video amplifier

This is the selected quality-focused composite-video modification for an Atari
2600. It taps the console's pre-RF video and audio signals, buffers the video,
and provides composite video plus mono audio for RCA connectors. It is not an
RF-to-composite demodulator.

The board implements a two-stage discrete transistor amplifier based on a
design by `simon.plata`. Compared with the single-transistor alternative that
was evaluated for this repository, this circuit provides adjustable video gain
and is the preferred option where the best composite-video result is more
important than the lowest component count.

> Composite output is still composite output: it is a substantial improvement
> over RF, but it cannot equal an RGB or S-Video modification.

## Project files

| What | Location |
| --- | --- |
| KiCad schematic | [`project/kicad/atari-composite.kicad_sch`](project/kicad/atari-composite.kicad_sch) |
| KiCad PCB layout | [`project/kicad/atari-composite.kicad_pcb`](project/kicad/atari-composite.kicad_pcb) |
| KiCad project | [`project/kicad/atari-composite.kicad_pro`](project/kicad/atari-composite.kicad_pro) |
| Installation/result photographs | [`gallery/`](gallery/) |
| Rendered PCB snapshot | [`doc/pcb-snapshot.png`](doc/pcb-snapshot.png) |
| Bill of materials | [`doc/BOM.md`](doc/BOM.md) |
| Circuit analysis | [`doc/CIRCUIT-ANALYSIS.md`](doc/CIRCUIT-ANALYSIS.md) |

## Circuit summary

The video path uses a 2N3904 first stage and a 2N3906 output stage. `RV1`
adjusts video gain/brightness, allowing the output level to be set for the
particular console and display chain. Audio is routed separately to the audio
output.

Component count for the amplifier is 12:

- 2 transistors;
- 8 fixed resistors;
- 1 trimmer potentiometer; and
- 1 capacitor.

## Bill of materials

| Reference | Value / part | Qty. |
| --- | --- | ---: |
| C1 | 47 pF ceramic capacitor | 1 |
| R1, R3 | 1 kΩ resistor | 2 |
| R2 | 3.3 kΩ resistor | 1 |
| R4 | 150 Ω resistor | 1 |
| R5 | 68 Ω resistor | 1 |
| R6 | 18 Ω resistor | 1 |
| R7 | 75 Ω resistor | 1 |
| R8 | 10 kΩ resistor | 1 |
| RV1 | 5 kΩ 3296W trimmer potentiometer | 1 |
| Q1 | 2N3904, TO-92 | 1 |
| Q2 | 2N3906, TO-92 | 1 |

Use 1% resistors and a short, shielded video-input lead where practical.

## Installation notes

This board requires four console-side connections: regulated +5 V, ground,
raw video before the RF modulator, and raw audio. Connect the buffered video
and audio outputs to the centre contacts of their RCA jacks; connect the RCA
shells to ground.

Atari 2600 motherboard revisions, NTSC/PAL variants, and case styles have
different RF sections and convenient connection points. Inspect the specific
board and verify each signal with its schematic before soldering. Do not copy
connection points from a different revision without checking them. Disconnect
power before opening the console, and adjust `RV1` only after confirming a
stable picture on the intended display or scaler.
