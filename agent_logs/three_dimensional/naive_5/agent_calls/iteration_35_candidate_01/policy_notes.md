# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. All capture without angle, speed, or policy-acceleration contact,
  so route efficiency and response topology are more informative than the
  common termination class.
- I inspected the combined top-down vorticity and oblique Lambda2 rows for the
  three unique samples from release through capture. Every fish self-propels
  from rest, sheds an orderly alternating wake, and retains a compact coherent
  three-dimensional wake through the same late target-side hook. There is no
  passive advection, broad wasteful curl, wake breakup, boundary interaction,
  numerical instability, or moving-window-induced rotation. This evidence
  supports preserving the traveling-bend carrier and its feasibility guards.
- The assigned-parent/prefill sideslip-recovery policy is the best sampled
  scalar result: it captures at `0.749162L` and `25.9160T`, with mean distance
  `2.497592L` and score `-0.595593`. Its no-recovery baseline is duplicated in
  two independent runs at `0.749266L`, `25.9710T`, mean distance `2.498175L`,
  and score `-0.596086`. The edit improves arrival by only `0.0550T`, mean
  distance by `0.000583L`, and the `24T` distance by `0.01053L`, while both
  visual rows remain in the same route family and peak planar force/yaw moment
  rise slightly from `0.01885/0.01010` to `0.01902/0.01016`. This is a finite
  tie-break, not evidence for more sideslip gain or threshold tuning.
- The informative tradeoff sample captures more deeply at `0.748219L` but
  `0.0990T` later, with worse mean distance `2.501515L` and score `-0.599128`.
  Its top-down and oblique wake remain coherent, while its translational
  alignment is materially different: projected miss at `20/22/24T` is about
  `1.61/1.44/0.90L`, versus `2.85/2.13/1.06L` for the prefill. That sample
  changed several mechanisms together, so it does not identify a winning
  policy, but it does make body-frame translational line-of-sight direction a
  testable alternative to the prefill's middle-conflict suppression.
- Inherited logs already reject scalar strengthening of posterior vectoring,
  instantaneous force commutation, and transferring opposed anterior
  authority into the posterior joint. They also show that direct
  course/miss-triggered redirect improved upstream arrival but left a large
  middle projected miss. The unresolved question is therefore how to
  arbitrate the direct course request against a conflicting target-line
  response, not how to increase the carrier or redirect gains.

## Policy hypothesis

Preserve the prefilled carrier, course-triggered response-released redirect,
upstream and post-turn posterior vectoring, terminal modulation, coordinated
acceleration projection, and joint viability guards. Change exactly one
sensory-allocation mechanism in the existing `2.25--4.25L` conflict window:
when the recent target-line response requests the opposite side from the
observable translational course, blend its steering side toward an inertial
line-of-sight side computed from normalized body-frame target and velocity
geometry instead of merely silencing the residual. Retain the inherited
response-deficit magnitude and all closing, course-observability, distance,
angle-headroom, and conflict gates. Agreement, far travel, low speed,
non-closing motion, adequate response, and all non-navigation branches pass
through exactly.

The falsifiable expectation is to preserve the prefill's coherent, limit-free
capture and upstream progress while reducing the `20--24T` projected miss
enough to add capture margin or produce a meaningfully straighter middle
handoff. Reject the mechanism if capture is lost, arrival or mean distance
regresses without a useful route change, the alternating wake degrades, any
actuator contact returns, or peak planar force/yaw moment materially exceeds
the prefill's `0.01902/0.01016` envelope. A milliscale crossing-only change
would also reject this arbitration and leave slower course-response sensing as
the next mechanism family to test.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and elongated-body reactive propulsion
source_mechanism: preserve a propulsive traveling wave while slow target geometry selects steering direction and measured response determines whether residual authority is needed
transferable_invariant: separate route-side selection from rhythmic response magnitude, and arbitrate conflicting steering with normalized translational geometry rather than a clock or instantaneous load
nontransferable_details: published gains, dimensional frequencies, species envelopes, linkage geometry, exact vortex phases, fixed routes, and task-specific coordinates
policy_translation: body-frame target and velocity cross geometry supplies an inertial line-of-sight side that smoothly replaces only a conflicting recent-response side inside the existing closing middle-distance gate; two-joint gains and feasibility guards remain unchanged
falsification: reject on lost or slower capture without useful route separation, worse middle projected miss, incoherent propulsion, actuator contact, or force and yaw moment above the sampled parent regime

## Non-CFD implementation audit after the policy edit

- The candidate changes only the existing middle-conflict navigation
  allocation. It retains the prefill's 60-field parameter object and every
  direct `params.FIELD` reference resolves to an owned field. The public
  contract returns two finite accelerations for the prescribed state.
- A deterministic `18,225`-state grid spanning both lateral reflections,
  target distances `0.8--6L`, closing and non-closing motion, zero and finite
  translation, response-rate signs, and beyond-soft-limit joint states remains
  finite and within the `30 rad/T^2` policy envelope. The arbitration changes
  `156` grid states, an active conflict changes only joint 1 by
  `0.10057 rad/T^2`, far and response/course-agreement probes exactly reproduce
  the prefill, and paired reflections have zero numerical command error. This
  establishes bounded material activation and equivariance, not CFD benefit.
- The required check runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account. Its three exact checks were run directly: the
  material guidance/provenance check, lightweight Julia policy contract, and
  solver editable-boundary check all pass. No formal CFD was run.
