# Joint-response cadence governor

## Evidence and visual diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen Phase-2 contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture from
  `12.327720 L` at `25.118523 T` after 268 window shifts. Their policy files
  and combined keyframe sheets are byte-identical, and all reproduce score
  `-0.5280772274`, mean distance `2.4290872138 L`, and final distance
  `0.7461352944 L`. This is strong reproduction of the assigned parent, not a
  new semantic improvement.
- I inspected the complete combined sheet for the reproduced parent, including
  the top-down vorticity row and oblique body/Lambda2 row. The fish
  self-propels along a compact target-directed arc, leaves an organized
  alternating planar wake with finite three-dimensional vortex packets, and
  transitions to a quiet held-bend glide before capture. There is no passive
  advection, collision, loop, domain-exit precursor, out-of-plane excursion,
  terminal thrashing, or numerical instability. Thus the outer carrier and
  posterior lag are useful and the terminal equilibrium should be preserved.
- The assigned-parent inherited log supplies the missing informative failure
  sheet. The head-point intercept replacement retains the same capture step
  and is visually coincident with the reproduced parent in both views, but
  regresses to score `-0.5281959396`, mean distance `2.4291809278 L`, and
  final distance `0.7462602854 L`. Its lower final commands
  (`0.09533/0.23936` versus `0.09772/0.24610 rad/T^2`) do not improve the
  approach. Together with the inherited force-veto, shared-mean-unloading,
  broad-release, and joint-role-split regressions, this rejects another
  terminal cue substitution, authority adjustment, or actuator reallocation.
- The reproduced terminal band below `4 L` contains no command at the
  `1750 deg/T^2` software cap and no joint-speed-limit contact. Outside that
  band, however, commands sit at the cap on about `50.2%/40.3%` of joint
  samples; exactly one joint is capped on about `38.9%` of samples, and at
  least one joint reaches the `260 deg/T` rate envelope on about `10.5%` of
  samples. The coherent wake shows that the rhythm is productive, but these
  response statistics show that the requested cadence is frequently not
  kinematically trackable and motivate an outer, coupled feasibility response
  rather than more independent clipping.

## Policy hypothesis

Preserve the reproduced parent's state-feedback oscillator, target-angle
redirect, posterior target and lag, closure preview, shared mean-curvature
equilibrium, helpful-crossflow response, predicted-intercept corridor, small
coupled terminal release, and all output limits. Add one smooth common-cadence
governor driven by the larger normalized observed joint speed. It is inactive
until joint response approaches the declared rate envelope, then reduces the
shared oscillator frequency by a small bounded fraction. Because it changes a
common cadence rather than either joint's command or phase independently, it
retains the traveling-bend direction and posterior relation while giving both
joints time to track. Stored parent telemetry places the gate in the outer
propulsive regime and leaves the successful terminal band effectively
untouched.

This is a new response-feedback mechanism, not a scalar-only retuning of the
seed cadence: activation is owned by normalized measured joint state and
vanishes away from the rate envelope. Falsify it if stored-state replay shows
terminal interference or an inactive gate, or if later CFD fails to reduce
rate-envelope dwell and asymmetric command clipping without delaying or losing
capture, enlarging mean/final distance, changing the compact target-directed
arc, restoring joint-stop dwell or load spikes, destabilizing the dynamics, or
degrading either wake view.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish central-pattern-generator control and bounded undulatory gait control
source_mechanism: use measured actuator response to adapt a shared rhythmic command while retaining the coupled traveling-wave scaffold
transferable_invariant: when actuator response approaches its feasible envelope, continuously ease common cadence rather than independently changing joint phase or target-relative steering
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact Strouhal values, hard-limit magnitudes, vortex phase, and task-specific routes
policy_translation: normalize the maximum observed two-joint speed by a declared controller response scale and use one bounded smooth gate to reduce only the common state-feedback oscillator frequency while preserving posterior lag and all terminal geometry
falsification: reject if the gate is dormant or affects the quiet terminal approach, or if it fails to reduce rate-envelope dwell and clipping while preserving capture, distance, trajectory topology, loads, stability, and coherent top-down and oblique wakes

The current candidate's CFD evaluation occurs only after this worker exits and
is not claimed as evidence here.

## Non-CFD implementation audit

- Replaying the governor gate on all 4,567 stored parent states makes it active
  on 1,161 of 3,567 states beyond `4 L`, fully active on 373, and gives a mean
  cadence relief of about `1.33%` with the declared `6%` ceiling. It is exactly
  inactive on all 1,000 stored states at or below `4 L`. This establishes a
  live outer-response mechanism and stored-trajectory terminal
  noninterference; it does not predict the coupled-flow trajectory.
- The lightweight Julia contract returns two finite accelerations. The
  deterministic schema audit finds all 81 direct `params.FIELD` references in
  the 82-field object returned by `target_policy_params()`; the unreferenced
  field is the version label. The material-guidance check and downstream
  solver boundary check both pass.
- No formal CFD was run in this workspace. Capture, distance, actual
  rate-envelope dwell, loads, trajectory topology, and both wake views remain
  evaluation evidence for a later worker.
