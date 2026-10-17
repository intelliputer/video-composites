# Universal baseband composite-video amplifier: comparison and recommendation

This note compares the Atari 2600 and Intellivision amplifier approaches in
this repository and proposes a common design direction for consoles that make
**baseband composite video available before their RF modulator**.

It is intended for NTSC Intellivision I, Intellivision II, and Sears Telegames
/ Super Video Arcade 497.75022, as well as an Atari 2600 after the correct
pre-RF video tap has been identified. It is not an RF-to-composite converter,
and it cannot make an RF-only or RGB-only signal compatible without an
appropriate preceding circuit.

## Behavioural comparison

| Behaviour | Atari board | Intellivision board |
| --- | --- | --- |
| Gain setup | Adjustable with `RV1`; the installer can set composite amplitude/brightness for the particular console and display. | Fixed by the resistor values; predictable once built, but not adjustable. |
| Active stages | NPN first stage followed by PNP second stage. | Two NPN common-emitter stages. |
| Video-stage coupling | Primarily DC-coupled, so the operating point of one stage affects the next. | AC-coupled by `C1`, `C2`, and `C3`; each stage can use its own DC bias. |
| Output | Tunable amplitude and good drive flexibility, but needs careful trim adjustment. | Fixed amplitude and DC-blocked output, but less able to compensate for console/display variation. |
| Low-frequency behaviour | No large electrolytic coupling capacitors in the video path. | Three 100 uF video coupling capacitors; correct polarity and capacitor condition matter to black-level stability. |
| Installation risks | Excess gain can clip bright areas or disturb sync. | Incorrect capacitor polarity or a fixed level unsuited to the display can impair the picture. |

Both designs use two inverting common-emitter stages, restoring the input
video polarity at the final output. Both expect a short shielded lead and a
75-ohm terminated composite display input.

## Recommended common circuit direction

The best general-purpose circuit is a **two-stage, non-inverting discrete
amplifier with AC-coupled interfaces and adjustable gain**:

```text
raw composite in
  -> DC-blocking input capacitor
  -> high-impedance, adjustable bias/gain network
  -> NPN common-emitter gain stage
  -> DC-blocking interstage capacitor
  -> PNP (or NPN) common-emitter output stage
  -> DC-blocking output capacitor
  -> 75-ohm series output resistor
  -> composite jack / 75-ohm display termination
```

Add a 100 nF ceramic capacitor and a 10 uF electrolytic capacitor directly
between +5 V and ground at the board. Neither existing design shows dedicated
local supply decoupling; it is inexpensive insurance against supply noise and
oscillation.

### Why this hybrid is preferred

- It retains the Atari circuit's adjustable gain, which is valuable because
  source level, cable loss, and display/scaler input tolerance vary.
- It retains the Intellivision circuit's AC isolation. The source, first
  stage, second stage, and external display can each keep an appropriate DC
  operating point rather than depending on one another.
- Two common-emitter stages retain video polarity while providing voltage gain
  and sufficient output current.
- A 75-ohm series output resistor makes the board behave as a conventional
  composite source when feeding a properly terminated cable/display.
- Input coupling prevents an unknown console-side DC offset from shifting the
  amplifier bias. Output coupling ensures no amplifier DC reaches the RCA
  connector.

## Recommended implementation details

Use the Atari topology as the starting point because its trim control is the
most useful practical feature, but revise it as follows:

1. Add an input coupling capacitor ahead of the gain-control/bias node.
   Choose a low-leakage capacitor and calculate its value together with the
   input impedance so the lower cutoff is far below video content; do not
   copy the Intellivision's 100 uF value blindly.
2. AC-couple the stages so their DC biases can be set independently, as in the
   Intellivision design.
3. Add an output coupling capacitor if the final transistor collector carries
   DC, then place the 75-ohm series resistor at the RCA/output connector.
4. Include local +5 V decoupling: 100 nF ceramic in parallel with about
   10 uF electrolytic, physically close to the transistors.
5. Provide an accessible, single-turn or multiturn gain trimmer with a marked
   safe adjustment range. Set it on the target display for stable sync,
   correct black level, and no highlight clipping.
6. Use a high-impedance input and short shielded video wiring. Connect cable
   shield/RCA shell to the same low-impedance ground return as the board.

## Compatibility and limits

The **same universal board circuit** can serve NTSC Intellivision I,
Intellivision II, and Sears Telegames 497.75022 because their relevant signal
is the same raw composite video ahead of the RF modulator. The installation is
not universal: solder points, shielding, available space, power routing, and
RCA mounting vary by motherboard and chassis. See
[`../intellivision/doc/COMPATIBILITY.md`](../intellivision/doc/COMPATIBILITY.md).

No analogue board can guarantee correct results in every situation without
validation. Before committing a PCB revision, measure the actual raw-video
amplitude and DC offset for each target family, test with a 75-ohm terminated
display/scaler, and verify sync, colour, black level, and bright-scene
clipping. PAL consoles, non-standard board revisions, long unshielded leads,
and displays without 75-ohm termination require separate validation.

## Bottom line

For the listed NTSC systems, the recommended universal design is **the Atari
two-stage adjustable-gain approach improved with the Intellivision-style AC
coupling and explicit supply decoupling**. It offers the broadest margin for
source and display variation while preserving the correct composite waveform.

## Prototype schematic

[`SCHEMATIC-DESIGN.md`](SCHEMATIC-DESIGN.md) contains the first-pass
2N2222A-only schematic design, using the stocked Diotec TO-92 E–B–C part,
starting values, expected DC operating points, and the required
bench-validation plan. It precedes PCB layout intentionally.
