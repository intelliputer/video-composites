# RF-can replacement input network — characterization proposal

This is a **first-article measurement provision**, not a production circuit.
The Intellivision raw-video source is estimated to have approximately 2 kΩ
source impedance. The ASTEC UM1285-8 datasheet defines the intended video
input's DC operating range, but does not give a numeric input impedance or
publish the module's internal bias circuit. A fixed replacement pull-up would
therefore be an unsupported guess.

## Schematic change

Keep the existing input path unchanged:

```text
RAW_VIDEO ────────────────────────────────> C1 ──> existing amplifier
```

Add two **DNP by default** resistor footprints at `RAW_VIDEO`:

```text
                R_BIAS (DNP)
+5V ──────────────────────────┐
                              │
RAW_VIDEO ────────────────────┼──> C1 / existing amplifier
                              │
GND ──────────────────────────┘
                R_LOAD (DNP)
```

Suggested schematic references and names:

| Reference | Value | Connections | Default | Purpose |
| --- | --- | --- | --- | --- |
| `R9` | `DNP — bias experiment` | +5 V to `RAW_VIDEO` | Do not fit | Candidate source-side bias/load path. |
| `R10` | `DNP — load experiment` | `RAW_VIDEO` to GND | Do not fit | Candidate return/load path. |
| `TP1` | `RAW_VIDEO` | Raw source / C1 input | Fit | Oscilloscope connection. |
| `TP2` | `+5V` | Regulated board supply | Fit | Reference measurement point. |
| `TP3` | `GND` | Board ground | Fit | Reference measurement point. |
| `C5` | 100 nF, X7R, >=16 V | +5 V to GND | Fit | Local high-frequency decoupling. |
| `C6` | 10 uF, >=10 V | +5 V to GND | Fit | Local low-frequency decoupling. |

Existing connection pads can serve as the test points if their silkscreen is
renamed: `J1` = `RAW_VIDEO`, `J5` = `+5V`, and `J6` = `GND`.

## Bench method before choosing resistor values

1. On a working, unmodified console, measure the raw-video node at UM1285-8
   pin 1: DC level, composite amplitude, sync-tip level, and colour burst.
2. Remove the RF can on a sacrificial/first-article console and repeat the
   measurement with `R9` and `R10` unpopulated.
3. Fit selectable resistor values only as needed. Compare the raw waveform to
   the original-can baseline, then test the buffered output into a 75 Ω load.
4. Freeze `R9` and/or `R10` only when sync, colour, black level, and
   bright-scene clipping match the baseline across warm-up and more than one
   display/scaler.

Do not populate a fixed resistor merely because it appears in another
console's RF-removal modification. With a roughly 2 kΩ source, even a few
kilohms materially changes the load and waveform.

Use the [RF-can removal test criteria](RF-CAN-REMOVAL-TEST-CRITERIA.md) as
the required baseline, resistor-search, and release procedure.

## Source constraints

The ASTEC UM1285-8 datasheet specifies a video-input operating region around
2.2–2.8 V but lists `ZIN` only as “See Modulation Transfer Characteristic.”
It does not disclose the internal input schematic. See
[`../datasheets/UM1285-8.pdf`](../datasheets/UM1285-8.pdf).
