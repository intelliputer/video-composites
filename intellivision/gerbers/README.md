# Production Gerber packages

`ec.zip` is the preserved, successful production package for the Intellivision
composite board.  It is byte-identical to the former `old.zip` archive; it was
renamed to identify it as the EC/manufacturer-compatible reference set rather
than as an obsolete design.

Use this archive as the post-export production check: after exporting a PCB's
Gerbers, verify that the intended submission package has the applicable
manufacturer-required files, layers, drill data, and naming, then apply the
same EC packaging requirements before submitting the order.  Do not alter the
contents of `ec.zip`; it is the known-good reference artifact.

This evidence applies to this Intellivision Gerber set and its manufacturer
submission requirements only.  It does not make the board electrically
interchangeable with the separate Atari composite design.

Preliminary circuit-simulation evidence is kept separately in
[`evidence/`](evidence/). It is not part of the manufacturer submission
package and does not replace assembled-board validation.
