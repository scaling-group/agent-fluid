# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance and notes, all four sampled solver artifacts,
  and the inherited completed interventions through v36 were read before
  selecting a mechanism. The sampled artifacts are byte-identical evaluations
  of v33, including identical combined keyframe sheets, so they establish one
  strong finite case rather than four independent trials. Each reports direct
  uniform still-water initialization at `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and capture.
- The combined v33 and v36 sheets were inspected from release through capture
  in both the top-down vorticity and oblique body/Lambda2 views. An empty flow
  field develops into a spatially ordered alternating wake behind a fish that
  translates along a curved target-directed route; compact three-dimensional
  structures persist through the final bend. This is coherent self-propulsion,
  not advection. The posterior-relief difference is below the image sheet's
  resolution, so trajectory and load histories decide between them.
- Sampled v33 is still the strongest balanced result: score `-0.535091`,
  capture at `23.8425T`, scoring mean/final distance
  `2.433543/0.746165L`, and inside-`3L` mean/peak absolute yaw and moment
  `1.680/3.185 rad/T` and `0.006382/0.013730`. The inherited v36 posterior
  tracking-spring relief did reduce those terminal yaw/moment measures to
  `1.632/3.078 rad/T` and `0.006207/0.013350`, but regressed score, capture
  time, and mean/final distance to `-0.535956`, `23.8865T`, and
  `2.434335/0.746970L`. Together with v30-v35, that is negative evidence
  against another posterior half-cycle, allocation, or observer correction.
- A direct audit of v33's recorded two-joint state and applied command exposes
  a different actuator defect. Over the full `4335`-sample rollout, the
  anterior rate equals the `260 deg/T` cap in `504` samples (`11.63%`) and the
  posterior rate in `198` (`4.57%`). In every exact-cap sample, the recorded
  acceleration has the same sign as velocity and therefore asks the hard
  integrator clamp to supply the missing feedback. Inside `3L`, exact-cap
  fractions remain `10.63%` and `7.97%`; near-cap exposure is thus not merely
  a release transient. Smooth acceleration projection keeps commands finite,
  but it does not preserve oscillator phase when joint rate clips.

## Candidate hypothesis recorded before policy edit

Preserve v33's normalized body-frame route feedback, response-released C-bend,
continuous terminal course bend, posterior lag and amplitude, state-derived
anterior half-cycle correction, and component-wise smooth acceleration
projection. Add one new feasibility layer after propulsion and steering are
composed: a symmetric soft joint-speed governor. For either joint and either
velocity sign, it continuously removes the outward command as normalized joint
speed enters a narrow band below the known rate envelope, and supplies a small
inward braking margin at the cap. It does not use target side, tail side,
distance, time, or a prescribed phase and therefore cannot become another
posterior yaw-relief gate.

The hypothesis is that preventing the controller from driving into the hard
rate clamp will retain a smoother state-feedback traveling wave, reduce rate-
limit dwell and the associated terminal yaw/load disturbance, and preserve or
improve v33-scale distance progress. Falsify it if capture or coherent wake
formation is lost, arrival/mean/final distance regresses toward the v35/v36
results, exact rate-cap exposure remains, terminal yaw/moment worsens, or the
governor merely moves saturation into acceleration or angle limits. No
same-worker CFD outcome is claimed.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and state-feedback rhythmic swimming
source_mechanism: reshape oscillator drive continuously from sensed joint state while retaining the low-dimensional traveling-wave carrier
transferable_invariant: when a rhythmic controller repeatedly drives a state into a hard actuator boundary, feed normalized joint state back before the boundary so the carrier turns under controller dynamics rather than limiter clipping
nontransferable_details: published CPG gains, hardware servo limits, dimensional cadence, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: preserve v33's body-frame two-joint controller and apply one sign-symmetric soft projection to each composed acceleration using only that joint's normalized measured rate and owned actuator-envelope parameters
falsification: reject if rate-cap dwell is not reduced, capture or wake coherence regresses, v33-scale distance progress is lost, terminal yaw or moment worsens, or another actuator limit becomes more active
```

The shelf supplied the state-feedback carrier invariant only. The trigger is
the completed rollout's exact rate-cap/outward-command coincidence; the shelf
does not supply the governor threshold, braking authority, or task trajectory.

## Non-CFD validation

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported for this account and failed before executing checks.
  Its prescribed guidance and solver-boundary commands were then run directly;
  both pass.
- The exact Julia contract smoke command was also invoked, but this workspace
  has no `julia` executable, so it exits before loading the policy. A static
  schema audit finds all `71` direct `params.FIELD` references among the `73`
  fields returned by `target_policy_params()`; only metadata fields `version`
  and `control_period` are unreferenced. The public entrypoints remain present,
  and no clock, step, randomness, file I/O, cylinder state, mutable global, or
  fixed route is accessed.
- The solver boundary contains exactly one nonempty
  `candidate_target_policy.jl`. Its diff from evaluated v33 is confined to the
  phase-symmetric joint-rate governor, its three owned parameters, and
  descriptive metadata. No CFD was run; the v37 outcome remains evidence for
  the next generation.
