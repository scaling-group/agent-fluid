# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and a moving storage window.
  All terminate in capture. Three peers are functionally identical executions
  of the line-of-sight controller with angle and rate guards; they reproduce
  `0.749366L` at `27.577T`. The assigned parent adds a common two-joint soft
  acceleration projection and captures at `0.749242L` and `26.296T`.
- I inspected both rows of the parent's and a peer's combined keyframe sheets.
  In both, the top-down row shows self-propelled translation from rest, a
  coherent alternating wake, and a late correct-sign hook into the target.
  The oblique body/Lambda2 row shows the same organized trailing structure
  without a visible 3D wake collapse. Translation persists through `252--255`
  inertial window shifts, so it is not storage advection. The parent follows
  the same useful broad topology but reaches the terminal hook sooner.
- No sampled rollout is a termination failure, so the informative failure
  contrast comes from inherited completed logs: waveform, recoil, damping,
  deeper-curvature, and instantaneous-intercept variants retained a coherent
  pass-by yet missed at roughly `0.828--1.096L`, while other closures diverged
  earlier. A strong wake or terminal scalar retune alone therefore is not a
  missing mechanism.
- The parent's common peak compression is a positive coordination result, not
  merely a marginal endpoint change. Relative to each repeated peer, it
  eliminates `1686/10028` exact acceleration-clamp samples, advances entry
  into `1.75L` from `25.295T` to `24.294T`, captures `1.281T` earlier, and
  lowers peak planar force/yaw-moment coefficients from
  `0.02218/0.01034` to `0.01883/0.00979`. It preserves zero angle and exact
  rate contacts. Terminal geometry also changes from an almost tangent
  projected miss/closing pair of `0.74933L/-0.00585L/T` to
  `0.70533L/+0.21872L/T`, so the parent has a materially better intercept
  rather than only deterministic first-crossing luck.
- A downstream limitation remains: the parent's independently applied rate
  guards see `1704/9562` joint samples above the `250 deg/T` soft band and
  `449` samples where a near-band joint still has a same-sign acceleration.
  Independent intervention can again disturb the anterior/posterior phase and
  effort relation that common compression just improved, although it avoids
  hard contact. This is evidence for testing coordinated energy withdrawal,
  not for increasing a carrier, steering, or terminal scalar.

## Policy hypothesis

Preserve the assigned parent's carrier, body-frame target/course steering,
redirect and release logic, positive-only target-line response, common command
compression, and both predictive viability guards. Add one small semantic
mechanism at the existing rate boundary: compute each joint's smooth
same-sign speed-risk gate, use their maximum as a reflection-equivariant pair
gate, and attenuate only positive joint-power components by that common gate.
Then retain the existing joint-local braking substitution. This withdraws
energy coherently when either member of the traveling bend approaches the rate
envelope, while inward/decelerating commands and the local safety brake remain
unmodified.

The falsifiable expectation is capture with the parent's coherent route and
zero angle/rate contacts, but less residence above the soft speed band and no
increase in clamp exposure or peak loads. A useful outcome may also preserve
or improve the parent's `0.705L` projected intercept and positive terminal
closing. Reject the mechanism if coordinated withdrawal delays or loses
capture, erases the posterior traveling bend, changes commands below the soft
band, weakens any inward safety command, restores actuator contact, or raises
force, moment, or acceleration-clamp exposure. The new CFD result is produced
only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: Lighthill-style reactive propulsion and coupled robotic-fish CPG control
source_mechanism: productive thrust depends on a directed anterior-to-posterior traveling bend whose coupled phase and effort relation should survive bounded feedback modulation
transferable_invariant: when one joint nears a viability boundary, withdraw positive actuation energy coherently across the coupled rhythm while preserving decelerating safety authority and posterior lag
nontransferable_details: published CPG gains, dimensional rates, species-specific envelopes, exact vortex phase, Strouhal targets, and task-specific trajectories
policy_translation: use normalized signed joint speed and acceleration to form a smooth reflection-equivariant pair gate; attenuate only same-sign speed-increasing components before retaining joint-local angle and rate brakes in the two-joint state-feedback contract
falsification: reject if sub-band or inward commands change, the traveling wake or terminal intercept degrades, capture is delayed or lost, actuator contact returns, or clamp and hydrodynamic load exposure fail to improve

## Non-CFD implementation audit

- The mandated checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account. Its three declared checks were therefore run
  directly and separately: the guidance semantic-delta check, finite two-joint
  Julia contract, and solver editable-boundary check all pass. No CFD was run.
- All `43` direct `params.FIELD` references are present in the parameter object,
  with no unreferenced schema fields. The new coupling strength is therefore
  owned by `target_policy_params()`.
- A deterministic synthetic-state grid confirms finite commands inside the
  `30 rad/T^2` envelope and lateral reflection equivariance to numerical
  tolerance. It also finds exact parent/candidate equality below the rate soft
  band and a nonzero intervention in `626` near-rate grid cases.
- A representative one-joint-risk case changes the outward near-limit anterior
  command from `+0.646` to `-0.864 rad/T^2` while leaving the low-speed,
  inward posterior command exactly at `+29.316 rad/T^2`. Thus the pair gate is
  active where intended without weakening the counterpart's deceleration.
