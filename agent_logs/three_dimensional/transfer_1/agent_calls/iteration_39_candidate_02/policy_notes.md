# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no cylinders, stable dynamics, and capture. The three
  exact-byte speed-reserve samples (`567de3...`) capture at
  `0.74846--0.74953L` and `18.2875--18.6010T`; their head/tail action-clamp
  fractions are `68.46--68.48%/70.62--71.00%`, speed-limit residence is
  `10.47--10.58%/11.41--11.58%`, and peak body-force/moment coefficients stay
  near `0.0147/0.0292/0.0163`.
- The combined keyframes for the repeat-backed sample and the best-score
  outer-bearing sample show self-propulsion rather than background advection:
  a persistent alternating top-down wake develops from release through target
  crossing, while the oblique row retains bilateral 3D structures and an
  active traveling body bend. There is no visible terminal carrier collapse.
  The current visual sample contains no failed rollout, so no visual claim is
  assigned to the inherited lower exits.
- The best scalar sample (`3265a7...`, score `-0.14991`) adds an unsupported-
  bearing qualifier and captures at `18.6560T`, but inherited guidance records
  its exact-policy repeat exiting below after a `1.18462L` pass. That `1/2`
  result rejects retuning or stacking the bearing cue even though its wake and
  load envelope remained compatible.
- Inherited scores retain three distinct lower-exit negatives at minima
  `1.18462L`, `1.16080L`, and `1.67826L`, followed by a score-only step-38
  capture at `0.74605L`. The latter restores a success class but ships neither
  policy bytes nor wake/actuator diagnostics here, so it cannot identify a
  transferable mechanism.
- The deployed adapter exposes normalized target and velocity geometry,
  instantaneous/short-window bearing rate, heading response, joint state, and
  previous action. It does not expose `window_closing_speed_L`; the earlier
  progress-loss candidate therefore used a noisy one-step fallback and acted
  only after its closest pass. In the current capture traces the outer
  approach already develops the relevant response mismatch: around the first
  `2.75L` crossing, inertial line-of-sight rate is approximately
  `-0.118` to `-0.071 rad/T`, then its magnitude grows as the pass develops while
  the carrier remains active.

## One policy hypothesis

Preserve the exact speed-reserve traveling bend, achieved-course error,
intercept release guard, and steering allocation. Add one smooth response
primitive: a bounded line-of-sight-rate lead to the route error after `4L`,
fully active across the outer `2.75--2.0L` approach, and faded to exactly zero
by `1.25L`. This uses only body-frame target/velocity cross products already
normalized by distance. It is intended to advance the correct-sign turn before
the inherited lower branch separates, without changing far-field closure or
injecting terminal/post-pass mean curvature.

An offline observation-only gate audit on the four sampled captures gives a
`+0.038--+0.058 rad` lead at their first `2.75L` crossings, the same sign as
the achieved-course correction there. The new term is capped at `0.10 rad`
against the existing `1.25 rad` route-error bound and is identically zero in
the sampled far field and below `1.25L`; this audit checks selectivity only and
does not predict the new CFD trajectory.

Falsify the mechanism if CFD loses capture, fails to reduce projected miss by
the first `2L` crossing, changes far-field closure, weakens either wake, or
moves clipping, joint-speed residence, force, or moment materially outside the
repeat-backed envelope. Because the lead vanishes before capture, also reject
it if it merely changes the terminal phase without improving repeated semantic
reliability.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and biological burst-and-release turning
source_mechanism: modulate a continuing propulsive rhythm with bounded observed directional-response feedback, then release the redirect as the response becomes useful
transferable_invariant: correct trajectory with an observed body-frame response rate while preserving the traveling propulsive wave
nontransferable_details: published gains, robot or species kinematics, exact beat or vortex phase, dimensional timing, and task-specific routes
policy_translation: add one bounded inertial line-of-sight-rate lead to the two-joint steering request only in the outer approach; leave the state-feedback carrier and posterior lag unchanged and fade the lead before capture
falsification: reject if projected miss is not smaller before 2L, capture is lost, the same lower-exit topology remains, either wake weakens, or the repeat-backed actuator/load envelope worsens
