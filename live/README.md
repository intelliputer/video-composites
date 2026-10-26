# Intellivision II live raw-video capture — 2026-10-26

These are initial Analog Discovery 2 captures of the Intellivision II's
pre-RF raw composite-video line.  They characterize the source before a
composite-buffer board exists.

## Test configuration

- Console: Intellivision II, game cartridge installed; no composite board or
  display connected.
- Probe: 10x passive probe, tip on the video line entering the RF modulator;
  ground on the RF-modulator metal case (the console's low-voltage/video
  ground).
- The normal RF-modulator input connection was left in place.
- No 75-ohm load was connected.  That load is only applicable to a future
  composite-board output measurement.
- Captures were made in Digilent WaveForms with an Analog Discovery 2.

The voltages in the exports include the WaveForms 10x probe setting and are
therefore probe-tip voltages; they must **not** be multiplied by ten again.

## Captures and results

| Capture | Acquisition | Observations |
| --- | --- | --- |
| `2026-10-26-intellivision-ii-raw-video-wide.csv` / `.jpg` | 7.69231 MS/s, 8192 samples, 200 mV/div, falling-edge trigger at 0 V | -0.134 V to +0.188 V; 0.322 Vpp. Repeating negative-going sync features had a 63.692 us mean interval (about 15.70 kHz). This is the timing overview. |
| `2026-10-26-intellivision-ii-raw-video-narrow.csv` / `.jpg` | 50 MS/s, 8192 samples, 200 mV/div, falling-edge trigger at 0 V | Short line-scale view. It shows the expected sync structure without clipping; its 0.191 Vpp span reflects the particular mostly-dark video portion captured, rather than a contradiction of the wide capture. |
| `2026-10-26-intellivision-ii-raw-video-narrow-sync.csv` / `.jpg` | 100 MS/s, 8192 samples, 50 mV/div, normal falling-edge trigger at -50 mV | -0.134 V to +0.225 V; 0.359 Vpp. The principal horizontal sync pulse is about 4.8 us wide, with a tip near -0.110 V and adjacent blanking/back-porch near -0.035 V. An approximately 3.58 MHz oscillation follows the sync pulse (about 5.3–8 us after its leading edge), consistent with NTSC colour burst; estimated amplitude is about 28 mVpp. |

## Interpretation and limits

The captures establish that this raw node carries a composite-like waveform
with horizontal timing, sync, and colour-burst information.  They are source
characterisation records, not a validation of a final video-output circuit.
The passive-probe capacitance still loads the raw source somewhat; a
high-impedance active probe/buffer would be preferred for definitive chroma
fidelity measurements.

The exported files retain the original WaveForms header, acquisition settings,
and all 8192 samples for reproducible later analysis.
