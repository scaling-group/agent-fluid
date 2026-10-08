# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- The assigned-parent guidance, all four sampled solver artifacts, and the
  inherited optimizer notes and completed results were read first. Every
  compared rollout used direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders or prewarm, remained finite, and ended
  in capture.
- The four sampled artifacts are deterministic repeats of one evaluated v33
  controller: their policy, trajectory, and combined-keyframe SHA-256 hashes
  match. Each captures at `23.8425T`, with score `-0.535091`, scoring
  mean/final distance `2.433543/0.746165L`, and `236` moving-window shifts.
  They establish reproducibility, not four independent mechanisms.
- I inspected the sampled v33 combined sheet and the inherited v35 and v36
  tradeoff sheets from release through capture in both views. Each top-down
  row starts in an empty still-water field, develops a spatially ordered
  alternating vortex street, and follows the same broad target-directed arc.
  Each oblique row develops compact paired Lambda2 structures that persist
  behind the body through the curved terminal approach. The fish are
  self-propelled rather than advected; none shows wake breakup, boundary exit,
  collision, or instability. The mechanism differences are below the visual
  sheet's resolution and must be judged from trajectories.
- V33 is the strongest completed progress/regulation balance. Inside `3L` it
  has mean/peak absolute yaw `1.6800/3.1848 rad/T`, mean body-lateral speed
  `0.2522U`, and mean/peak absolute moment `0.006382/0.013730`. V35's
  two-joint carrier observer lowers mean yaw to `1.6103 rad/T` but delays
  capture to `23.8975T` and regresses score to `-0.535811`; v36 posterior
  tracking relief lowers mean yaw to `1.6316 rad/T` but delays capture to
  `23.8865T` and regresses score to `-0.535956`. V34's anterior transfer of
  slow course curvature also regressed score to `-0.535920`. Quieter terminal
  yaw alone is therefore not an improvement, and the evidence rejects another
  posterior edit, observer share, course allocation, or scalar yaw gain.
- The remaining measured defect is command feasibility rather than missing
  steering authority. V33 spends `14.28%/5.72%` of all samples at at least
  `99%` of the anterior/posterior joint-speed cap. In `520/619` anterior and
  `209/248` posterior saturated samples (about `84%` for each joint), the
  smoothly acceleration-bounded command still points outward, with mean
  magnitude `15.61/16.12 rad/T^2`. Inside `3L`, the corresponding outward
  fractions remain `65/79` and `52/62`. The episode therefore hard-clips
  joint rate while the policy continues to request infeasible acceleration;
  the existing acceleration projection does not address that mismatch.

## Single candidate and falsifiable hypothesis

Use evaluated v33 as the behavioral base and preserve its normalized
body-frame target guidance, response-released C-bend, state-feedback
traveling-wave carrier, posterior amplitude and lag, continuous terminal
course correction, phase-selected anterior counter-curvature, and smooth
acceleration projection. Add one independent feasibility layer at the final
two-joint command: normalize each observed joint velocity by an owned speed
limit, form a smooth headroom gate only near that limit, and attenuate only
the component of acceleration that would increase the current speed
magnitude. Commands that decelerate a joint pass through unchanged.

This is a state-dependent command projection, not cadence/gain tuning or a
new route regulator. It should replace repeated hard speed clipping with a
continuous approach to the feasible envelope while retaining the carrier's
direction, posterior emphasis, and target trajectory. Falsify it if capture
or coherent alternating propulsion is lost; score, arrival, or mean/final
distance regresses toward v35/v36; terminal yaw or moment worsens materially;
or `99%` speed-cap exposure and outward-at-cap commands do not fall without
increased angle/acceleration-limit exposure. The candidate has no same-worker
CFD result; the replay statistics only establish that the new path is active.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and fish-swimming kinematic guardrails
source_mechanism: regulate a joint-state oscillator within its feasible kinematic envelope while preserving a directed traveling bend and posterior phase relationship
transferable_invariant: separate propulsive and steering synthesis from actuator feasibility, suppressing only rate-increasing effort near a hard speed boundary instead of retuning or damping the whole carrier
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, hardware duty ratios, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: normalize each observed joint rate by a policy-owned limit and smoothly project only its outward final acceleration, leaving inward acceleration and the evaluated normalized body-frame two-joint controller unchanged
falsification: reject if v33-scale capture and distance progress or wake coherence regresses, or if joint-speed clipping fails to decrease without worse yaw, load, or other actuator-limit exposure
```

The shelf was consulted again because the three completed v33 exploit
iterations following v34-v36 introduced neither a new controller mechanism nor
a semantic improvement. It informed the separation between the stable
traveling carrier and the feasibility layer; the rollout evidence, rather than
published parameters, determines the projection's activation and acceptance.

## Validation boundary

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported by this account and failed before it
  could inspect the workspace. Its three prescribed checks were therefore run
  directly and separately.
- The guidance-materiality check initially found that the rendered workspace
  `README.md` marked the same assigned parent twice. Removing only the
  duplicate marker made parent selection unambiguous; the rerun passes and
  confirms both required evidence files have material content.
- The solver boundary check passes and exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`. A deterministic schema
  audit finds all `70` direct `params.FIELD` references among the `72` fields
  returned by `target_policy_params()`, with no undeclared reference. Static
  guards find no explicit time/step input, randomness, file I/O, mutable global
  state, cylinder identity, or memorized route.
- Replaying the headroom gate on the completed v33 trace activates it on
  `601/4335` anterior and `281/4335` posterior samples, so the new mechanism is
  materially exercised rather than a dormant code path. This is not a CFD
  performance claim.
- The prescribed Julia contract smoke command could not start because no
  `julia` executable is installed. No formal CFD was run; the post-worker
  evaluator must test capture, progress, wake coherence, and limit exposure.
