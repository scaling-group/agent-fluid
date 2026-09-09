# Joint-rate anti-windup replication candidate

## Pre-edit visual and metric diagnosis

- All four sampled evaluations satisfy the frozen initialization contract:
  direct-uniform still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and capture at `18.6560--18.7330T`. I inspected
  both rows of every combined sheet. From release through capture, the
  top-down views show a shallow, continuously corrected route with a coherent
  alternating caudal wake; the oblique Lambda2 views show the same body-led
  three-dimensional vortex train without wake breakup, boundary contact, or
  passive advection. Body speed is `0.534--0.536U` near `4T`, whereas local-
  flow RMS is only `0.01804--0.01816U`.
- The two exact actuator-consistent reference rollouts capture at
  `18.6725T` and `18.7330T`, with mean distance `2.02018L` and `2.01959L`.
  Posterior returned-action RMS is `28.77` and `28.72 rad/T^2`, posterior
  acceleration-limit occupancy is `75.46%` and `75.22%`, and force/moment RMS
  is `0.01331--0.01335 / 0.00693--0.00695`.
- The helpful-moment allocation is the informative mechanism failure: its
  nominally faster `18.6560T` capture does not separate from the reference
  timing spread, while mean distance worsens to `2.02115L` and posterior RMS
  and occupancy rise to `28.77 rad/T^2` and `75.77%`. Its wake sheets are
  visually indistinguishable from the exact route. This agrees with the
  inherited log's stress-gated moment negative and rules out another nested
  instantaneous-moment allocator or scalar retune.
- The sampled joint-rate anti-windup preserves the same wake and captures at
  `18.7000T` with mean distance `2.02103L` and force/moment RMS
  `0.01333/0.00694`. It alone separates posterior returned effort:
  `28.24 rad/T^2` action RMS and `73.97%` acceleration-limit occupancy. Zero
  return replaces infeasible outward acceleration on `6.38%` of all posterior
  samples while reverse braking is retained. Its `2.44%` anterior zero-return
  exposure does not separate anterior RMS or occupancy from the exact route,
  so the supported claim is posterior feasible-command cleanup without route
  or load improvement.

## Pre-edit policy hypothesis

Produce one candidate by exactly restoring the sampled reflection-equivariant,
one-sided joint-rate anti-windup mechanism on the inherited actuator-consistent
route. Preserve the normalized body-frame bearing-plus-LOS-rate C-bend,
traveling two-joint carrier, response-reversing half-cycle asymmetry,
persistent same-side posterior phase recruitment, coefficient-norm-preserving
phase rotation, and acceleration clamp. Add the physical `260 deg/T` speed
limit to `target_policy_params`; at that observed boundary, return zero only
when acceleration would increase the magnitude of joint velocity, retaining
the full opposite-sign command for braking. Preserve the phase-persistence
witness during a zeroed posterior outward command and release it as soon as
raw demand reverses.

This is a replication test, not a gain change. A later evaluation supports the
candidate only if it captures within the inherited `18.6725--19.0520T` route
band with mean distance no greater than `2.02129L`, coherent wakes in both
views, and force/moment RMS no greater than `0.01350/0.00703`, while again
placing posterior returned-action RMS below `28.72 rad/T^2` or acceleration-
limit occupancy below `75.19%`. Falsify the mechanism on route loss or delay,
wake weakening, load growth, impaired braking/phase reversal, or failure to
repeat the effort separation. If falsified, restore the plain feasible-action
projection; test posterior-only anti-windup as a distinct architecture before
changing the observed physical speed boundary.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-lagged rhythmic carrier while observed joint state prevents a command from winding farther into an active actuator constraint
transferable_invariant: keep the directed traveling bend primary and suppress only same-direction acceleration at a hard joint-speed boundary while preserving reverse braking
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, hardware-specific actuator models, and task routes
policy_translation: retain normalized body-frame LOS route feedback and the two-joint state-feedback phase actuator, then project each acceleration using observed joint velocity and a parameter-owned speed limit under a reflection-invariant signed-product test
falsification: reject if an exact repeat loses capture or route quality, weakens either wake view, impairs reversal, exceeds the inherited load envelope, or fails to separate posterior returned effort from the plain actuator-consistent route
