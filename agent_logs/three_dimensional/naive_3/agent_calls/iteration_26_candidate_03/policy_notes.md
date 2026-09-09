# Terminal response-bridge candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected the combined and view-specific keyframe sheets for the strongest
  finite sample (`solver_951085a20092`) and the assigned-parent prefill failure
  (`solver_17c80feba915`), including both top-down mid-plane vorticity and
  oblique body/Lambda2 views, and checked all four observations, metrics,
  diagnostics, traces, policies, and inherited optimizer notes.
- Every fish self-propels from rest and retains a coherent alternating planar
  street with compact three-dimensional wake structures through repeated
  target passes. Passive advection, wake collapse, collision, domain exit, and
  instability do not explain the misses. The assigned parent's response-based
  carrier contraction visibly retains the broad powered loop and reaches only
  `2.484/4.544/4.673L` minimum/mean/final distance; the response-held C-turn
  and posterior-counterbend samples similarly remain outside `2L` at
  `2.377L` and `2.249L` minima.
- The course-response curvature reserve is a semantic improvement rather than
  a scalar fluctuation. It preserves horizon survival and coherent propulsion,
  improves minimum/mean/final distance to `1.314/4.056/3.077L`, and changes the
  response-held orbit's repeated passes from `2.377L` to about `1.616`,
  `1.314`, and `1.344L`. Its total anterior/posterior acceleration-clamp
  residence is about `0.249/0.103`, versus `0.727/0.101` for the response-held
  scaffold, so the smaller orbit is not purchased by more command-limit use.
- The remaining failure is terminal course geometry. Inside `2L`, speed remains
  about `0.663U`, mean target-ray/course dot product is `-0.089`, and `57.5%`
  of states are receding. At the first new `1.616L` pass, the normalized target
  is almost purely lateral but barely ahead (`target_unit=(0.011,1.000)` in the
  policy's body coordinates), course error is `1.237 rad`, and the existing
  response reserve is effectively off because the target-behind selector has
  released. At the later `1.314L` minimum the target is behind/lateral,
  course error is `1.672 rad`, and the reserve is active, but the course is
  already slightly receding. This exposes a response-release gap, not a need
  for another global drive gain.

## Policy hypothesis

Use `solver_951085a20092` as the scaffold and preserve its oscillator,
far-field bearing curvature, target-behind C-turn, posterior brake, joint-state
phase modulation, response-selected same-sign curvature reserve, and command
reserve. Add one compact terminal response bridge: only inside the newly
evidenced sub-`2L` regime, while the target ray is strongly lateral and the
target-ray/course error remains large, continue the same bounded equilibrium
reserve across the barely-ahead side of the target-behind selector. The bridge
vanishes once course alignment appears, once the target is already behind and
the sampled response reserve owns recovery, or outside the terminal radius.
It adds no clock, route, hidden maneuver state, or world-frame command and is
reflection equivariant.

Expected evidence is an unchanged coherent release and first `2.377L` pass,
followed by an inward course through the `0.75L` capture radius or a materially
smaller/recovering terminal pass with comparable clamp and load residence.
Reject the mechanism if cruise or the first pass changes materially, the wake
stalls or curls tightly, limits or loads rise, or the same `1.3--1.7L` powered
orbit persists without capture or inward recovery.

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: hold bounded target-relative curvature until measured translational response, rather than target-side geometry alone, supports release into the propulsive rhythm
transferable_invariant: a strong redirect should release on observed course alignment; a large still-lateral target/course error can retain bounded turn authority while the propulsive traveling wave remains intact
nontransferable_details: species-specific C-start stages, published gains, dimensional beat frequencies, full-body kinematics, exact vortex phase, capture radius, target coordinates, and prescribed routes
policy_translation: normalized body-frame target direction, target-ray/course error, distance, speed, and the existing target-behind response select a bounded two-joint equilibrium reserve across only the terminal barely-ahead release gap
falsification: reject if far-field progress or first-pass geometry changes, wake coherence is lost, clamp/load residence rises, a tight curl appears, or the sub-2L noncapturing orbit remains without inward recovery
```

## Evaluation boundary

The new coupled CFD rollout occurs only after this worker exits. Trace replay
and dry controller checks below can establish selector locality, action scale,
reflection equivariance, finiteness, bounds, and parameter ownership, but not
hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed course-response reserve policy and
adds six owned terminal-bridge parameters. The new selector is the product of
a sharp sub-`2L` distance envelope, normalized lateral target geometry,
target-ray/course mismatch, finite-speed authority, and the complement of the
existing target-behind selector. It adds the already bounded `8 deg` response
reserve to both joint equilibria without changing the oscillator or traveling
wave envelope. As the target moves behind, the bridge vanishes and the sampled
response reserve resumes exact ownership.

Counterfactual selector replay on the completed `solver_951085a20092` trace is
zero to displayed precision through both `2T` and `12T`. At the original
`2.377L` first pass it requests only `0.043 deg`; at the newly evidenced
`1.616L` barely-ahead/lateral pass it requests `3.000 deg`; and at the later
`1.314L` behind-target minimum it is zero while the sampled reserve remains
active. Its trace-wide maximum is `3.168 deg` near `1.617L`. Direct policy
replay changes the first-pass action by only about
`(-0.10,-0.12) rad/T^2`, changes the terminal-pass posterior action from
`-11.28` to `-19.67 rad/T^2` while leaving the already-clamped anterior action
at `28`, and is numerically unchanged at the behind-target minimum. These are
frozen-state controller probes, not an integrated trajectory prediction.

All direct parameter references are returned by `target_policy_params()`.
Mirrored target, velocity, joint, bearing, and yaw states return exactly
negated actions; stopped, zero-target, and large finite probes remain finite
and bounded by the declared `+/-28 rad/T^2` reserve. Formal CFD was not run.
