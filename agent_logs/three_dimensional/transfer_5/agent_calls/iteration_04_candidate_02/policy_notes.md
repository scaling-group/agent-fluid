# Joint-rate-governed response-release candidate

## Evidence diagnosis

- All four sampled rollouts satisfy the Phase-2 evidence contract: direct
  uniform initialization, still water `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm. Their trajectory CSVs and combined keyframe sheets are exactly
  identical. Their policy diffs change only comments and the `version` string,
  so the four nominal candidates are one computational controller rather than
  four independent control tests.
- That common controller is the strongest finite evidence. It self-propels
  from `12.328L` to a `0.7490L` capture at `23.876T` (score `-0.53776`). The
  top-down row shows a compact alternating vortex street behind a broad,
  target-directed arc; the oblique Lambda2 row confirms coherent 3D shedding
  from release through capture. There is no sign of passive advection.
- The inherited `solver_d594e3893325` sheet has the same useful alternating
  wake and broad-turn topology but captures later at `25.388T`. The inherited
  logs report that response release improved this to `25.152T`, and a smooth
  fourth-order acceleration projection improved a separate branch to
  `23.997T`; their composition produced the current `23.876T` result. The
  inherited upper-exit posture-replacement failure is available only as a
  logged visual diagnosis, not as a sampled sheet in this workspace: it curled
  tightly, parked the posterior joint at its angle limit, and lost the
  alternating carrier. That is evidence against changing bend polarity or
  replacing the carrier.
- The remaining weakness is kinematic clipping, not missing propulsion or
  steering. In the common current trajectory, the anterior/posterior joint is
  at or above 95% of the `260 deg/T` speed limit for `19.7%/9.4%` of samples.
  Commands are at or above 95% of the `1800 deg/T^2` envelope for `55.2%/39.3%`
  of samples, while yaw oscillates between about `-2.83` and `+2.95 rad/T`.
  Joint angles reach only `78.4%/71.6%` of their limit, so an angle governor is
  not supported. Acceleration projection alone made commands feasible but did
  not keep the oscillator inside its joint-rate envelope.

## Policy hypothesis

Retain the complete normalized body-frame guidance, same-sign geometry-gated
C-bend, response-release allocation, state-feedback traveling wave, and smooth
acceleration projection. Add one state-dependent joint-rate reference governor
at the physical output: above 90% of the owned rate limit, smoothly attenuate
only acceleration whose sign would increase the observed absolute joint rate;
leave braking acceleration unchanged. This should prevent hard rate clipping
without suppressing reversals, changing target geometry, or imposing a clock.
It is intentionally inactive through most of each beat and does not tune a
scalar drive gain.

Falsify the mechanism if capture is lost or materially later than `23.876T`,
mean distance or wake coherence regresses, the trajectory changes to a boundary
exit, or the `>=95%` rate exposure fails to fall. Also reject it if reduced
clipping is bought with larger angle occupancy, yaw/load spikes, or a visibly
weaker posteriorly lagged wake. The new CFD rollout occurs after this worker
exits, so none of these outcomes is claimed here.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and bounded fish-swimming gait design
source_mechanism: observed oscillator state governs rhythmic actuation while physical amplitude and angular-velocity envelopes constrain the carrier
transferable_invariant: preserve the posteriorly lagged traveling wave, but stop commands from pushing an already near-limit joint farther outward while retaining reversal authority
nontransferable_details: published CPG gains, robot actuator ratings, species-specific kinematics, dimensional frequencies, exact tail-beat or vortex phase, and task-specific routes
policy_translation: smoothly gate each projected acceleration from normalized observed joint speed and command-speed sign, using only owned rate-envelope parameters; pass braking commands and all normalized body-frame target feedback unchanged
falsification: reject if rate-limit exposure does not decrease or if capture, target-directed wake coherence, arrival/mean distance, angle occupancy, yaw, or load history worsens materially
```

## Worker-side verification boundary

- The required guidance-semantic check passes after removing the duplicated
  assigned-parent marker from the rendered workspace `README.md`, and the
  prescribed editable-boundary check passes.
- A deterministic audit finds `62` fields returned by
  `target_policy_params()`, `60` direct `params.FIELD` references, and no
  missing field. It also finds exactly one `target_policy_params` and one
  `target_policy` definition, with no clock, step, random, or global-state cue.
- Algebraic edge checks keep the rate governor finite and monotone, make it
  return full command below its onset and zero outward command at the rate
  limit, and preserve every braking command. Frozen-state replay of the sampled
  trajectory changes `1070/8682` commands and lowers command RMS by about 2.9%;
  this confirms that the mechanism is active, not that the fluid trajectory
  improves.
- The exact Julia load assertion could not run because there is no `julia`
  executable. The requested specialized check-runner was invoked but its pinned
  model is unavailable in this environment, so its specified checks were run
  directly where supported. No CFD was run.
