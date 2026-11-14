Yes—substantial baseline evidence is already in [intellivision/characterization](/home/cartheur/ame/aiventure/aiventure-github/intelliputer/video-composites/intellivision/characterization):

- Three Intellivision II pre-RF waveform captures, as CSV and JPEG.
- Captured horizontal timing, sync, and 3.58 MHz colour burst.
- A baseline taken at the raw-video line entering the RF modulator.

The existing [live-unit test plan](/home/cartheur/ame/aiventure/aiventure-github/intelliputer/video-composites/intellivision/gerbers/evidence/live-unit-analog-discovery-2-test.md) already correctly warns that the 2 kΩ figure is only an estimate and that the RF module input can affect the raw node.

What is missing is the decisive evidence:

- Same-node capture with the RF can removed
- Controlled `R9` / `R10` load-step captures
- A baseline-versus-removal comparison into the board’s 75 Ω output
- Measured DC bias at the UM1285 pin-1 video input

So the characterization folder gives us the installed-RF baseline, but not yet the data needed to choose the minimum removal network.