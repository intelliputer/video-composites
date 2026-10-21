# Live-unit capture plan — Analog Discovery 2

**Purpose:** capture the actual Intellivision pre-RF video signal and compare
it with the board's 75-ohm-terminated output. The captures will replace the
simulation's assumed source waveform and improve confidence before a production
order.

**This is a measurement plan, not an instruction to work on a live mains
assembly without appropriate experience.** The original Intellivision has
mains-powered hardware. Work with the console powered through a suitable
isolation transformer, keep clear of the PSU primary/mains wiring, and connect
the AD2 only to the low-voltage logic/video ground. Never attach an AD2 lead to
the primary side of the supply. Do not use the AD2 Wavegen or power supplies to
power or drive the console.

## Equipment

- working NTSC Intellivision and a representative game/cartridge;
- Analog Discovery 2, USB host, and WaveForms;
- 75-ohm composite-video termination/display (or a verified 75-ohm terminator);
- short insulated test leads; and
- preferably, a high-impedance active probe/buffer for the raw-video node.

The AD2 has two differential scope inputs, 1.04 Mohm || 24 pF input impedance,
14-bit conversion, and 100 MS/s capability. Its 24 pF input capacitance can
meaningfully load a source estimated at 2 kohm at the 3.58 MHz colour
subcarrier. A direct AD2 connection is useful for an initial check but is not
adequate proof of unaltered chroma. Use a high-impedance active probe/buffer
for the definitive raw-node capture.

AD2 reference: <https://digilent.com/reference/test-and-measurement/analog-discovery-2/ad2_rm.pdf>.

## Connections

With console power **off**:

| AD2 lead | Connect to | Notes |
| --- | --- | --- |
| `1-` and `2-` | Console low-voltage/video ground | Make this one short, secure reference connection. |
| `1+` | Raw-video line entering the RF modulator | The centre conductor/video point, not RF output. Start with an active probe/buffer if available. |
| `2+` | Composite board `VID_OUT` / RCA centre pin | Measure only with a 75-ohm termination present. |

Keep the raw-video and output leads short. Confirm continuity to the intended
low-voltage ground before powering the console. Do **not** connect to the RF
coax output or probe inside the PSU primary area.

## Capture sequence

### 1. Baseline and supply

1. Photograph and record the console model, motherboard revision, cartridge,
   board revision, transistor markings, and component substitutions.
2. With power off, check board-to-console wiring and ensure no shorts between
   +5 V and ground.
3. Power on. Measure the board +5 V at the board supply pins and record it.
4. In WaveForms Scope, begin on the 5 V input range. Confirm both channels are
   in range before selecting a narrower range.

### 2. Raw source only

1. Temporarily leave the composite board input disconnected if the installation
   permits; retain the normal RF modulator connection.
2. Capture channel 1 at 100 MS/s where practical. Use a horizontal window of
   at least 100 microseconds and trigger on a horizontal-sync edge.
3. Save a CSV and screenshot for a dark screen/menu and a bright or highly
   coloured game scene.
4. Record raw-node minimum, maximum, Vpp, approximate DC level, horizontal
   rate, and whether colour burst is visibly repeatable. Note the probe type.

### 3. Installed-board comparison

1. Reconnect the board input and connect the output to the known 75-ohm load.
2. Capture channels 1 and 2 simultaneously with the same time base and a
   channel-1 sync trigger.
3. Save CSV and screenshot pairs for the same dark and bright/colour scenes.
4. Record output minimum, maximum, Vpp, blanking level, sync-tip level, and
   visible evidence of clipping/ringing. Also record the display/scaler result.

### 4. Stress and repeatability

1. Run the console for at least 30 minutes, then repeat the paired capture.
2. Repeat with a second game and, if available, a second compatible console.
3. Inspect for loss of sync, colour shift, bright-area smearing, hum, and
   picture changes after warm-up.

## Source-characterisation follow-up

Do not assume the raw node is a simple 2 kohm Thevenin source. It is generated
by the AY-3-8915/resistor network and can be affected by probe capacitance and
the RF modulator's input network. First obtain the non-invasive capture above.
Only then, if needed, perform a separately planned load-step test with known,
high-value loads and an active probe. Record each load and waveform; use those
measurements to build a source model for the transient simulation.

## Evidence to retain

For every run, save:

- original WaveForms capture and CSV export;
- screenshots showing scale, sample rate, time base, and trigger;
- the test conditions and visual outcome; and
- a short measurement table with raw and output levels.

Suggested filename: `YYYY-MM-DD-console-revision-game-condition-raw-or-output`.

## Initial decision rule

The board is promising if it consistently gives a stable, correctly coloured
picture and clean sync into a 75-ohm input, with an output near the nominal
1 Vpp composite range and no material change after warm-up. Treat one
successful console as a prototype result, not production confidence. Update
the SPICE transient source with the captured raw waveform, then repeat on more
than one unit before assigning a stronger confidence level.
