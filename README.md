## Video Composites

Hardware designs and reference material for adding baseband composite-video
and mono-audio outputs to vintage consoles. The repository preserves separate
Atari 2600 and Intellivision amplifier designs while developing a better
documented universal direction for consoles that expose composite video ahead
of their RF modulator.

> These are baseband-video modifications, not RF-to-composite converters. A
> console must provide a suitable pre-RF video signal, regulated +5 V, ground,
> and, where used, raw mono audio.

### Current state

| Design | Purpose | State |
| --- | --- | --- |
| [Atari 2600](atari/README.md) | Adjustable two-stage composite-video amplifier and mono-audio pass-through. | Source design preserved; resolve or explicitly waive the recorded PCB DRC items before manufacturing. |
| [Intellivision](intellivision/doc/COMPATIBILITY.md) | Fixed-gain two-stage composite-video amplifier and mono-audio coupling for NTSC Intellivision-family consoles. | Source schematic and PCB now have zero parity issues and zero ERC errors; review/waive recorded legacy warnings and complete first-article, 75-ohm-load validation before manufacture. |
| [Universal](universal/README.md) | Proposed adjustable, AC-coupled two-stage design for appropriate baseband sources. | Design direction and prototype documentation; validate on target hardware before release or production. |

Validation details and reproducible KiCad checks are in [reports/README.md](reports/README.md).

### Atari 2600 composite amplifier

The Atari board uses a 2N3904 input stage, a 2N3906 output stage, and an
adjustable gain trimmer. It takes regulated +5 V, ground, raw pre-RF video,
and raw audio from the specific console revision, then provides buffered video
and mono audio for external RCA connectors.

Start with the [Atari design and installation notes](atari/README.md) and its
[BOM](atari/doc/BOM.md). Board revisions, video taps, and physical mounting
vary; confirm the signals on the actual console rather than copying solder
points from another revision.

### Intellivision composite amplifier

The Intellivision board uses two 2N3904 stages with AC coupling and fixed
component values. It is intended for NTSC Intellivision I, Intellivision II,
and Sears Telegames / Super Video Arcade 497.75022 consoles, subject to the
[compatibility and installation notes](intellivision/doc/COMPATIBILITY.md).

The repository includes board imagery, a reconstructed circuit analysis, and
the [BOM](intellivision/doc/BOM.md). The populated KiCad PCB has a matching
source schematic with zero current parity issues and zero ERC errors. It remains a
pre-production candidate: disposition the recorded legacy warnings and validate
an assembled board into a 75-ohm composite load before placing a manufacture
order.

#### Production Gerber reference

[`intellivision/gerbers/archive/ec.zip`](intellivision/gerbers/archive/ec.zip) is the
preserved successful EC/manufacturer-compatible Gerber package, renamed from
`old.zip`. It is the known-good reference for the post-export, pre-submission
packaging check: compare a newly exported intended submission against its
required layers, drill data, files, and naming before ordering. Its provenance
does not make it an Atari board or prove that an altered board is ready to
manufacture. See the [Gerber-package note](intellivision/gerbers/README.md).

### Universal direction

The [universal design note](universal/README.md) compares the two existing
amplifiers and proposes an adjustable-gain, AC-coupled design with explicit
supply decoupling. It is intended as a future common platform, not evidence
that either existing board is electrically interchangeable with the other.

### Before modifying a console or ordering boards

1. Verify that the target console exposes baseband composite video before its RF modulator.
2. Confirm raw video, audio, +5 V, and ground on the individual motherboard.
3. Use short shielded video wiring and test with a properly terminated 75-ohm composite input.
4. Check polarity, signal level, sync, colour, black level, and bright-scene clipping before permanent installation.
5. Review the relevant validation report and, for Gerber submissions, complete the applicable manufacturer packaging check.

### Repository layout

```text
atari/          Atari 2600 source, BOM, analysis, and installation references
intellivision/  Intellivision source, documents, and production Gerber references
universal/      Common-design proposal, prototype material, and KiCad work
reports/        Recorded ERC/DRC status and commands for reproducing checks
```

### License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
