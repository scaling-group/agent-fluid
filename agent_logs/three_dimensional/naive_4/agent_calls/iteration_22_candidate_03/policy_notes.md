# Wake-policy diagnosis and candidate hypothesis

## Evidence read before editing

- All four sampled episodes satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no prewarm or cylinders, finite dynamics, and capture
  at `16.05437T` after 2,919 steps and 239 moving-window shifts. There is no
  failure-class sheet in this allocation, so the useful contrast is among
  distinct terminal feedback laws rather than against an instability or exit.
- I inspected every combined sheet, including both the top-down vorticity row
  and oblique body/Lambda2 row. The fish self-propels on the same smooth
  target-directed arc while forming a coherent alternating wake; the oblique
  structures remain compact through approach. There is no visible passive
  advection, reciprocal standing wiggle, wake breakup, boundary contact, or
  out-of-plane instability. The established oscillator, traveling posterior
  bend, cruise route, and base steering sign should therefore remain intact.
- Two copies of the assigned-parent alignment-turnaround release reproduce
  final distance `0.746212L`, distance integral `1.930147L`, score
  `-0.047281`, and the same two-view sheet. Extending that response into a
  redirect-to-cruise handoff improves the crossing to `0.746070L`, the
  integral to `1.930028L`, and score to `-0.047133` without changing arrival,
  shifts, extrema, hard-limit residence, or force/moment peaks. The strongest
  finite sample instead adds corridor-confined measured-yaw damping and reaches
  `0.746051L`, `1.930012L`, and `-0.047113`, also at the same arrival and with
  unchanged reported extrema and peaks.
- The sampled-state reconstruction separates their supports. Handoff begins
  at `0.842L` and its small-bearing gate peaks before falling to zero when
  bearing leaves the `0.18 rad` cone. Yaw damping becomes material near
  `0.819L`, grows with the safe closing corridor, and remains active at the
  crossing. The two mechanisms overlap but act as an early authority handoff
  followed by a later response brake; this is more specific than assuming
  that two small scalar improvements will add.
- The inherited negative control remains binding: an older active terminal
  counter-curvature law regressed to final distance `0.746960L` and score
  `-0.048061`. The new combination must therefore preserve target-directed
  bend, restrict both roles to the evidenced turnaround/corridor response, and
  must not become a general reverse-turn command.

## One candidate

Start from the strongest sampled yaw-damped controller and add the separately
positive alignment-conditioned handoff of only the high-authority redirect
increment toward the existing cruise curvature. The handoff never reverses
the requested turn and naturally releases outside the small alignment cone;
the smaller active yaw brake remains confined to a reliable closing intercept
and opposes only measured target-signed yaw while alignment is reopening. The
anterior oscillator, posterior traveling wave, base redirect direction, wave
relief, acceleration allocator, and exact-boundary projection are unchanged.

Expected test: retain capture at the same step, the `8/6/4/2/1.25L`
milestones, 239 shifts, and coherent two-view wake, while improving crossing
distance or distance integral beyond the best sampled `-0.047113` result.
Reject the combination if the two terminal roles over-relieve one another,
delay or lose capture, change a pre-terminal milestone, increase limiting or
load peaks materially, disrupt the wake, or fail to improve terminal geometry.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and biological terminal capture control
source_mechanism: preserve a rhythmic propulsive carrier while measured approach response hands excess steering to a lower-authority mode and applies bounded endpoint yaw damping
transferable_invariant: separate productive periodic propulsion and target-directed bend from continuously gated terminal response correction; reduce excess authority before opposing only measured residual over-turn
nontransferable_details: published gains, clock-driven CPG phase, species-specific kinematics, dimensional frequencies, exact vortex phases, morphology, and source-task routes
policy_translation: use normalized body-frame bearing and bearing rate to hand the redirect increment toward cruise inside a closing alignment cone, then use target-relative closing, predicted miss, and normalized measured yaw to subtract a bounded posterior mean bend without changing the two-joint carrier
falsification: reject if cruise milestones or wake coherence change, capture regresses, either role persists under large unresolved target error or an unsafe intercept, or terminal distance and actuator/load evidence do not improve over the sampled yaw-damped controller

## Pre-evaluation verification

- The mandated guidance/provenance, lightweight Julia policy-contract, and
  solver-boundary checks all pass. The configured check-runner was invoked,
  but its pinned `gpt-5.4-mini` model is unavailable for this account, so the
  three prescribed commands were run directly and separately. No CFD ran.
- The deterministic schema guard finds all 47 direct `params.FIELD`
  references in the 47-field return of `target_policy_params()`.
- On the strongest sampled controller's 2,919 reconstructed observation
  states, the added handoff changes seven posterior commands, only from
  `0.848L` through `0.752L`; the later crossing commands remain those of the
  sampled yaw brake. The largest logged-state difference is bounded at
  `4.351 rad/T^2`. This verifies distinct, staged feasible-action support, not
  the unevaluated closed-loop outcome.
- Ten thousand deterministic paired body-frame states return finite bounded
  accelerations and equal-and-opposite commands under lateral reflection to
  numerical tolerance. A non-finite-observation fallback also remains finite.
