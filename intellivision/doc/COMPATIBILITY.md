# Intellivision composite-mod compatibility

## Scope

This board uses the same electrical method on the NTSC Intellivision I,
Intellivision II, and Sears Telegames / Super Video Arcade model 497.75022.
The Sears unit is an Intellivision I-family rebrand for purposes of this
modification.

## What is common to every model

The modification does not demodulate the existing RF output.  Instead, it
takes the console's raw video and audio signals before the RF modulator:

1. Tap raw composite video, raw mono audio, regulated +5 V, and ground.
2. Feed raw video into this board's buffer / impedance-matching circuit.
3. Route the board's video and audio outputs to suitable external connectors.

The video buffer converts the console's high-impedance raw composite signal
to a normal 75-ohm composite-video output.  Therefore, the board design and
component values do not need to change among these console models.

## What differs by console

| Console | Circuit | Installation considerations |
| --- | --- | --- |
| Intellivision I | Same board and signal method | The logic-board RF shield normally must be removed/desoldered for access. A convenient regulated +5 V / ground source is the power supply board. |
| Intellivision II | Same board and signal method | No RF-shield removal is normally required. Convenient +5 V and ground points are on different motherboard locations. Case space and RCA mounting differ. |
| Sears Telegames 497.75022 | Same board and signal method | Install as an Intellivision I-family unit. Shielding, case layout, cable routing, and convenient power points may differ from both Mattel cases. |

## Installation requirements

Do not copy an annotated solder-point photograph from another motherboard
without verification. Before soldering, identify on the individual console:

- regulated +5 V and ground;
- raw video entering the RF modulator;
- raw audio entering the RF modulator.

The RF-modulator leads are a useful functional reference for the audio and
video taps, but physical lead order, convenient pads, and accessible traces
can vary by motherboard revision. Keep the video-input run short and shielded
where practical. Disconnect mains power before opening the console; original
and Sears units contain an internal line-voltage power supply.

## Audio-output connector options

The Intellivision's original audio is **mono**. This board preserves that one
line-level audio signal; it does not generate stereo. A conventional
three-RCA composite A/V installation may duplicate the mono `AUD_OUT` signal
to both the white/left and red/right audio jacks for compatibility with
standard A/V leads.

For compact installations, a 3.5 mm TRS stereo female jack may replace the
audio RCA connector. To feed powered stereo speakers or another line-level
stereo input, wire the output as follows:

- `AUD_OUT` through a 1 kΩ resistor to the jack **tip** (left);
- `AUD_OUT` through a second 1 kΩ resistor to the jack **ring** (right);
- board ground to the jack **sleeve**.

This presents the same mono program on both channels without tying the jack's
tip and ring directly together. It is a line-level output and cannot drive
passive speakers; powered USB speakers are suitable because USB provides their
amplifier power.

### Selected TRS jack

The selected panel-mount jack is an Amphenol Audio `ACJS-MV35-3`. It is a
three-contact, non-switched 3.5 mm TRS jack. Its terminals are:

| Terminal | Connection |
| --- | --- |
| 1 | Sleeve / ground |
| 3 | Tip / left |
| 4 | Ring / right |

It needs a 6 mm panel hole and is specified for a panel no thicker than
1.15 mm with its supplied washer and nut. Allow 31.4 mm of clearance behind
the panel for the jack body and wiring.

## Reference

The circuit compatibility and model-specific installation guidance are based
on the [Intellivision Wiki composite-video modification guide](https://wiki.intellivision.us/index.php/Intellivision_Composite_Video_Modification).
