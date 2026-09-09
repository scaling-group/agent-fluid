# Phase-demodulated response robustness candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture at `18.6560--18.7440T`. The combined sheets for the
  best-score sample and the weakest-score phase-demodulated sample were read
  from release through termination, with the assigned prefill checked as a
  third comparison. Their top-down rows show body-led translation and a
  coherent alternating posterior vortex street; their oblique rows show
  compact three-dimensional Lambda2 structures shed behind the swimmer. None
  shows passive advection, wasteful growing lateral oscillation, wake collapse,
  collision, exit, or instability. The trajectory/diagnostic records and low
  local-flow RMS (`0.01807--0.01815U`) agree with that visual diagnosis.
- The assigned prefill's stress-gated raw-moment residual captures at
  `18.7440T`, score `-0.13364`, and mean distance `2.02198L`, with action RMS
  `24.872/28.767 rad/T^2`, anterior/posterior limit occupancy
  `41.46%/75.44%`, and force/moment RMS `0.013430/0.006994`. Helpful raw-moment
  amplitude relief is the best scalar sample at `18.6560T` and `-0.13321`, but
  its `0.0165T` lead over the fastest actuator-consistent parent lies far
  inside the inherited `0.3355T` identical-hash timing spread; its posterior
  occupancy remains `75.77%`.
- The phase-demodulated moment residual is the only current sample with a
  material actuator/load change while preserving the route: it captures at
  `18.7165T`, inside the inherited `18.6725--19.0080T` parent band, while
  lowering action RMS to `24.461/28.558 rad/T^2`, posterior occupancy to
  `74.14%`, and force/moment RMS to `0.013093/0.006816`. Its score
  `-0.13525` and mean distance `2.02337L` are slightly worse than the assigned
  prefill, so the evidence supports efficient residual allocation, not faster
  arrival or a better route.
- Inherited logs explain the separation: raw yaw moment is carrier dominated
  (about `0.842` correlation with anterior angle). Subtracting the stable
  reflection-odd joint-phase estimate leaves about `0.0024` RMS residual and
  only `0.234--0.237` next-sample yaw-acceleration correlation. The completed
  result supports letting that residual make a small bounded adjustment to an
  already successful phase actuator; it does not support giving moment the
  slow LOS route or replacing posterior phase authority.

## Policy hypothesis recorded before editing

Replicate the sampled phase-demodulated architecture exactly. Preserve the
normalized body-frame LOS route loop, recoil-conditioned yaw error,
response-reversing half-cycle asymmetry, continuous distributed C-bend,
state-feedback traveling carrier, persistent same-side actuator-consistent
phase gate, and physical acceleration projection. Estimate the self-generated
carrier component of normalized yaw moment from observed odd joint phase,
then let only the bounded residual adjust posterior phase recruitment by at
most the sampled small fraction. At zero residual or zero yaw demand the
evaluated parent path is recovered. The residual/response product is even
under reflection, while all joint, geometry, and command signals reverse
consistently; no clock, memory, world coordinate, range switch, or fixed route
is introduced.

This candidate tests robustness of the observed load reduction, not a new CFD
claim. Support requires capture with both wake views coherent, arrival inside
the replicated `18.6725--19.0080T` parent band, posterior occupancy below
`75.0%`, and force/moment RMS no greater than `0.01320/0.00690`. Falsify the
mechanism if capture is lost, arrival leaves that band, wake coherence breaks,
posterior occupancy returns to the parent's `75.4--76.1%` band, or the load
reduction does not repeat. Do not infer disturbed-flow rejection from this
quiescent-water result.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-feedback modulation of rhythmic robotic-fish control
source_mechanism: separate slow target-directed steering from a small measured fast-response residual while preserving the propulsive rhythm
transferable_invariant: remove the predictable self-generated carrier from a physical-response cue and let only the bounded innovation modulate residual authority around an already successful route loop
nontransferable_details: published gains, robot or species kinematics, dimensional frequency, exact vortex phase, organized-wake synchronization, and task-specific routes
policy_translation: form a reflection-odd carrier estimate from normalized observed two-joint phase, subtract it from normalized yaw moment, and use the even residual/request alignment only as a small multiplier on posterior phase recruitment
falsification: reject if capture leaves 18.6725--19.0080T, either wake view degrades, posterior occupancy is at least 75.0%, force/moment RMS exceeds 0.01320/0.00690, or the apparent load reduction fails to replicate

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
