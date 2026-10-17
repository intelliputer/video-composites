# Atari 2600 composite-video amplifier circuit analysis

This board takes the Atari's low-level video signal from ahead of the RF
modulator, amplifies it, and supplies a low-impedance composite-video output.
It is a two-stage, direct-coupled discrete amplifier: an NPN common-emitter
voltage-gain stage (`Q1`) followed by a PNP common-emitter output stage
(`Q2`). Each common-emitter stage inverts the signal, so the two inversions
restore the original video polarity at the output.

The board does not decode RF or create colour/subcarrier information. Its job
is to preserve the console-generated composite waveform while providing the
gain and drive needed by a 75-ohm video connection.

## Signal flow

`VID_IN` -> input/bias and gain control -> `Q1` -> `Q2` -> `VID_OUT`

Audio does not pass through the video amplifier: `AUD_IN` is simply routed to
`AUD_OUT`. The connector also carries the shared ground.

## Parts and their contributions

| Part | Contribution to the circuit |
| --- | --- |
| `Q1` (2N3904) | First, NPN common-emitter voltage-gain stage. It raises the raw video level and provides the drive needed for the second stage. |
| `R4` (150 ohm) | `Q1` collector load. It develops the first-stage output voltage from changes in `Q1` collector current and establishes that stage's operating point. |
| `R5` (68 ohm) | `Q1` emitter resistor. It limits emitter/collector current and supplies local negative feedback, making the bias and gain less sensitive to transistor variation. |
| `Q2` (2N3906) | Second, PNP common-emitter output stage. It adds gain/current drive and isolates the first stage from the cable/display load. |
| `R6` (18 ohm) | `Q2` emitter resistor. It sets and stabilizes the output-stage current; its small value allows `Q2` to deliver the required video swing. |
| `R7` (75 ohm) | `Q2` collector load and output source impedance. It limits output current and works with the intended 75-ohm termination at the receiving display. |
| `RV1` (5 kohm) | Adjustable shunt control at the input/bias node. It changes the drive into `Q1`, allowing the output video amplitude/brightness to be trimmed for the console and display chain. |
| `R2` (3.3 kohm) | Couples the positive supply into the `Q1` base-bias/input node. Together with `RV1` and the input network it establishes the DC operating point while allowing gain adjustment. |
| `R3` (1 kohm) | Couples the `Q1` collector signal to the `Q2` base and limits base current. It is the interstage drive resistor and helps set the second-stage bias. |
| `R1` (1 kohm) | Series resistor in the video-input branch. It isolates the raw Atari video source from the amplifier's bias/control network and limits transient/input current. |
| `C1` (47 pF) | Small high-frequency bypass across the input resistor/network. It shapes the highest-frequency response and can reduce ringing without acting as a low-frequency AC-coupling capacitor. |
| `R8` (10 kohm) | Series resistor in the direct audio path. It isolates the console audio source from cable/external-input loading and limits fault or transient current; it does not amplify audio. |
| `J1`, `J2` | Input and output headers: video, audio, supply, and ground connections. They are not active circuitry but make the board interface explicit. |

## Design implications

- The two active stages give more adjustable gain and output drive than the
  one-transistor Atari alternative, at the cost of additional components and a
  required `RV1` adjustment.
- The video path is DC-coupled through the transistor stages. The operating
  points set by the resistor network are therefore important; substitute
  values only with an understanding of their effect on gain, clipping, and
  sync level.
- `R7` is part of the output interface, not merely a bias part. Use short,
  shielded cable and connect the output only to a normal 75-ohm composite
  input. A different load changes amplitude and can degrade the picture.
- The schematic has no dedicated supply-decoupling capacitor. Keep the +5 V
  and ground leads short and low impedance; adding suitable local decoupling
  is a sensible revision if the physical installation shows supply noise.

## Adjustment

With the console connected to its intended display or scaler, adjust `RV1`
only enough to obtain stable sync, normal black level, and unclipped bright
areas. Excess gain can make the picture too bright, crush highlight detail, or
distort sync. Power the console down before moving wiring or changing parts.
