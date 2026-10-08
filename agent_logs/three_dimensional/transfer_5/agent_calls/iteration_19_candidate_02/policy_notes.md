# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver artifacts, and the
  inherited optimizer notes and completed rollouts were read before choosing
  the mechanism. Every compared run used direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders or prewarm, remained finite, and
  terminated in capture. The four current solver artifacts are exact repeats
  of v33: their policy, trajectory, and combined keyframe hashes agree, so they
  establish reproducibility rather than four distinct mechanisms.
- The combined sheets for the strong v33 capture and the informative v35
  regression were inspected from release through capture in both views. Each
  starts from an empty flow field; the fish visibly translates toward the
  target while forming a coherent alternating top-down vortex street and
  compact paired oblique Lambda2 structures. Both retain the wake through the
  curved terminal approach. Motion is self-propelled rather than background
  advection, and the controller difference is below the sheets' visual
  resolution, so trajectory, load, and joint histories decide the edit.
- Repeated v33 captures at `23.8425T` with score `-0.535091`, scoring mean and
  final distance `2.433543/0.746165L`, and inside-`3L` mean/peak absolute yaw
  `1.6800/3.1848 rad/T`, target-transverse speed `0.2392U`, and mean/peak
  absolute moment `0.006382/0.013730`. It remains the best sampled balance of
  progress and terminal regulation, so its response-released C-bend,
  posterior traveling wave, continuous course bend, and phase-selected
  anterior residual should be preserved.
- Inherited v35 improved an offline observer statistic by adding full-tail
  joint rate to carrier rejection. Its completed CFD also lowered inside-`3L`
  mean/peak yaw to `1.6103/3.0497 rad/T`, transverse speed to `0.2224U`, and
  mean moment to `0.006106`, but capture slipped to `23.8975T` and score,
  scoring mean distance, and final distance regressed to `-0.535811`,
  `2.434232L`, and `0.746866L`. Together with v34's fixed-allocation
  regression, this shows that cleaner yaw/slip or offline decorrelation is not
  enough when along-target progress falls; another observer share or
  curvature-allocation scalar is not justified.
- A separate actuator defect survives in v33. Inside `3L`, the anterior and
  posterior joint rates are at or above `99%` of the `260 deg/T` cap in
  `13.1%` and `10.3%` of states, respectively, and both attain the cap exactly.
  In `78` terminal states above `95%` of the cap, the anterior acceleration
  still points outward with its velocity. This is wasted outward command at
  the hard envelope and a plausible contributor to the fast yaw/load carrier.
  The inherited guidance notes that smooth acceleration projection improved
  progress without curing velocity-cap exposure, while phase-lag damping was
  ineffective; the remaining test should therefore be a one-sided final
  command projection rather than another waveform or steering-gain edit.

## Policy hypothesis recorded before policy edit

Use evaluated v33 as the sole behavioral base. Preserve its state-feedback
oscillator, posterior amplitude and lag, response-released body-frame C-bend,
continuous terminal course feedback, phase-selected anterior excess-yaw
residual, cadence, and component-wise smooth acceleration projection. Add one
terminal feasibility layer to the anterior output only: normalize observed
anterior joint speed by the owned physical speed limit, smoothly attenuate an
already projected command only when command and velocity have the same sign
above a guard band, and blend the attenuation with the existing target-relative
terminal proximity. Commands that reverse the joint remain unchanged, the
guard is identically inactive outside `3L`, and the posterior command is
unchanged.

This tests whether preventing only cap-directed anterior work can reduce hard-
limit residence and terminal yaw/load without removing the posterior impulse
that v30/v35-style regulation traded away. Replaying the proposed gate on the
v33 trace activates it in `75/602` inside-`3L` states (`12.5%`) and nowhere
outside; among active states it retains a mean `56.8%` of the recorded
projected outward command. This replay establishes bounded intervention, not
CFD improvement. Falsify the mechanism if capture or coherent wake formation
is lost; v33-scale score, arrival, mean/final distance, or along-target speed
regresses toward v35; anterior speed-cap exposure is not reduced; terminal
yaw/moment worsens; or posterior kinematics change materially.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory, robotic-fish CPG control, and terminal capture scheduling
source_mechanism: preserve the posterior traveling-wave propulsor while using bounded state feedback to reduce excess near-target motion without suppressing necessary reversal or propulsion
transferable_invariant: keep the evidenced posterior wave intact and constrain only the anterior command component that continues motion toward a measured kinematic limit during terminal approach
nontransferable_details: published gains, dimensional cadence, species-specific speed envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: normalized anterior joint speed and command sign select a smooth one-sided guard; normalized body-frame distance supplies the existing terminal gate; reversal commands, posterior amplitude, posterior lag, and target-relative steering remain unchanged
falsification: reject if capture or the coherent alternating wake regresses, v33-scale distance progress is lost, speed-cap exposure does not fall, terminal yaw/load worsens, or posterior propulsion changes materially
```

The shelf supplied only the actuator-role and terminal-scheduling invariant.
The guard location and scale come from the sampled v33 joint history and the
fixed experiment envelope, not from published gains. Formal CFD occurs after
this worker exits and is not claimed here.

## Non-CFD validation

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account and failed before inspecting the workspace.
  Its prescribed checks were therefore run directly and separately.
- The transient-notes/material-guidance check passes. The solver-boundary
  check passes and confirms that only the permitted candidate file differs
  from the frozen solver baseline. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`.
- The Julia contract command cannot start because no Julia executable is
  installed. A deterministic schema audit resolves all `70` direct
  `params.FIELD` references among the `72` fields returned by
  `target_policy_params()`; only metadata fields `version` and
  `control_period` are intentionally unreferenced. Static guards find no
  time/step input, randomness, file I/O, cylinder identity, fixed route, or
  mutable global state.
- Algebraic edge checks confirm that the new projection leaves commands
  unchanged outside terminal authority, leaves every reversal command
  unchanged, reduces a full-authority cap-directed command to zero, and is
  sign-reflection equivariant. It cannot increase the magnitude produced by
  the inherited smooth acceleration projection. No CFD was run.
