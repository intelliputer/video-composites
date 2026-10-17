# Universal amplifier schematic design — prototype 0.1

This is the electrical starting point for the universal PCB. It combines the
adjustable gain of the Atari design with the separately biased, AC-coupled
stages of the Intellivision design. It is deliberately a **prototype**, not a
fabrication release: verify waveform amplitude, DC operating points, and sync
on each target family before committing a board layout.

## Device choice

`Q1` and `Q2` are the stocked **Diotec 2N2222A in TO-92 (10D3)**. This avoids
the Atari board's 2N3906 PNP output device and keeps the active devices
uniform.

The supplied [`2n2222a.pdf`](2n2222a.pdf) defines the package pins as
**1 = emitter, 2 = base, 3 = collector (E–B–C)**. The eventual KiCad
footprint must use that exact numbering; it must not reuse a 2N3904 footprint
without checking it. This device is comfortably suitable for the prototype:
its 40 V `VCEO`, 600 mA DC collector-current rating, 625 mW dissipation rating,
and 250 MHz minimum gain-bandwidth specification substantially exceed this
5 V video-amplifier application's expected voltage, current, and bandwidth.

## Proposed circuit

```text
                           +5 V
                            |
                         R3 680R
                            |
      R1 10k                +---- C2 4.7uF ----+---- base Q2 (2N2222A)
+5 V --/\/\/--+-- base Q1  collector Q1        |       |
              |      |                          R5 3.3k |
video in      R2     Q1                         |       R6 1.2k
  |         3.3k     |                          +5 V    |
 C1 1uF        |    R4 150R                             GND
  |             \     |
 RV1 10k         GND  GND                         +5 V
  | (rheostat)                                      |
 R7 1k                                           R8 75R
  |                                                 |
  +-------------------- base Q1              collector Q2
                                                     |
                                           C3 220uF (+ here)
                                                     |
                                               video out -> 75-ohm display

Q2 emitter -> R9 33R -> GND

audio in -> C4 10uF -> audio out

+5 V -> C5 100nF ceramic || C6 10uF electrolytic -> GND
```

The signal diagram is functional rather than a KiCad drawing. The canonical
netlist below removes any ambiguity.

## Canonical netlist and starting values

| Reference | Starting value | Connections / role |
| --- | --- | --- |
| `C1` | 1 uF film or low-leakage capacitor | `VIDEO_IN` to `VIN_AC`; blocks console-side DC. |
| `RV1` | 10 kΩ linear, wired as rheostat | `VIN_AC` to `R7`; variable input attenuation. Tie wiper to the used outer terminal for fail-safe continuity. |
| `R7` | 1 kΩ | `RV1` to `Q1` base; base stopper and input-current limiter. |
| `R1` | 10 kΩ | +5 V to `Q1` base; upper leg of first bias divider. |
| `R2` | 3.3 kΩ | `Q1` base to ground; lower leg of first bias divider. |
| `Q1` | Diotec 2N2222A, TO-92 (10D3), E–B–C | First common-emitter gain stage. |
| `R3` | 680 Ω | +5 V to `Q1` collector; Q1 collector load. |
| `R4` | 150 Ω | `Q1` emitter to ground; current setting/local feedback. |
| `C2` | 4.7 uF electrolytic | `Q1` collector (positive) to `Q2` base-bias node; isolates stage DC biases. |
| `R5` | 3.3 kΩ | +5 V to `Q2` base; upper leg of second bias divider. |
| `R6` | 1.2 kΩ | `Q2` base to ground; lower leg of second bias divider. |
| `Q2` | Diotec 2N2222A, TO-92 (10D3), E–B–C | Second common-emitter gain and output-current stage. |
| `R8` | 75 Ω | +5 V to `Q2` collector; collector load/source impedance. |
| `R9` | 33 Ω | `Q2` emitter to ground; output-stage current stabilization. |
| `C3` | 220 uF electrolytic | `Q2` collector (positive) to `VIDEO_OUT`; blocks output DC and keeps low-frequency tilt small into 75 Ω. |
| `C4` | 10 uF electrolytic | `AUDIO_IN` to `AUDIO_OUT`; audio DC-blocking capacitor. |
| `C5` | 100 nF ceramic | +5 V to ground, adjacent to Q1/Q2; high-frequency supply decoupling. |
| `C6` | 10 uF electrolytic | +5 V to ground, adjacent to Q1/Q2; lower-frequency supply decoupling. |

## Expected operating points

These are approximate DC targets at +5 V and are a commissioning aid, not a
substitute for oscilloscope measurement.

| Node | Target | Reason |
| --- | ---: | --- |
| Q1 base | about 1.24 V | `R1`/`R2` divider nominal value. |
| Q1 emitter | about 0.55 V | Base voltage minus approximately 0.65–0.7 V. |
| Q1 collector | about 2.5 V | Leaves voltage swing in both directions. |
| Q2 base | about 1.3 V | `R5`/`R6` divider nominal value, reduced somewhat by base current. |
| Q2 emitter | about 0.6 V | Sets a moderate class-A output current through `R9`. |
| Q2 collector | about 3.5–4.0 V | Provides useful negative-going output swing while maintaining collector headroom. |

The first stage has roughly several times voltage gain; the input rheostat
reduces that drive as necessary. The second stage is deliberately a
low-impedance, modest-gain driver. Together they create two inversions, so the
composite waveform emerges with its original polarity.

## Required bench validation before PCB layout

1. Build the circuit on a compact test board with short ground returns.
2. Confirm the DC targets above with no video input.
3. Feed each candidate console's actual pre-RF video through a short shielded
   lead; do not test using the RF output.
4. Terminate `VIDEO_OUT` in 75 Ω and observe the waveform with an oscilloscope
   or a known-good scaler/display.
5. Adjust `RV1` for approximately 1 Vpp composite at the terminated output,
   stable sync, normal black level, and no bright-scene clipping.
6. Repeat on Intellivision I, Intellivision II, and Sears 497.75022. Their
   physical connections differ, but the target electrical behaviour is the
   same.
7. Only after the test results are satisfactory, freeze values and create the
   KiCad schematic/PCB revision.
