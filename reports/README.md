# Validation reports

This directory holds reproducible KiCad validation reports and their status.
It currently documents the Atari 2600 composite-video amplifier validation.

## Atari 2600 composite-video amplifier

**Status: not ready for fabrication.**

KiCad 10.0.7 validation was run on 2026-10-17 against:

- [`atari/project/kicad/atari-composite.kicad_sch`](../atari/project/kicad/atari-composite.kicad_sch)
- [`atari/project/kicad/atari-composite.kicad_pcb`](../atari/project/kicad/atari-composite.kicad_pcb)

| Check | Result | Assessment |
| --- | --- | --- |
| Schematic ERC | 0 errors, 73 warnings | Warnings are primarily legacy-project issues: off-grid endpoints and unavailable legacy footprint/symbol-library references. |
| PCB DRC | 16 errors, 21 warnings | Must be reviewed and corrected or explicitly waived before manufacturing. |
| Unconnected pads | 0 | Pass. |
| Schematic/PCB parity | 11 issues | Must be resolved: current board net names do not match the schematic's Q1/Q2 pin-net names. |

### DRC issues requiring review

- 7 footprint-courtyard overlaps in the resistor row;
- 8 copper-to-edge-clearance violations: 0.47 mm actual versus the board rule
  of 0.50 mm;
- 1 incomplete B.Cu ground-zone thermal relief at J1 ground pad;
- 7 silkscreen-to-edge warnings; and
- 14 legacy footprint-library warnings.

The legacy library and off-grid warnings do not by themselves prove an
electrical fault. The parity mismatches, board-edge clearances, thermal relief,
and any unintended courtyard overlap need an engineering decision before the
board is fabricated.

## Intellivision composite-video board

**Status: pre-production candidate; disposition legacy warnings and complete
first-article validation before manufacturing.**

The populated board and matching schematic are
[`intv-video-composite.kicad_pcb`](../intellivision/project/kicad/intv-video-composite.kicad_pcb)
and
[`intv-video-composite.kicad_sch`](../intellivision/project/kicad/intv-video-composite.kicad_sch).
KiCad 10.0.7 validation was run on 2026-10-26:

| Check | Result | Assessment |
| --- | --- | --- |
| Schematic ERC | 0 errors, 3 warnings | The external +5 V and ground inputs are marked as their rails' sources. The remaining warnings are two cached-symbol mismatches and one apparently dangling +5 V wire endpoint. |
| PCB DRC | 2 warnings, 0 errors | C3 intentionally uses a local footprint override to place its silkscreen on the top side; the other warning is the existing silkscreen text-thickness item. |
| Unconnected pads | 0 | Pass. |
| Footprint errors | 0 | Pass. |
| Schematic/PCB parity | 0 issues | Pass. |

The current reports are
[`intv-erc-2026-10-26.rpt`](intv-erc-2026-10-26.rpt) and
[`intv-drc-2026-10-26.rpt`](intv-drc-2026-10-26.rpt).  The prior description
of an empty Intellivision schematic is obsolete.

Run the available standalone DRC from the repository root with:

```bash
report_dir="$PWD/reports"

flatpak run --filesystem="$report_dir" --command=kicad-cli org.kicad.KiCad \
  pcb drc --exit-code-violations \
  --output "$report_dir/intv-video-composite-drc.rpt" \
  "$PWD/intellivision/project/kicad/intv-video-composite.kicad_pcb"
```

Run ERC and parity DRC using the same Atari command pattern below, substituting
the Intellivision file paths.

## Running KiCad validation with Flatpak

KiCad 10's CLI is run through the Flatpak application. From the repository
root, save fresh reports here with:

```bash
report_dir="$PWD/reports"

flatpak run --filesystem="$report_dir" --command=kicad-cli org.kicad.KiCad \
  sch erc --exit-code-violations \
  --output "$report_dir/atari-erc.rpt" \
  "$PWD/atari/project/kicad/atari-composite.kicad_sch"

flatpak run --filesystem="$report_dir" --command=kicad-cli org.kicad.KiCad \
  pcb drc --exit-code-violations --schematic-parity \
  --output "$report_dir/atari-drc.rpt" \
  "$PWD/atari/project/kicad/atari-composite.kicad_pcb"
```

`--filesystem="$report_dir"` makes the host report directory available to
the sandboxed Flatpak application. `--exit-code-violations` deliberately
returns a non-zero status when KiCad finds any violation, making these commands
suitable for a pre-commit check or CI job. The `.rpt` files are generated
artifacts: inspect them after each run and do not treat them as evidence that a
later board revision has passed.
