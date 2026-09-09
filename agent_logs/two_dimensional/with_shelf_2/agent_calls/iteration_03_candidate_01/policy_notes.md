# Multi-wake target-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet confirms the common held release at the upper-right
  boundary and the same developed, interacting four-cylinder wakes for every
  policy. It is initial-condition evidence, not candidate-specific credit.
- The assigned parent `solver_ab5b90e78e2b` preserves seed propulsion and
  applies bearing feedback only through posterior tail-tangent half-cycle
  asymmetry. Its keyframes remain a steep, almost monotone descent outside the
  useful target corridor: it exits the lower boundary after `52.536`, moves
  only `-4.240L` upstream while falling `-13.366L`, and never comes closer than
  `9.294L`. Both joints still hit the velocity and acceleration caps. Thus the
  posterior-only mechanism did not create route-level steering or actuator
  headroom.
- The opposite-sign, milder posterior variant `solver_785c44ad57e0` has the
  same lower-exit topology and nearly the same `-13.291L` vertical loss. Its
  better `8.203L` closest approach and `-4.557L` upstream displacement are too
  small to support more posterior sign or gain tuning; both variants remain
  saturated and semantically close to the seed.
- `solver_928f830d4c45` is the strongest finite sampled trajectory and a
  materially different failure. Its bounded anterior-plus-posterior
  acceleration half-cycle asymmetry survives `91.245`, advances `-9.726L`
  upstream, and reaches `4.621L` minimum distance with command-energy mean
  `853.184` rather than the seed's `1496.247`. The sheet shows a real diagonal
  approach into the wake region, followed by continued downward passage and
  lower-boundary exit. Its `-13.313L` vertical displacement and moment RMS
  `3430.21` show that proportional bearing alone reacts too late or with too
  little damping once cross-track/yaw error accumulates; the useful upstream
  leg is not yet controlled capture.

## Policy hypothesis

Use the semantically useful sampled acceleration-asymmetry scaffold, including
its zero-centered joint-state oscillator, posterior lag, and candidate-owned
soft acceleration ceiling. Make one feedback-structure change: form the
half-cycle turn request from a bounded lead bearing equal to current
body-frame bearing plus its observed window-rate projected over a fraction of
one owned control period. A growing bearing error therefore receives earlier
correction, while a bearing already moving toward zero automatically sheds
steering authority. Both zero bearing and zero bearing trend recover the
symmetric traveling bend, and no fixed curvature, clock, route, or vortex
phase is introduced.

Expected evidence is preservation of the sampled upstream leg and survival,
but with substantially less than `13.3L` downward displacement, a closest
approach below `4.621L`, and no increase in cap occupancy or moment load.
Falsify the mechanism if the trajectory returns to the short seed/parent
lower exit, if the lead term causes alternating oversteer or chatter, if
upstream progress collapses, or if moment RMS remains extreme without a
meaningfully better target approach.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and state-gated redirect maneuvers
source_mechanism: sensor-error trend modulates the useful locomotor half-cycle so steering anticipates persistent directional divergence while retaining the propulsive rhythm
transferable_invariant: a bounded combination of current body-frame direction error and its observed trend can bias rhythmic actuation earlier than proportional error alone without moving the oscillator equilibrium
nontransferable_details: published controller gains, robot or species geometry, dimensional beat frequencies, prescribed CPG phase, exact vortex timing, and task-specific coordinates or routes
policy_translation: preserve the sampled zero-centered state oscillator and lagged posterior target; project bearing_window_rate over an owned fraction of one control period, bound the resulting lead bearing, use it to select acceleration half-cycle asymmetry, and retain the existing smooth acceleration limit
falsification: reject if the upstream approach is lost, downward displacement and closest approach do not improve, the rate term creates rapid sign switching, or loads remain extreme without semantic trajectory improvement
