# Promotion of partially coupled outer saturation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm snapshot, finite moving-window dynamics, and capture
  from `12.327720 L`. Three byte-identical `v29` intercept-corridor policies
  reproduce score `-0.5280772274`, mean distance `2.429087214 L`, final
  distance `0.746135294 L`, and capture at `25.118523 T`. This provides a
  strong parent baseline, not three independent mechanisms.
- The distinct sampled `v33` partially coupled saturation policy is the
  strongest finite rollout. It captures at `23.435516 T`, improves score to
  `-0.4079736071` and mean distance to `2.305032573 L`, and shortens the
  center-path length from about `13.7094 L` to `13.6569 L`. Final distance is
  slightly worse (`0.749060333 L`) because the faster trajectory crosses the
  first-capture boundary at a different point; semantic success and the much
  earlier crossing outweigh that threshold-scale regression.
- I inspected the complete combined keyframe sheets for the sampled `v33`
  winner and the reproduced `v29` baseline, including every top-down
  mid-plane vorticity panel and every oblique body/Lambda2 panel from release
  through capture. Both fish self-propel from quiescent flow, form coherent
  alternating planar wakes with finite 3D vortex packets, follow continuously
  closing target-directed arcs, and enter a held-bend capture. The `v33` path
  is visibly more direct and reaches the target before the baseline's late
  glide; neither view shows passive advection, a loop, collision,
  boundary-exit precursor, out-of-plane instability, wake collapse, or
  terminal thrashing.
- Trajectory telemetry supports an outer actuator-coordination cause. Relative
  to `v29`, `v33` changes only the high-command carrier algebra outside `4 L`,
  raises maximum center speed from about `0.6926` to `0.8224 L/T`, and reduces
  anterior software-cap incidence from about `39.4%` to `26.9%` of stored
  states while retaining the same `30.5433 rad/T^2` envelope. Posterior cap
  incidence is similar (`31.5%` versus `33.3%`), and the posterior angle grows
  from `0.6745` to `0.7380 rad` without reaching the `0.7854 rad` joint stop.
  Peak force/moment rise modestly from about `0.02834/0.01499` to
  `0.02858/0.01520`, so the gain is faster coordinated propulsion, not load
  reduction, and larger coupling authority is not supported by this single
  sample.
- The assigned-parent logs reject several terminal alternatives around the
  reproduced `v29`: capture-point line-of-sight reconstruction regressed to
  `-0.52819594`, and recovering up to `3%` terminal cadence regressed to
  `-0.52812468`. The `v33` intervention is independently located outside the
  terminal band and produces a meaningfully different, faster trajectory.

## Candidate hypothesis

Replace the prefilled `v29` policy with the evaluated `v33` policy unchanged
as the single candidate. Preserve its state-feedback oscillator, posterior
lag, body-frame target redirect, closure preview, shared terminal
mean-curvature equilibrium, helpful-crossflow and intercept response gates,
command envelope, and `12%` outer blend from independent component clipping
toward common scaling of the raw two-joint carrier command. The blend is
exactly dormant below `4 L` and when the raw carrier does not exceed the
existing acceleration limit.

This is promotion of an evidence-backed actuator-coordination mechanism, not a
scalar-only gain change. The next evaluation should reproduce the earlier,
more direct capture and coherent wake without increasing the coupling fraction
or stacking a terminal refinement. Falsify the promotion if capture does not
reproduce, the direct closing path or wake coherence is lost, joint-stop dwell
appears, acceleration exceeds the inherited envelope, force/moment growth
becomes material, or the policy becomes unstable. The new evaluation occurs
only after this worker exits and is not claimed as same-worker evidence.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body swimming with coupled-oscillator robotic-fish control
source_mechanism: preserve coordinated anterior-to-posterior rhythmic command structure and posterior lag while enforcing an actuator envelope
transferable_invariant: a common bounded scale preserves the direction of a coordinated two-joint carrier command better than unrelated component flattening when the envelope is exceeded
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and actuator envelopes, full-body waveforms, exact phase lag, vortex phase, capture radius, and task-specific routes
policy_translation: retain normalized body-frame guidance and blend only a small parameter-owned fraction of the over-limit outer carrier from componentwise clipping toward common two-joint scaling, with no change to terminal allocation
falsification: reject on failed reproduction, delayed or lost capture, changed closing topology, joint-stop dwell, acceleration-envelope violation, material load growth, instability, or loss of coherent top-down or oblique wake structure

## Non-CFD validation

- The candidate is byte-identical to the evaluated `v33` sample (LF SHA-256
  `5f7d9f8a00edfd6a327ecb1048e1d6cb56ac5de9558be3a6fde80dc656781f9a`).
- The required checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account. Running its three prescribed commands
  directly and separately gives PASS for the material guidance update, the
  finite two-acceleration Julia contract, and the solver edit boundary.
- A separate deterministic audit finds all 79 direct `params.FIELD`
  references in the 80-field object returned by `target_policy_params()`; the
  extra field is the version label. A sample over-limit two-joint vector also
  confirms that the partially coupled limiter remains inside the declared
  envelope. No formal CFD was run in this workspace.
