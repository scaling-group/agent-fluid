# Phase 2 wake-policy notes

## Evidence diagnosis before editing

- The four sampled evaluations are direct uniform still-water releases
  (`U_infinity=[0,0,0]`, no prewarm) and all capture at `19.684490 T` with
  score `-0.261384287`, mean distance `2.151092787 L`, final distance
  `0.748302400 L`, and 243 moving-window shifts.
- Both rows of the combined keyframe sheet were inspected. The top-down row
  shows self-propelled, target-directed motion with a coherent alternating
  wake from release through capture, rather than passive advection. The
  oblique row shows finite, localized three-dimensional Lambda2 structures
  following the tail; neither view shows a collision, domain exit, wake
  collapse, or instability. The head follows a compact monotone approach,
  while the alternating body motion remains productive outside the quiet
  terminal posture.
- All four combined sheets are byte-identical. Three sampled policies are the
  same v40 source and the v41 source differs only by a terminal course/yaw
  selector; nevertheless all four trajectories and visual sheets are
  identical. Cross-checking the inherited reconstruction explains why: v41's
  new support peaks near `0.240`, below the existing `0.82` allocation floor,
  so its `max` composition never changes a command. There is therefore no
  distinct current failure image to rank against the best finite sample; the
  informative failure is structural dormancy, while inherited completed
  failures show that shortening posterior lag caused a `46.145020 T` loop and
  adding startup mean curvature delayed capture to `23.375013 T`.
- The useful rollout still has a response deficit at release: speed is only
  about `0.135 L/T` at `2 T` and `0.367 L/T` at `4 T`, before reaching roughly
  `0.8--0.9 L/T`. The mature carrier already reaches the software acceleration
  cap often and produces a coherent wake, so changing its lag, mean curvature,
  or terminal allocation is contradicted by the sampled and inherited
  evidence. The remaining falsifiable locus is establishment of carrier
  energy before that mature response exists.

## Candidate hypothesis

Replace the dormant v41 selector with response-conditioned oscillator energy
recovery. Outside the protected `4 L` terminal band, and only while the large
target-angle redirect is quiet, low observed translational speed may enable a
bounded positive-damping term. Joint phase-space radius then releases that
term continuously as the anterior oscillator reaches its established
amplitude. This preserves the carrier's equilibrium, frequency, posterior lag,
target residual, and mature/terminal laws. The expected signature is earlier
formation of the same alternating wake and faster early distance reduction;
the candidate fails if the new branch is dormant, increases sustained
saturation or loads, changes the compact route, forms paired wake bands or a
loop, delays/loses capture, or changes any command at or below `4 L`.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control
source_mechanism: sensory feedback modulates rhythmic-state energy while coupled oscillators preserve the traveling-wave coordination
transferable_invariant: recover propulsive rhythm only while measured locomotor response and oscillator phase-space energy are deficient, then release the recovery as the response establishes
nontransferable_details: published oscillator gains, explicit clock phases, species-specific amplitudes and frequencies, full-body waveforms, and task-specific routes
policy_translation: use normalized body-frame speed, target-angle redirect state, distance, and the two-joint angle/velocity state to gate a bounded anterior energy-injection term while leaving posterior lag and all target-relative steering unchanged
falsification: reject dormancy or any slower/lost capture, changed outer topology, sustained clipping or load growth, joint-stop dwell, terminal-command change, instability, or degradation of either wake view

## Pre-evaluation contract audit

Replaying the v40 recorded states through v40 and this candidate (an activity
check, not CFD evidence) changes 836 of 3,579 commands, all at head distance
greater than `4 L`; the maximum command delta is `5.424600 rad/T^2`, and no
recorded command at or below `4 L` changes. The recovery acceleration is active
on the same 836 states. Thus the mechanism is neither structurally dormant nor
able to leak into the protected terminal law on the inherited trajectory. Its
hydrodynamic benefit remains unclaimed until a later worker receives the CFD
evaluation.
