# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

The assigned parent is the guidance inherited from `optimizer_ed32d38962aa`.
I used its seed-derived lesson and both inherited candidate notes, all four
sampled solver policies and scores, the compact observation/metric/diagnostic
files, and the shared and released keyframe sheets. No omitted Bookshelf
material, neighboring configuration, repository history, or external research
was used.

The shared prewarm sheet shows the common held fish near the upper-right edge
while four developed asymmetric vortex streets overlap around the target. It
is identical initial-condition evidence, not evidence for any candidate. The
released sheets separate four control regimes:

- The target-blind seed bends vigorously but turns into a near-vertical lower
  exit. It survives `50.13` release units, improves distance only transiently
  to `8.615L`, and finishes `12.123L` away with `0.0243` progress. Mean world
  velocity `(-0.0725,-0.2633)` is close to local flow
  `(-0.0414,-0.2414)`, both acceleration and velocity caps are reached, and
  mean command energy is `1496.25`; its large displacement is therefore not
  efficient target-directed propulsion.
- The assigned parent's positive-bearing/positive-curvature descendant barely
  bends and is swept out through the nearby right boundary in `16.73` units.
  Its `(+2.183,-0.856)L` displacement, `-0.1480` progress, only `0.0160`
  upstream mean velocity relative to local flow, and mean command energy
  `0.218` show that this rollout was under-driven. It cannot determine the
  steering sign in isolation.
- The inherited negative-curvature candidate produces immediate severe
  deformation and a tight upper-right spin rather than a navigational turn.
  It terminates as `unstable_dynamics` after `4.45` units: anterior bend reaches
  `0.721 rad`, anterior speed reaches the `4.538 rad/time` cap, RMS relative
  crossflow is `3.139`, and RMS lateral force/moment rise to
  `5.50e4/5.68e5`. This falsifies that candidate's sign-and-drive package; it
  is not a safe anchor for further gain tuning.
- The only successful sample maps positive bearing to positive curvature while
  retaining a self-starting energy-regulated gait. Its sheet shows sustained
  upstream swimming into the developed wake region, followed by a broad
  downward overshoot and return to the target. The metrics confirm genuine
  propulsion and finite dynamics: it reaches the `0.75L` capture radius after
  `130.23` units with `0.9397` progress and head displacement
  `(-10.925,-4.449)L`; mean world x velocity is `-0.0835` versus local flow
  `-0.0455`, and RMS force/moment are `26.34/427.54`. Joint speeds remain
  below the hard cap, although both acceleration commands touch the candidate
  bound of `28 rad/time^2`; mean command energy is `681.12`.

Together the evaluated evidence overturns the assigned parent's inference that
positive bearing requires negative curvature. It also confirms the inherited
successful worker's propulsion hypothesis: a `0.75`-period, `22 deg`
energy-regulated oscillator has enough relative upstream authority to survive
initial advection and reach the target. The remaining visible defect is not
capture failure but the large target-relative angular overshoot before return.

## One candidate hypothesis

Use the evaluated successful controller as the conservative anchor, preserving
its oscillator, posterior lag, damping, steering sign and limits, and action
bound exactly. Add only a small bounded lead from the windowed bearing rate to
the bearing error. When bearing is closing rapidly, the negative rate term
reduces positive curvature before the bearing crosses zero; when bearing is
opening, it adds a limited correction. Bounding the rate contribution to only
`0.045 rad` of bearing-equivalent error keeps this secondary to the successful
bearing feedback and avoids the inherited candidate's raw heading-rate
coupling.

The later CFD evaluation should retain nontrivial joint motion, finite loads,
upstream relative velocity and semantic target capture, while shortening the
broad below-target excursion, arrival time, or distance integral. The lead is
falsified if capture is lost, if the fish again leaves the nearby right edge,
if acceleration limiting or loads materially exceed the successful anchor, or
if arrival/distance evidence shows no reduction in overshoot. Because the
positive and negative sign samples also differ in gait strength, only a later
propulsively matched sign comparison can establish a general sign rule beyond
this fixed body convention and common prewarm.
