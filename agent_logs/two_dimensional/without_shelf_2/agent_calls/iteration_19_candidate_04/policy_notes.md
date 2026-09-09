# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 task and guidance contracts, the assigned-parent
experience, all four sampled policies, scores, compact observations, CSV/JSON
diagnostics, and the relevant inherited optimizer notes and evaluated
descendants. I inspected the common held-fish prewarm sheet first, then the
released sheets for the two byte-identical static `tail_steering_gain=0.70`
anchors, the assigned scheduled-share parent, the speed-gated damping result,
and the inherited static `tail_steering_gain=0.75` failed hypothesis. I used no
omitted Bookshelf material, neighboring configuration, repository history,
coordinate route, clock, or external research.

The prewarm sheet shows the fish fixed at the upper-right release pose while
the four staggered cylinder streets develop, merge, and convect through the
second-row target. It is shared initial-condition evidence rather than a
candidate-specific wake signal. Every current sampled rollout is finite and
reaches the target. Their released sheets show useful self-propulsion: each
fish turns down-left, beats upstream through the developed street, and enters
the capture circle from the right without collision, domain exit, coil, or
loop. The embedded diagnostics confirm material world/local-flow separation,
not passive advection.

The two static `tail_steering_gain=0.70`, `tail_damping=0.65` anchors have
identical imagery and physical diagnostics, so they count as one deterministic
same-snapshot result. They reach in `72.457` release units with `2.45409L`
mean distance, `0.06620` upstream-relative x speed, `51842` command energy,
`0.13063` RMS relative crossflow, `23.85/408.89` RMS force/moment, and
anterior/posterior peak speeds `3.086/3.293 rad/time`. Both actions touch the
common `28` guard, but joint angles remain finite.

The sampled normalized-speed gate preserves static posterior share and base
damping, adding at most `0.025` damping through a smooth gate centered at
`abs(qd2)/(omega*amplitude)=1.0` with width `0.08`. Its keyframes take a
slightly shallower, more compact diagonal route and complete the final
correction earlier. It improves arrival to `70.823`, mean distance to
`2.38538L`, upstream-relative x speed to `0.06972`, command energy to `50756`,
and force/moment to `22.72/397.24`; posterior peak speed falls to `3.260`.
This is a corroborated positive result rather than a score-only change.
Crossflow rises marginally to `0.13092`, and anterior peak speed rises to
`3.112`, so it does not prove that localized damping eliminates all work
transfer.

The assigned scheduled-share parent also reaches compactly, but is dominated
by the speed-gated result on arrival (`71.615`), mean distance (`2.42407L`),
energy (`51250`), force/moment (`23.26/402.06`), and posterior peak speed
(`3.299`); it retains slightly higher upstream-relative x speed (`0.07111`)
and slightly lower crossflow (`0.13022`). The inherited static `0.75`
posterior-share continuation is the most informative visually available
failed optimization hypothesis: it remains finite and lowers aggregate load,
but visibly makes a lower final approach, regresses mean distance to
`2.50932L`, raises energy to `52496`, and raises posterior peak speed to
`3.370`. The older true reversed-sign instability remains a safety boundary,
but its sheet is unavailable here and supplies no new visual claim.

The successful gate also resolves the inherited constant-damping boundary.
Static `tail_damping=0.675` lowered posterior speed but selected a deep,
kinked route (`91.50` arrival, `2.788L` mean distance, `60660` energy, and
`42.13/581.11` force/moment). High-speed localization avoids that failure on
the common snapshot, but only one gate shape has been evaluated.

## Single-candidate hypothesis

Use the evaluated speed-gated `0.70` policy as the anchor and change only the
gate transition width from `0.08` to `0.04`. The evaluated posterior maximum
is only about `1.013` times `omega*amplitude`: narrowing the smooth transition
raises the peak gate fraction modestly while sharply reducing damping below
the normalized-speed threshold. The maximum increment remains bounded at the
already tested `0.025`; base damping, oscillator, bearing steering, posterior
share and lag, and the common `28/28` guard remain unchanged. This isolates
peak-speed damping further instead of broadening it toward the failed static
`0.675` law.

The falsifiable expectation is the same finite compact diagonal capture with
posterior peak speed at or below `3.260 rad/time`, less transfer toward the
anterior joint, and arrival, `2.38538L` mean distance, `50756` effort, and
`22.72/397.24` loads at least competitive with the evaluated gate. Reject the
narrower transition if it introduces visible switching, restores the lower
detour, raises anterior speed or crossflow without a corroborating closure
gain, or materially worsens arrival, relative propulsion, effort, or loads.
Any same-snapshot benefit remains unproven until later CFD and must survive
held-out wake phase, inflow, geometry, and target placement.
