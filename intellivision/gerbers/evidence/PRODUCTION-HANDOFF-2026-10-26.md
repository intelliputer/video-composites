# Intellivision Rev.1 production handoff

**Milestone date:** 2026-10-26 (Europe/Amsterdam)  
**Release payload commit:** `17057e0f74baa28441756b24da826a5b51829880`  
**Fabrication package:** [`../intv-video-composite-rev-1.zip`](../intv-video-composite-rev-1.zip)  
**SHA-256:** `d8b76bbf10c8419bd72c118923ccaeda13013649c032c51a5d8d9f9923933578`

This is the handoff point for the boards sent to production. Treat the ZIP above
as the exact fabrication artifact for the first article. Do not overwrite it;
record any post-fabrication changes as a new revision and package.

## Source baseline

- PCB: [`../../project/kicad/intv-video-composite.kicad_pcb`](../../project/kicad/intv-video-composite.kicad_pcb)
- Schematic: [`../../project/kicad/intv-video-composite.kicad_sch`](../../project/kicad/intv-video-composite.kicad_sch)
- Circuit assumptions and nominal simulation: [`README.md`](README.md)
- Live-unit capture and measurement procedure: [`live-unit-analog-discovery-2-test.md`](live-unit-analog-discovery-2-test.md)

## Release-check record

KiCad 10.0.7 validation was run against the payload commit on 2026-10-26.

| Check | Result | Disposition for board return |
| --- | --- | --- |
| ERC | 0 errors, 3 warnings | Review the two cached 2N3904-symbol mismatches and the +5 V wire-endpoint warning before a follow-on board revision. |
| PCB DRC | 0 errors, 9 warnings | C3's local footprint override and the compact 0.65 mm connector labels are intentional visual choices; KiCad's configured silkscreen minimum is 0.80 mm. The fabricator's DFM review reported no errors for this production run; confirm print legibility on the first article. The remaining warning is the `cartheur` text-stroke weight. |
| Unconnected pads | 0 | Pass. |
| Schematic/PCB parity | 4 issues | J1–J4 use intentional local footprint-value overrides for their connector labels; verify that intent before the next fabrication release. |
| ZIP integrity | Pass | The package was successfully tested with `unzip -t`. |

The DRC/parity results above are a pre-return checklist item, not evidence that
the circuit has been electrically qualified. The existing reports in
[`../../../reports/`](../../../reports/) predate this final cosmetic polish;
rerun and save them when starting the next design revision.

## First-article continuation plan

When boards arrive, preserve one unmodified board and log the board markings,
fab order/lot, assembly choices, console model and motherboard revision. Then:

1. Inspect copper, drill registration, mask, silkscreen, component polarity,
   and connector labels against the released PCB.
2. Before fitting the console, check power-to-ground resistance and continuity
   of each intended wire/pad connection.
3. Power the assembled board from a current-limited 5 V supply; record supply
   current and the Q1/Q2 DC node voltages.
4. With a short, shielded input connection and a 75 ohm terminated composite
   input, capture raw input and board output. Check sync timing, colour burst,
   amplitude, clipping, ringing, noise, and image stability.
5. Repeat on the target Intellivision revisions where practical, using several
   representative games and both video and audio outputs.
6. Store scope captures, photographs, measurement conditions, pass/fail
   observations, and any rework in `live/` before changing the design.

Resume from this file for the assembled-board analysis. A follow-on revision
should be made only after the measured evidence is recorded and the release
check warnings have been explicitly fixed or waived.
