# Intellivision composite-video amplifier circuit analysis

This board takes the Intellivision's baseband video from ahead of the RF
modulator, AC-couples it into two NPN common-emitter amplifier stages, and
AC-couples the result to a composite-video output. The two common-emitter
stages each invert the signal, so their pair restores the original video
polarity. A separate capacitor passes mono audio to its output.

The board does not demodulate RF or generate colour information. It buffers
and raises the console-produced composite waveform so it can drive a normal
75-ohm composite-video input.

> This analysis reflects the reference drawing in
> [`schematic.jpg`](schematic.jpg) and the reconstructed legacy schematic.
> The modern KiCad schematic is still a placeholder, so confirm the board
> against the reference drawing before changing the design or manufacturing it.

## Signal flow

`VID_IN` -> `C1` -> biased `Q1` gain stage -> `C2` -> biased `Q2` gain/output
stage -> `C3` -> `VID_OUT`

`AUD_IN` -> `C4` -> `AUD_OUT`

## Parts and their contributions

| Part | Contribution to the circuit |
| --- | --- |
| `C1` (100 uF) | Input coupling capacitor. It blocks the source's DC level while passing the changing video waveform to the first-stage bias point. Its positive terminal faces the `Q1` base bias node, as shown in the reference drawing. |
| `R1` (51 kohm) | Upper leg of the `Q1` base-bias divider, from +5 V to the input/base node. |
| `R2` (33 kohm) | Lower leg of the `Q1` base-bias divider, from that node to ground. With `R1`, it establishes the DC base voltage that keeps `Q1` in its linear region. |
| `Q1` (2N3904) | First NPN common-emitter voltage-gain stage. Changes at its base modulate collector current, producing an amplified, inverted video signal at its collector. |
| `R3` (660 ohm) | `Q1` collector load. It converts collector-current changes to a voltage signal and helps establish the collector's DC operating point. |
| `R4` (330 ohm) | `Q1` emitter resistor. It sets current and introduces emitter degeneration (local negative feedback), reducing bias sensitivity and distortion. |
| `C2` (100 uF) | Interstage coupling capacitor. It passes the first-stage video signal to `Q2` but lets both transistors retain independently chosen DC bias points. Its positive terminal faces the higher-DC `Q1` collector side. |
| `R5` (15 kohm) | Upper leg of the `Q2` base-bias divider, from +5 V to the interstage/base node. |
| `R6` (22 kohm) | Lower leg of the `Q2` base-bias divider, from the `Q2` base node to ground. With `R5`, it sets the second stage's DC bias. |
| `Q2` (2N3904) | Second NPN common-emitter gain/output stage. It provides further voltage/current drive and buffers the first stage from the output coupling network and cable. |
| `R7` (75 ohm) | `Q2` collector load. It allows a relatively low output impedance and participates in setting the available composite-video amplitude when the output is terminated by the display. |
| `R8` (22 ohm) | `Q2` emitter resistor. It limits/stabilizes second-stage current while keeping emitter degeneration small enough for useful gain and output swing. |
| `C3` (100 uF) | Output coupling capacitor. It removes the `Q2` collector DC level from the external composite connector while passing video. Its positive terminal faces the transistor side. |
| `C4` (100 uF) | Audio coupling capacitor. It passes the changing mono-audio signal and blocks console-side DC from the RCA audio output. Its polarity must follow the reference drawing/actual signal DC levels. |
| `J5`, `J6`, `J7` | +5 V and ground connections. They provide power and the common return needed for both the amplifier and external video/audio connections. |
| `J1`, `J2`, `J3`, `J4` | Video and audio input/output connections. Their physical placement makes the console-side and RCA-side wiring explicit. |

## Design implications

- The `R1`/`R2` and `R5`/`R6` dividers set the two transistor operating
  points; the coupling capacitors mean changing one stage's DC bias does not
  directly disturb the other.
- `R4` and `R8` trade some gain for predictable current and lower distortion.
  Their values should not be changed casually.
- `R7` is intentionally close to video-system impedance. It is part of the
  load-driving/output-level design, so use a short 75-ohm coax or shielded
  lead and a display/scaler with a 75-ohm composite input.
- C1-C4 are polarized electrolytics. Reversing one risks leakage, poor video
  response, or capacitor damage. Observe the marked positive ends in the
  reference drawing.
- The schematic shows no dedicated supply bypass capacitor. Short +5 V and
  ground leads are important; a future revision could add local decoupling if
  supply noise is visible in the image.

## Scope

The amplifier circuit is common to the NTSC Intellivision I, Intellivision II,
and Sears Telegames 497.75022 installations supported by this repository.
Only the physical console connection points, shielding, cable routing, and
RCA mounting differ. See [`COMPATIBILITY.md`](COMPATIBILITY.md) before
installing it.
