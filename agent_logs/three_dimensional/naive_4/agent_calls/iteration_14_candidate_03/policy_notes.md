# Phase-residual redirect direction

## Visual and quantitative diagnosis recorded before the policy edit

- All four supplied rollouts are finite captures from the required direct,
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm. I inspected both the top-down vorticity and oblique body/Lambda2
  rows for the strongest finite sample `solver_94565263e129` and the most
  informative mechanism regression `solver_56b21819ac4d`. Both sheets show
  self-propulsion, a coherent alternating street by `4T`, compact paired 3D
  structures behind the posterior traveling bend, and capture without wake
  collapse, collision, boundary interaction, or numerical instability. No
  failure-class visualization is supplied, so the useful failure is an
  actuator/trajectory regression rather than a different termination class.
- The response-conditioned parent sample `solver_94565263e129` is strongest:
  it crosses `8/6/4/2/1L` at
  `9.202/11.154/13.013/14.905/15.807T`, captures at `16.049T`, has held mean
  distance `1.939780L`, and scores `-0.056774`. Its final world velocity is
  `(-1.174,-0.081)U`, consistent with the visible target-directed crossing.
  The coherent carrier is costly but stable: anterior/posterior acceleration
  limits are occupied for `49.18%/22.89%` of samples, speed limits for
  `3.74%/6.07%`, and peak force/moment are `0.03926/0.01945` in normalized
  coefficients.
- The sampled factorial `solver_56b21819ac4d` adds the inherited narrow
  posterior outward-wave speed guard to that response-conditioned scaffold.
  It preserves capture and the visible wake and lowers posterior speed-limit
  residence from `6.07%` to `5.85%`, but delays the `6/4/2/1L` milestones,
  captures at `16.077T`, raises held mean distance to `1.941101L`, and regresses
  score to `-0.058139`. Mean posterior action also rises slightly from
  `24.923` to `24.956 rad/T^2`. Together with the prefilled guard result at
  `16.071T` and `-0.057037`, this falsifies the guard as an improvement on the
  present carrier; lower constraint residence did not compensate for lost
  route progress.
- The sampled capture-corridor release changes the terminal command but does
  not advance any milestone or arrival relative to the response-conditioned
  parent and slightly regresses score to `-0.056973`. The inherited logs also
  show that exact-clamp projection is trajectory-equivalent. The next policy
  therefore should neither add another clamp wrapper nor infer progress from
  smaller mean curvature or lower limit residence alone.
- Raw target-versus-course error remains strongly beat-scale on the best trace:
  at successive `2/1.75/1.5/1.25/1/0.8L` crossings it is approximately
  `-0.023/+0.259/-0.560/-0.040/+0.197/-0.621 rad`, while measured yaw rate
  reaches both signs within the approach. The inherited phase residual already
  improves the route when allowed to open as well as close high-authority
  intervals, but the raw error still sets the redirect direction. This leaves
  a testable inconsistency: carrier-correlated motion is removed from duty
  selection but remains inside the corresponding high-authority route command.

## One candidate and policy hypothesis

Start from the evaluated response-conditioned parent, including its coherent
traveling-bend carrier, posterior-only mean curvature, one-sided opposing-wave
relief, approach release, mean-first allocation, and exact speed-boundary
projection. Remove the sampled-negative pre-limit posterior speed guard. Make
one feedback change: use the existing bounded carrier-phase-residual error for
the high-authority redirect direction as well as its gate; retain raw
body-frame target/course error for cruise steering and the independently
evaluated raw gate that protects wave relief and acceleration headroom.

This is intended to make the route command internally phase-consistent without
attenuation-only capping or a new scalar schedule. It should preserve the wake
and far-field trajectory while reducing half-cycle redirection that follows
the carrier rather than persistent target-course mismatch. Falsify it if any
far/middle milestone is delayed, capture is lost or delayed beyond the sampled
parent, the alternating 3D wake weakens, route correction takes the wrong sign,
or acceleration/load relief does not accompany any route improvement.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and residual path-following control
source_mechanism: keep the rhythmic locomotor carrier distinct from a bounded low-dimensional navigation command
transferable_invariant: a carrier-correlated response component identified in normalized joint phase should not remain in the high-authority route direction after it has been removed from high-authority selection
nontransferable_details: published residual gains, clock-driven phase, species-specific kinematics, dimensional frequency, exact wake phase, task-specific routes, and source motor models
policy_translation: subtract the inherited normalized anterior angle/velocity carrier response from target-versus-course error for both redirect gate and redirect direction, while retaining raw body-frame error for cruise and raw-gate wave/headroom protection
falsification: reject if capture or milestones regress, wake coherence is lost, reflection equivariance fails, or lower phase-correlated steering does not produce useful route or load improvement

The new candidate has no same-worker CFD result. Only sampled closed-loop
evidence and deterministic fixed-state checks can support it before the later
EvE evaluation.

## Non-CFD fixed-state audit

- Replay on all `2,918` states of the sampled parent leaves every anterior
  command exact and changes `1,030` posterior commands. The mean absolute
  command difference is `0.159 rad/T^2` and the maximum is `3.186 rad/T^2`, so
  this is a feasible-action change rather than another exact-clamp wrapper.
  Three sign differences occur only where the parent's posterior command is
  smaller than `0.76 rad/T^2`; there is no large-demand reversal.
- On the fixed parent states, mean absolute posterior demand rises from
  `24.927` to `25.067 rad/T^2` (`0.56%`). That counterfactual does not predict
  closed-loop loads, but it rules out claiming command relief before CFD and
  sharpens the falsification boundary: the candidate must earn any added
  demand through earlier milestones, better capture, or lower realized loads.
- The lightweight Julia contract passes, and every one of `33` direct
  `params.FIELD` references is returned by `target_policy_params()`. A
  deterministic `91,125`-state sweep across joint angles, exact joint-speed
  limits, target side, bearing, and body-frame velocity returned finite bounded
  commands with exact lateral-reflection equivariance and no outward command
  at either measured speed boundary. The guidance provenance check and solver
  editable-boundary check also pass. The required dedicated check-runner was
  invoked, but its pinned `gpt-5.4-mini` model is unavailable on this ChatGPT
  account; its three prescribed commands were therefore run directly and
  separately. No CFD was run.
