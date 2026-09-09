# Posterior-only joint-rate anti-windup candidate

## Pre-edit visual and metric diagnosis

- Every assigned solver rollout and the assigned parent's completed rollout
  satisfies the frozen contract: direct-uniform still-water initialization
  with `U_infinity=(0,0,0)`, no prewarm or cylinders, finite dynamics, and
  capture. I inspected the combined top-down and oblique sheets for the
  best-score plain route, the stress-gated moment residual, the sampled full
  anti-windup route, and the assigned parent's exact anti-windup replication.
  From release to capture, all form a coherent alternating caudal-vorticity
  street and compact body-led Lambda2 structures, follow the same shallow
  target-closing arc, and show no passive advection, wake breakup, boundary
  contact, collision, or instability. Body speed is `0.534--0.538U` near
  `4T`, while combined local-flow RMS is only about `0.0180--0.0182U`.
- The two assigned exact plain-policy rollouts capture at `18.6725T` and
  `18.7330T`, with mean distance `2.02018L` and `2.01959L`, posterior returned-
  action RMS `28.77` and `28.72 rad/T^2`, posterior acceleration-limit
  occupancy `75.46%` and `75.22%`, and force/moment RMS
  `0.01331--0.01335 / 0.00693--0.00695`. The stress-gated moment residual
  captures at `18.7440T`; its route, `28.77 rad/T^2` posterior action RMS,
  `75.47%` occupancy, and `0.01343/0.00699` loads do not separate from the
  plain-policy spread. This supports removing that residual, not retuning it.
- Exact full two-joint rate anti-windup now has three completed captures. The
  assigned sample reaches at `18.7000T` with posterior action RMS
  `28.24 rad/T^2` and occupancy `73.97%`; an inherited exact rollout reaches
  at `18.7825T` with `27.99 rad/T^2` and `72.24%`; and the assigned parent's
  post-worker exact replication reaches at `18.8210T` with
  `27.98 rad/T^2` and `72.03%`. Thus the posterior effort cleanup replicates
  below both plain-policy lower bounds while every rollout retains capture and
  wake coherence. The latter two repeats have mean distance
  `2.03157--2.03220L`, so neither faster capture nor unchanged route cost is
  established.
- The anterior part of that gate has no separated benefit. It returns zero on
  about `2.5%` of samples in the exact inherited repeats, yet anterior action
  RMS and acceleration occupancy (`24.53--24.61 rad/T^2`,
  `41.70--41.96%`) do not improve on the plain route's
  `24.70--24.73 rad/T^2`, `40.37--40.82%` envelope. The evidence therefore
  supports preserving posterior cleanup while removing the unsupported
  anterior intervention as the next mechanism-level isolation test.

## Pre-edit policy hypothesis

Produce exactly one candidate from the prefilled actuator-consistent policy.
Preserve its normalized body-frame bearing-plus-LOS-rate C-bend, traveling
two-joint carrier, response-reversing half-cycle asymmetry, persistent
same-side posterior phase recruitment, coefficient rotation, and
componentwise acceleration clamp. Add the physical `260 deg/T` joint-speed
limit to `target_policy_params`. At that observed boundary, suppress only a
posterior acceleration whose sign matches posterior joint velocity; preserve
full reverse braking. When the returned posterior command is zeroed, continued
raw same-side demand remains the phase-persistence witness and disappears as
soon as demand reverses. Leave the anterior command exactly on the evaluated
plain projection.

A later evaluation supports this decomposition if it retains capture and both
coherent wake views, remains within the inherited `18.6725--19.0520T` capture
band, keeps force/moment RMS at or below `0.01350/0.00703`, and again lowers
posterior returned-action RMS below `28.72 rad/T^2` or posterior acceleration-
limit occupancy below `75.22%`. The useful separation would be mean distance
closer to the plain `2.01959--2.02018L` envelope than the full gate's two
inherited repeats at `2.03157--2.03220L`, without losing posterior cleanup.
Falsify the decomposition on capture loss, wake weakening, impaired braking
or phase reversal, load growth, no posterior effort separation, or route cost
at least as large as the full gate; then retain full anti-windup only as a
feasible-command cleanup or restore the plain projection rather than tuning
the physical threshold. The candidate's CFD result occurs after this worker
exits and is not claimed here.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-lagged rhythmic carrier while observed actuator state removes only an infeasible command component
transferable_invariant: keep the directed traveling bend and route feedback primary; suppress same-direction acceleration only at the joint whose hard speed constraint shows a replicated effort benefit, while preserving reverse response
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, hardware-specific actuator models, and task routes
policy_translation: retain normalized body-frame LOS feedback and the two-joint state-feedback phase actuator; apply a reflection-equivariant signed acceleration-velocity gate only to the posterior command at the parameter-owned physical speed limit
falsification: reject if capture or either wake view is lost, braking or phase reversal changes, loads exceed the inherited envelope, posterior effort no longer separates, or removing the anterior gate does not reduce the full gate's route cost
