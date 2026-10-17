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
3. Route the board's video and audio outputs to RCA jacks.

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

## Reference

The circuit compatibility and model-specific installation guidance are based
on the [Intellivision Wiki composite-video modification guide](https://wiki.intellivision.us/index.php/Intellivision_Composite_Video_Modification).
