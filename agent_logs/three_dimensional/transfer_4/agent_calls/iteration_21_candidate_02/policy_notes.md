# Phase-selective terminal posterior envelope

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance and inherited note, all four sampled
  policies and rollout records, and the combined top-down vorticity and oblique
  Lambda2 keyframe sheets for the sampled v12 score leader, the sampled v16
  terminal envelope, and the assigned parent's carrier-recovery partition.
  Every comparison is a stable capture from direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders. In both views the fish
  self-propels from rest and retains an organized alternating traveling wake;
  there is no passive advection, wake breakup, collision, or out-of-plane
  instability. The visible sheets are nearly indistinguishable, so trajectory,
  terminal motion, load, and actuator histories must decide the edit.
- The current v12 prefill is reproduced exactly by a second sample and by the
  v15 distance-conditioned phase-reference partition: all three capture at
  `18.0125T` with score `-0.064599`, center path/head cross-track
  `13.2330L/0.7417L`, near-target mean speed/yaw/alignment
  `0.9012U/1.9970 rad/T/0.6637`, and final alignment `0.0678`. This confirms
  that changing only the extra-work phase reference in the terminal region is
  semantically inert under the closure-qualified reserve gate.
- The assigned parent's carrier-energy partition is also an exact trajectory
  repeat of the inherited step-18 energy-partitioned policy, despite different
  version text. Relative to v12 it shortens arrival, center path, and head
  cross-track to `17.9960T/13.1056L/0.6768L`, and improves near/final alignment
  to `0.7217/0.1865`, but worsens score from `-0.064599` to `-0.073525` and
  raises the sampled whole-trajectory mean distance from `7.4194L` to
  `7.4784L`. Its first-`3T` distance is unchanged to four decimals while speed
  is slightly lower (`0.2519U` to `0.2517U`). Thus carrier-energy scheduling
  changes route topology but does not preserve integrated closure, and its
  exact repeated result is determinism evidence rather than a new mechanism.
- The sampled v16 envelope changes the active lagged posterior-wave target,
  rather than the inactive terminal reserve reference. It preserves identical
  first-`3T` behavior and both coherent wake views, improves score slightly to
  `-0.064545`, shortens center path/head cross-track to
  `13.2111L/0.7232L`, reduces near speed and absolute yaw to
  `0.8866U/1.8883 rad/T`, raises near/final alignment to `0.6722/0.1818`, and
  modestly reduces RMS force/moment and posterior rate/acceleration-limit
  residence. Its cost is an `0.0110T` later capture. This supports terminal
  posterior energy relief, but the small effect and delay indicate that
  attenuating the wave equally during energy-adding and braking portions of
  the observed joint cycle is not yet a clean allocation.

## Single policy hypothesis

Preserve the evaluated v12 anterior state-feedback oscillator, cadence,
posterior lag/emphasis and reserve, odd body-frame curvature map, route and
approach feedback, half-cycle steering, and reversal-preserving rate governor.
Apply the evidence-supported terminal envelope directly to the lagged posterior
wave, but make it phase selective: the normalized product of observed posterior
joint rate and the raw lagged-wave target identifies when that wave contribution
is adding joint energy. Under the existing near-target, poor-course-alignment,
high-yaw condition, attenuate only that positive-work part and leave the
negative-work braking part at full authority. The gate is continuous, bounded,
reflection symmetric, and uses no clock, route, or prescribed wake phase.

Expected evidence is exact v12 behavior before `2.10L`, preservation of the
coherent traveling wake and capture, terminal yaw/speed/alignment and route
metrics at least as good as the sampled full-cycle envelope, and removal of its
arrival delay by preserving braking/reversal authority. Falsify the mechanism
if pre-approach motion changes, capture or the sampled-best score is lost,
arrival still delays without a compensating distance gain, terminal motion or
route width regresses, saturation merely moves between joints, reflection
fails, or either visual wake view loses coherence.

bookshelf_consulted: true
source_domain: phase-plane robotic-fish oscillators, half-cycle asymmetric turning, and posterior reactive propulsion
source_mechanism: modulate the energy-adding portion of a posteriorly emphasized traveling stroke while retaining the opposite half-cycle for braking and wave reversal
transferable_invariant: separate propulsive energy injection from braking using observed joint position-rate phase, and condition terminal relief on normalized target-relative motion rather than time or a prescribed vortex phase
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: combine normalized posterior joint rate with the raw lagged-wave target to form a bounded positive-work gate; multiply it by normalized distance, course-alignment, and turn-rate gates before enveloping only the posterior wave target in the two-joint feedback controller
falsification: reject if pre-approach behavior changes, capture or sampled-best score is lost, terminal yaw/speed/alignment or route width worsens, the full-cycle envelope's arrival delay remains without compensating closure, actuator pressure migrates, reflection fails, or either wake view deteriorates

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account. Running its immutable
  checks directly gives PASS for the material guidance update and repository
  boundary. Julia and `juliacall` are not installed in this image, so the exact
  Julia load probe could not run.
- The deterministic replacement audit finds a non-empty candidate, balanced
  delimiters, 63 direct `params.FIELD` references all covered by 65 unique
  fields returned from `target_policy_params`, and no prohibited time, random,
  file-I/O, cylinder, wake-position, or route signals.
- Focused probes confirm that posterior-wave authority is exactly `1.0` at and
  beyond `2.10L`, remains exactly `1.0` for negative-work braking, and is
  scalar-invariant under reflection. Replaying the gate over the sampled v12
  trajectory with logged yaw as a conservative turn-rate proxy gives outside
  authority exactly `1.0`, inside mean/min authority `0.8991/0.6857`, and
  authority below `0.95` for `51.02%` of approach samples. This activation
  check is not CFD evidence; EvE must evaluate the policy after this worker
  exits.
