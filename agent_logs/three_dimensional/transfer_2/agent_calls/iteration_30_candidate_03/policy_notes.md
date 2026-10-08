# Evidence-selected replicated terminal phase-allocation candidate

## Visual diagnosis before candidate selection

- The four assigned solver examples are byte-identical copies of the v41
  terminal phase-allocation controller, trajectory, and keyframes.  Each uses
  direct uniform still-water initialization (`U_infinity=[0,0,0]`), no
  cylinders or prewarm, and captures at `24.640015T` with minimum/final
  distance `0.748356L`, mean distance `2.347937L`, score `-0.448328283`, and
  284 moving-window shifts.  These are deterministic nominal replications,
  not four different mechanisms or held-out tests.
- I inspected the combined and view-specific sheets from release through
  capture.  The top-down row begins wake-free and shows self-propelled
  diagonal progress, a coherent alternating vortex street, and a compact
  transverse hook into the target disk.  The oblique Lambda2 row retains
  compact three-dimensional wake structures through the hook, with no passive
  advection, out-of-plane escape, numerical breakup, or collision-like event.
  The diagnostics agree: peak absolute planar body-force/yaw-moment
  coefficients are approximately `0.0230/0.0317/0.0156`, posterior hard-stop
  occupancy is zero, and exact-rate exposure stays in the inherited `13%`
  class.
- No current sample has a failed termination.  The most informative distinct
  sampled performance failure is the posterior-only terminal allocator: its
  sheets retain the same visible route/wake class, but it captures later at
  `24.673016T`, worsens final/mean distance to `0.748776/2.348364L`, and scores
  `-0.448772903`.  The inherited coupled anti-windup result is a second
  negative: vetoing the anterior residual when posterior safety filters reject
  its paired contribution delays capture to `24.656513T`, reduces the crossing
  margin to `0.000397L`, worsens mean distance to `2.348909L`, and scores
  `-0.449516228`.  The assigned parent also records that transferring rejected
  posterior effort to anterior headroom regressed final/mean distance and raw
  acceleration exposure.
- Broader alternatives are already falsified in inherited logs.  Posterior
  reference-velocity feedforward separated the far route by `8T`, missed at
  `0.993183L`, and exited left; two dual-joint rate barriers likewise converted
  capture into pass-and-turn exits despite better rate statistics.  Thus the
  evidence does not support another terminal authority split, paired
  anti-windup gate, broad rate correction, or saturation-only objective.

## Candidate hypothesis

Keep exactly one candidate: the current v41 policy byte-identical to the four
assigned solver examples.  Preserve its observed-state anterior phase anchor,
posterior lagged traveling bend, normalized body-frame course and predicted-
miss feedback, bounded steering-priority allocator, posterior stopping-stroke
reserve and rate coast, and coupled phase-selected terminal residual.

This is completed-evidence selection after three consecutive nominal
iterations without a new mechanism or semantic improvement, not a scalar gain
edit and not a same-worker CFD claim.  The shelf's disturbance-residual and
approach-hold mechanisms are not adopted: the sampled wake is already coherent
and low-load, the still-water trace supplies no identified disturbance with a
calibrated sign and scale, and prior carrier holds and terminal redistributions
regressed.  The post-worker evaluation should reproduce capture, the far route,
zero posterior hard-stop occupancy, and the low-load class.  Reject nominal
selection if those fail to repeat.  Separately, do not claim robustness from
these duplicates: reject the phase gate or coupled allocation if reflected or
perturbed-pose evidence shows that it withdraws necessary correction.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: embed bounded sensory steering within a stable anterior-to-posterior traveling bend while preserving the phase anchor and follower lag
transferable_invariant: infer beat phase from joint state and keep target-derived steering coupled on the empirically productive half-cycle without reclaiming safety-filtered effort through the other actuator
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant body-frame predicted-miss residual, lagged-wave phase gate, coupled joint shares, and posterior safety filters; do not add a scalar, disturbance term, or authority redistribution unsupported by the trace
falsification: reject if nominal capture, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class fails to repeat, or if held-out reflections or pose perturbations show that the phase gate or coupled split removes required route correction

## Pre-evaluation validation

- The required active candidate remains byte-identical to all four assigned
  evaluated policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`);
  the four trajectories and combined keyframe sheets are also byte-identical.
  No sibling candidate was created in this workspace.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared no-CFD checks were run
  directly and separately: the durable-guidance semantic check, public policy
  contract, and solver editable-boundary audit all pass.  The contract returns
  finite accelerations `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.  A
  static scan finds no direct elapsed-time, step, task, cylinder, random, or
  file-I/O dependency.  The active candidate remains non-empty.
- Durable guidance now incorporates both the exact nominal replication and the
  posterior-only, headroom-transfer, and anti-windup negatives.  Formal CFD is
  reserved for the post-worker evaluator; no same-worker outcome is claimed.
