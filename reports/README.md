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

**Status: partial validation only; restore the source schematic before
manufacturing review.**

The populated board file is
[`intellivision-composite.kicad_pcb`](../intellivision/project/kicad/intellivision-composite.kicad_pcb).
Standalone KiCad 10.0.7 DRC was run on 2026-10-17:

| Check | Result | Assessment |
| --- | --- | --- |
| PCB DRC | 18 warnings, 0 errors | All warnings are dangling, no-net track ends. Review whether they are intentional layout artifacts. |
| Unconnected pads | 0 | Pass. |
| Footprint errors | 0 | Pass. |
| Schematic ERC | 0 violations | The file loads, but it is an empty schematic with no circuit to validate. |
| Schematic/PCB parity | Not run | Requires the matching source schematic. |

`intellivision-composite.kicad_sch` is only 233 bytes and contains no circuit.
It is not a usable source counterpart for the populated board, so an ERC or
board/schematic parity result would not be meaningful. Restore or recreate the
matching schematic before treating the board as manufacturing-ready.

Run the available standalone DRC from the repository root with:

```bash
report_dir="$PWD/reports"

flatpak run --filesystem="$report_dir" --command=kicad-cli org.kicad.KiCad \
  pcb drc --exit-code-violations \
  --output "$report_dir/intellivision-composite-drc.rpt" \
  "$PWD/intellivision/project/kicad/intellivision-composite.kicad_pcb"
```

After restoring a valid matching schematic, also run ERC and parity DRC using
the same Atari command pattern below, substituting the Intellivision file
paths.

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
