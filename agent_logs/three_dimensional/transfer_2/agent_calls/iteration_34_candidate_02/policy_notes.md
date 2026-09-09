# Rate-aware phase-space oscillator candidate

## Visual diagnosis before editing

- All four sampled solver episodes and the assigned-parent rollout satisfy the
  frozen contract: direct uniform `U_infinity=(0,0,0)` initialization, no
  cylinders or prewarm, finite moving-window transport, stable dynamics, and
  `capture`. There is no failed termination in this evidence set, so the useful
  contrast is mechanism cost and repeat-supported trajectory behavior.
- I inspected both rows of the combined sheets from release through capture for
  the strongest finite sample `solver_1d05d22ea1fe`, the lowest-score sampled
  capture `solver_0e82a9e35a2a`, and the newly completed assigned-parent
  `solver_6584247dddea`. In every top-down row the fish starts in blank still
  water, self-propels along a shallow target-directed arc, and sheds a coherent
  alternating caudal wake. The oblique rows retain compact three-dimensional
  Lambda2 structures behind the caudal region. None shows advection, collision,
  domain exit, unproductive flailing, wake collapse, or numerical instability.
  The traveling carrier and target scaffold should therefore be preserved.
- The assigned parent changes the interpretation of the earlier range handoff.
  Four byte-identical range-specific carrier-coupling runs now span
  `15.939--16.170T`, distance integral `1.82008--1.82951L`, path
  `13.107--13.142L`, and score `0.05319--0.06189`. Two byte-identical global
  response-release runs span `16.071--16.088T`, `1.82203--1.82366L`,
  `13.129--13.166L`, and `0.05893--0.06072`. Thus neither handoff has a
  repeat-resolved timing/integral advantage; this candidate retains the
  prefilled global release rather than stacking an unconfirmed regime change.
- The inherited response-gated half-cycle result also fails its stated actuator
  objective. It captured at `16.022T/1.82375L`, with coherent wake, path
  `13.144L`, and peak planar-force/yaw-moment coefficients
  `0.03456/0.01707`, but anterior/posterior residence above 90% rate was
  `17.71/8.07%`, not better than the range-controller repeats'
  `17.49--17.70/7.82--8.25%`, and mean command remained
  `16.65/15.38 rad/T^2`. Do not reuse yaw-response gating of half-cycle
  asymmetry as a rate-control mechanism on this release.
- The remaining actuator defect is far-field and belongs to the oscillator
  orbit. In the prefilled global-release sample, distance at least `6L`
  accounts for anterior/posterior residence above 90% rate of
  `26.09/11.66%` and above 99% of `18.45/2.15%`; both joints have zero such
  residence inside `4L`. Moreover, the nominal anterior rate `omega*A` is
  about `5.58 rad/T`, or `123%` of the `4.54 rad/T` rate envelope. The current
  van der Pol pump senses normalized angle but not this measured rate demand.

## One-candidate policy hypothesis

Keep the prefilled corrected-sign body-frame target vector, distance/closing
drive relief, velocity-course redirect, joint-phase steering, posterior
allocation, target-conditioned carrier decomposition, response-released
reversal, action bounds, and public two-joint contract. Change only the
anterior oscillator's energy coordinate: replace its angle-only van der Pol
pump with a normalized phase-space orbit energy
`(angle/amplitude)^2 + (joint_rate/rate_envelope)^2`, for both the exact raw
drive and its zero-mean carrier decomposition. This remains clock-free joint
state feedback. It preserves pumping inside the feasible orbit, stops adding
energy at its boundary, and supplies smooth damping only after measured state
leaves it; the existing late carrier guard and all steering residuals remain
unchanged.

Expected signature: retain capture, early target progress, the coherent
alternating top-down wake, and compact oblique Lambda2 structures while
reducing far-field anterior greater-than-90/99%-rate residence and mean command
without the broad milestone regression of the inherited predictive barrier.
Falsify if capture or any `10/8/6/4/2L` milestone leaves the repeat-supported
class, if distance integral/path or force/moment materially worsens, if joint
angle margin or terminal yaw/slip regresses, if rate residence does not fall,
or if either wake view loses coherence. The new candidate's CFD result is not
available to this worker.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and moderate-rate fish-swimming kinematic guardrails
source_mechanism: regulate rhythmic energy from measured oscillator state while retaining coupled posterior lag and target-conditioned steering
transferable_invariant: a propulsive oscillator should add energy only while its normalized angle-rate orbit has headroom, rather than pump through a measured actuator-rate boundary
nontransferable_details: published oscillator gains and frequencies, species or robot amplitude envelopes, duty ratios, dimensional cadence, full-body waveforms, exact vortex phases, and task coordinates or routes
policy_translation: use anterior joint angle divided by current approach-scheduled amplitude and joint rate divided by the owned rate envelope as the two coordinates of a bounded phase-space energy pump; preserve the body-frame target feedback and two-joint traveling carrier
falsification: reject if rate and command residence do not improve while repeat-supported milestones, capture, distance integral, path, loads, joint margin, terminal yaw/slip, finite action, and coherent top-down and oblique wakes are retained
