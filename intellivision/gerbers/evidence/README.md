# Nominal SPICE evidence — Intellivision composite amplifier

**Date:** 2026-10-21
**Status:** preliminary simulation evidence; not production qualification.

This folder records the first reproducible SPICE checks made against the
component values in the current
[`intv-video-composite.kicad_sch`](../../project/kicad/intv-video-composite.kicad_sch).
It is separate from the Gerber fabrication package: simulation does not
validate PCB manufacture, assembly, installation, or console-to-console
variation.

## Circuit and assumptions

- 5.0 V supply;
- the documented component values: two 2N3904 stages, 100 uF coupling
  capacitors, and the listed resistor values;
- a standard nominal 2N3904 SPICE model embedded in each netlist;
- 75 ohm output termination; and
- an approximately 2 kohm input source impedance for the AC test. That is an
  estimate published for the Intellivision's pre-RF video tap, not a measured
  characteristic of a particular console.

The original composite-mod reference describes the tap as high impedance and
estimates it at about 2 kohm:
<https://wiki.intellivision.us/index.php/Intellivision_Composite_Video_Modification>.
It does not provide a dependable raw-video Vpp value.

## Results

`ngspice` 44.2 was run in batch mode with the two netlists in this folder.

| Check | Result | Interpretation |
| --- | --- | --- |
| DC operating point | Q1: 3.29 mA, collector 2.83 V; Q2: 38.24 mA, collector 2.13 V, emitter 0.84 V | The nominal model does not place Q2 in hard saturation. |
| Small-signal AC gain, 2 kohm source / 75 ohm load | 7.16 dB (about 2.28 V/V) at 1 kHz and 10 kHz | Nominal response is broadly flat through the video-frequency range. |
| Small-signal AC gain, 75 ohm source / 75 ohm load | 8.08 dB (about 2.53 V/V) at 1 kHz and 10 kHz | Sensitivity to source impedance is modest in this model. |

The DC result agrees reasonably with the known-working circuit's published
troubleshooting voltages, which give Q2 collector/base/emitter values of
2.4 V/1.5 V/0.77 V (using slightly different resistor values):
<https://wiki.intellivision.us/index.php/Intellivision_Composite_Video_Modification>.

## Reproduce

From this directory, run:

```bash
ngspice -b intv-nominal-op.cir
ngspice -b intv-nominal-ac-2k-source.cir
ngspice -b intv-nominal-ac-75-source.cir
```

## What this does not prove

These are small-signal, nominal-model results. They do not establish the
actual raw-video amplitude or waveform, clipping margin, colour/sync fidelity,
noise, capacitor tolerance/ESR, transistor variation, or PCB/wiring effects.
Before a production order, run a transient simulation with a waveform captured
from the target console, then test at least one assembled board into a 75 ohm
video input.

The step-by-step live-unit acquisition plan is
[`live-unit-analog-discovery-2-test.md`](live-unit-analog-discovery-2-test.md).
