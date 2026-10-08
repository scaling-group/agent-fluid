# Candidate diagnosis and hypothesis

## Sampled evidence

- The assigned v37 response-exclusive parent is reproduced byte-for-byte by
  `solver_2e5f75fa166c`, `solver_bde126f356f9`, and
  `solver_1386c589f598`. All three capture at `19.612991 T` with score
  `-0.28294122`, mean distance `2.17243510 L`, and final distance
  `0.74866050 L`; this is a reproducible baseline rather than solver noise.
- The distinct v38 course-supported selector (`solver_7cbc056ed78d`) also
  captures and improves score to `-0.27158268`, mean distance to
  `2.16212422 L`, and final distance to `0.74727231 L`, although crossing is
  later at `19.998001 T`. It reaches `4 L` slightly earlier (`15.61451 T`
  versus `15.66401 T`) but crosses `3/2/1 L` progressively later, so the
  trade is a better distance integral and realized approach state, not a
  uniformly faster trajectory.
- Both combined keyframe sheets use direct uniform still-water initialization.
  Their top-down rows show self-propelled compact target arcs with coherent
  alternating vortex shedding through capture; neither shows passive
  advection, a wake break, a loop, or domain escape. Their oblique rows show
  finite body-attached and shed Lambda2 structures rather than a diffuse or
  unstable volume. The v38 final body is visibly on a different, lower-load
  approach state, while the overall wake topology remains useful.
- The trace confirms that visual diagnosis. Relative to v37, v38 reduces
  below-`4 L` `|action|>30 rad/T^2` counts from `508/589` to `322/390`,
  reduces below-`4 L` lateral-force/yaw-moment maxima from about
  `0.02692/0.01519` to `0.02485/0.01384`, and ends at commands
  `-1.632/3.963 rad/T^2` and yaw rate `0.649 rad/T` rather than
  `5.364/30.543 rad/T^2` and `2.858 rad/T`. The countervailing evidence is
  slightly larger global force/moment maxima (`0.02906/0.01678` versus
  `0.02717/0.01558`) and anterior excursion to `0.7378 rad`, close to the
  `45 deg` physical envelope. Thus course-triggered allocation is useful, but
  continuing to spend steering priority after radial response is established
  has limited margin.

## Candidate hypothesis

Start from the sampled v38 winner and preserve its traveling-bend carrier,
target residual, course-miss onset, exclusive allocation budget, and terminal
law. Add one response-release mechanism to the outer course selector: compare
the directly observed, short-window range closure with body-center course
speed in the same normalized `L/T` units. Severe course miss may transfer the
existing allocation from posterior-response support to the target residual
while closure efficiency is poor; as closure becomes a large fraction of
translation speed, continuously return that allocation to the original
response-exclusive partition. This changes priority only, adds no acceleration
authority, remains exactly dormant at and below the existing `4 L` outer
gate, and uses no clock, route, target identity, or world coordinate.

Expected result: retain v38's improved distance integral, coherent two-view
wake, capture, and quiet realized approach while preventing marginal course
correction from consuming anterior excursion after the route begins closing
efficiently; a modest recovery of the `3/2/1 L` crossing delay would support
the mechanism. Reject it if the release is dormant, capture or mean distance
regresses, the early compact arc changes adversely, the alternating wake or
finite oblique structures degrade, anterior angle/rate contact or global loads
grow, or terminal commands/yaw return toward v37.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: apply a bounded redirect for large observed route error and release it toward propulsion when measured directional response appears
transferable_invariant: steering allocation should depend on both target-relative error and achieved response, with continuous release rather than persistent asymmetry
nontransferable_details: species-specific C-start shapes, published CPG gains and frequencies, exact tail phases, full-body envelopes, and prescribed paths
policy_translation: use body-frame course miss to request the existing exclusive target-residual priority, then use normalized observed range closure over body-center speed to release that priority without changing its authority ceiling
falsification: reject on dormant activation, worse capture or distance integral, changed useful path, increased envelope contact or loads, lost wake coherence, or renewed high-action terminal yaw
