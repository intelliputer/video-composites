# RF-can removal — minimum-component test criteria

## Objective

Remove the ASTEC UM1285-8 RF modulator without degrading the console's
baseband composite-video behaviour, and retain only the smallest validated
replacement input network. The goal is a healthy console with no unnecessary
RF generation; it is **not** to recreate the UM1285-8's RF function.

The final circuit may contain no added bias/load resistor, one resistor, or
both `R9` and `R10`. Select the smallest configuration that passes every
criterion below on representative consoles.

## Equipment and conditions

- Known-working NTSC console(s), one unmodified baseline unit and one
  first-article removal unit.
- 10× oscilloscope probe or active high-impedance probe; do not put a 75 Ω
  termination directly on `RAW_VIDEO`.
- 75 Ω composite termination and known-good display/scaler for `VID_OUT`.
- Short shielded raw-video lead; the same lead arrangement for baseline and
  removal tests.
- A repeatable dark, bright, and colour-rich game/test scene. Include a scene
  with frequent sound activity to expose interference.

Power down before changing a resistor, moving a probe, or removing the can.

## Baseline: RF can installed

1. At the console video node entering UM1285-8 pin 1, record with a
   high-impedance probe:
   - DC level at blanking;
   - full composite peak-to-peak amplitude;
   - sync-tip and blanking levels;
   - horizontal-sync period and width;
   - colour-burst peak-to-peak amplitude.
2. At the existing board's 75 Ω terminated `VID_OUT`, record the same
   waveform features plus output Vpp.
3. Photograph the test scene and save scope screenshots/settings. This is the
   reference set for the particular motherboard revision.
4. Estimate small-signal source impedance without materially loading the
   source: measure the raw-video amplitude unloaded, then with a **100 kΩ**
   resistor from `RAW_VIDEO` to ground. If the change is negligible, repeat
   with 47 kΩ and then 22 kΩ. For a stable scene, estimate
   `Rsource = Rload × (Vunloaded / Vloaded − 1)`. Treat this as a local AC
   estimate only; it does not define the required DC-bias network.

## Removal and network search

1. Remove the RF can. Leave `R9` (+5 V to `RAW_VIDEO`) and `R10`
   (`RAW_VIDEO` to ground) unpopulated for the first observation.
2. Record the same raw-video and `VID_OUT` measurements. If they match the
   baseline, the minimum added network is **no R9/R10 components**.
3. If they do not match, evaluate one component at a time before trying a
   two-resistor network:
   - fit `R9` only, beginning at high resistance and reducing it only as
     needed;
   - restore `R9` to DNP and fit `R10` only, likewise beginning high;
   - fit both only if neither single-resistor option passes.
4. Use a socket, resistor decade box, or temporary clip leads for this search.
   Do not solder a guessed production value repeatedly into aged console pads.
5. For every candidate, repeat the full waveform capture and 75 Ω output
   test. Record resistor values and the resulting measurements.

## Pass/fail criteria

A candidate passes only when all of the following are true relative to the
RF-can-installed baseline:

| Measurement | Pass criterion |
| --- | --- |
| `RAW_VIDEO` DC level and composite amplitude | Within 5% or 50 mV, whichever is larger. |
| Sync-tip and blanking relationship | No clipping, inversion, or visible sync instability. |
| Horizontal timing | Period and sync width within measurement repeatability. |
| Colour burst | Within 10% amplitude and visibly stable colour. |
| `VID_OUT` into 75 Ω | Approximately 1 Vpp, stable sync, normal black level, no bright-scene clipping. |
| Picture inspection | No new ghosting, bars, shimmer, colour errors, or audio-correlated interference. |
| Endurance | Passes cold start, 30-minute warm-up, repeated reset, and several scene changes. |

Test the selected values on at least three representative NTSC consoles,
including the Sylvania/2609 target. If values differ by motherboard revision,
do not call the circuit universal: identify the revision-specific values or
retain DNP options.

## Release rule

Freeze `R9`/`R10` only after one configuration passes the full matrix. Remove
the unneeded footprint from a later production revision if the evidence shows
it is never required. Until then, preserve both DNP footprints and the three
test points on the PCB.

## Evidence to retain

- Console model, motherboard revision, and power-supply condition.
- Baseline and post-removal scope captures.
- Exact resistor values, display/scaler, cable length, and termination.
- Test-scene photographs and warm-up results.
- Final schematic/PCB revision and BOM.
