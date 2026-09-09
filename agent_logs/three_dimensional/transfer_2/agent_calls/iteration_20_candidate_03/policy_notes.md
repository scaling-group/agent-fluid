# Controlled replication of the far-to-near posterior wave handoff

## Visual and diagnostic evidence before the policy edit

- All four sampled evaluations are valid direct-uniform still-water releases:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window
  transport, stable dynamics, and `capture` termination. Their scores span
  `-0.20651-- -0.18968`, capture times span `19.354--19.591T`, and distance
  integrals span `2.07892--2.09637L`. This iteration therefore refines a
  capture trajectory rather than solving a missing-success failure.
- Both rows of the combined keyframe sheets for the strongest sample
  (`solver_2dfe05597921`) and the weakest-score controlled comparator
  (`solver_26d7454466f5`) were inspected from release through termination. The
  top-down rows show genuine self-propulsion from initially quiescent water, a
  coherent alternating posterior vortex street, a broadly target-directed
  transit, and a continuous late hook into the capture circle. The oblique
  rows show compact three-dimensional Lambda2 structures following each fish,
  with no passive advection, collision, wake breakup, or instability. Their
  visual topology is the same useful class; trajectory and actuator metrics,
  not a different wake class, distinguish them.
- The byte-identical response-gated posterior-bend repeats establish material
  execution variation: capture moved from `19.360T` to `19.591T`, distance
  integral from `2.08911L` to `2.09637L`, head path from `12.052L` to
  `12.202L`, and score from `-0.19989` to `-0.20651`. The extra response gate
  is therefore not a supported gain to compose.
- The far-amplitude/near-lag handoff is the only sampled new mechanism that
  clears that integral envelope. Relative to the prefilled posterior-lag
  policy, it reaches `10/8/6L` at `6.897/9.674/12.293T` rather than
  `7.040/9.828/12.463T`, lowers the distance integral from `2.09210L` to
  `2.07892L`, improves score from `-0.20288` to `-0.18968`, lowers mean
  anterior command from `19.03` to `18.26 rad/T^2`, and lowers anterior
  residence above 90% of the smooth command bound from `36.92%` to `35.52%`.
  It preserves capture at `19.354T`, zero angle-limit residence, and the common
  load class, but lengthens head path from `12.095L` to `12.416L`, raises peak
  force/moment slightly from `0.02486/0.01322` to `0.02523/0.01333`, and has
  only one completed evaluation. Replication is required before composition.
- An inherited completed log also falsifies the exact composite that removed
  posterior-lag allocation while exposing 20% of the terminal velocity-course
  residual outside `6L`: `solver_a13e9b0c8e27` left the domain with minimum
  distance `11.895L`, final distance `12.085L`, and score `-14.48666`. Because
  that candidate changed both gait allocation and redirect placement, it does
  not isolate either term, but it is decisive evidence not to repeat or stack
  that composite here.

## One-candidate hypothesis

Replace the prefilled all-distance posterior-lag modulation with the exact
sampled far-to-near wave-allocation handoff. Far from the target, bounded
joint-phase feedback redistributes the posterior carrier amplitude between the
useful and return strokes while base lag stays constant. As normalized
body-frame approach weight rises, that amplitude asymmetry is removed and the
sampled posterior-lag asymmetry is restored before terminal capture. Preserve
the fore/aft-aware target map, state-feedback oscillator, closing-speed drive
relief, terminal velocity-course/LOS redirect, anterior half-cycle steering,
mean curvature, and smooth action limit unchanged.

This is a controlled replication of `solver_2dfe05597921`, not a gain search.
Support requires another capture with distance integral below the prior
`2.08911--2.09637L` repeat envelope or a clearly compensating effort benefit,
while retaining coherent top-down and oblique wakes, joint margin, and the
approximately `0.025/0.013` force/moment class. Falsify the provisional handoff
if its early threshold lead disappears, the longer path or late hook grows,
capture/integral returns to the lag-repeat envelope, posterior near-bound or
rate-limit residence worsens, or either wake view loses coherence. Do not add
the failed far-field course-residual composite during this replication.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG amplitude and phase control with continuous far/middle/near task allocation
source_mechanism: preserve one traveling rhythm while normalized observed task geometry hands posterior authority from amplitude asymmetry to phase-lag asymmetry
transferable_invariant: allocate a bounded joint-state steering phase differently across approach regimes without changing the mean gait, adding clock phase, or memorizing a route
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body waveforms, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: use the existing body-frame approach weight to blend phase-conditioned posterior carrier amplitude far from the target into phase-conditioned posterior lag near the target under the unchanged two-joint acceleration contract
falsification: reject unless replication preserves capture and coherent wakes while confirming the integral or effort benefit beyond execution variation without worse path, joint margin, command residence, rate residence, force, or moment
