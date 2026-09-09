# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts are valid direct-uniform still-water episodes with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and capture termination.
  The sampled arrival band is narrow (`18.6725--18.7440T`), so small single-run
  timing or score differences are not evidence of a route improvement.
- The two exact actuator-consistent baseline instances capture at `18.6725T`
  and `18.7330T` despite sharing a policy hash. Their scores span
  `-0.13219-- -0.13142`, establishing at least `0.0605T` timing variation in
  the current sample. The inherited step-39 log is also a capture
  (`-0.13620`) but has no load history, so it supports semantic retention only.
- The joint-rate anti-windup variant captures at `18.7000T`, inside the exact
  baseline band. It reduces posterior action RMS from `28.72--28.77` to
  `28.24 rad/T^2`, acceleration-limit occupancy from `75.2--75.5%` to `74.0%`,
  and sampled outward-at-rate-limit rows from about `239--249` to `32`.
  Force/moment RMS (`0.01333/0.00694`) overlaps the baseline
  (`0.01331--0.01335/0.00693--0.00695`), so this is evidence for command
  feasibility, not faster capture or lower hydrodynamic load.
- The stress-gated moment residual captures later at `18.7440T`, has the worst
  sampled mean distance (`2.02198L`), and raises posterior action RMS and load
  to `28.77 rad/T^2` and `0.01343/0.00699`. It supplies no positive evidence
  for another instantaneous hydrodynamic residual.

## Visual diagnosis

The combined top-down and oblique sheets for the best-scoring exact baseline,
the stress-gated residual, and the rate anti-windup variant all show body-led
translation away from a quiescent release. A coherent alternating vorticity
street develops by `4T`, remains organized through the target-directed route,
and has corresponding three-dimensional Lambda2 structures at `12T`, `16T`,
and capture. The traces are self-propelled rather than advected: local-flow RMS
is only `0.01804--0.01816U`, and the background is zero. None shows wake
collapse, wasteful lateral blow-up, a late loop, boundary approach, or an
obvious trajectory-topology separation. The moment residual's visually
indistinguishable but slightly longer route agrees with its distance and load
metrics. The anti-windup sheet retains the same productive wake while its
command history removes most outward action at the rate boundary.

## Policy hypothesis

Preserve the evaluated body-frame bearing/LOS-rate C-bend, response-reversing
half-cycle asymmetry, actuator-consistent posterior phase recruitment, and
acceleration clamp. Replace the discontinuous exact-boundary feasibility test
with a prospective, one-sided projection: when an acceleration points in the
same direction as joint velocity, cap it by the remaining normalized
joint-rate headroom divided by one maximum solver update. Leave reverse
acceleration untouched so braking and traveling-wave phase remain available.
When projection makes the previous feasible action small or zero, retain the
existing persistent same-side phase semantics with the current raw demand as
the witness; otherwise the feasibility layer would silently disable the
evaluated steering mechanism near the rate limit.

This is one new controller mechanism, not scalar gain tuning. It should retain
capture and wake topology while reducing outward-at-rate-limit returns and
posterior effort beyond exact-boundary anti-windup. Reject it if it leaves the
`18.6725--19.0520T` inherited capture band, exceeds `2.02129L` mean distance or
`0.01350/0.00703` force/moment RMS, alters reverse braking or phase recruitment,
or fails to improve command feasibility relative to exact-boundary anti-windup.

bookshelf_consulted: true
source_domain: classical reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-lagged traveling bend while feedback modulates a bounded residual instead of replacing the rhythmic coordination
transferable_invariant: keep the productive traveling-wave and route-feedback structure intact while a reflection-equivariant feasibility allocator limits only outward acceleration that would exhaust observed joint-rate headroom
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame target and LOS-rate feedback; use joint velocity divided by its owned limit and acceleration divided by its owned limit to project one-update outward demand, preserve reverse braking, and preserve persistent raw-demand phase recruitment
falsification: reject if capture or the coherent alternating wake is lost, if route or force/moment bounds are exceeded, or if command feasibility does not separate from exact-boundary anti-windup
