# Alignment-qualified terminal posterior envelope

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance and optimizer note, the sampled scores,
  observations, diagnostics, trajectories, policies, and both the top-down
  vorticity and oblique Lambda2 rows of the combined keyframe sheets. All four
  samples are stable captures from direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders. No semantic failure is
  present, so the useful comparison is the reproduced score leader against the
  distinct lower-scoring capture. Both visibly self-propel from rest, retain a
  coherent alternating top-down wake, and shed compact three-dimensional
  posterior structures without wake breakup or passive advection.
- The assigned terminal-partitioned parent is reproduced byte-for-byte by
  three samples at score/mean distance `-0.064599/1.950823L`, capture time
  `18.0125T`, and path `13.2330L`. Its remaining defect is specifically
  terminal: below `2.10L`, mean target-course alignment is only `0.6637`, mean
  speed remains `0.9012U`, mean absolute yaw rate remains `1.9970 rad/T`, and
  final alignment falls to `0.0678`. Posterior acceleration also remains at
  its ceiling for `66.02%` of the rollout. The last top-down and oblique frames
  agree with those histories: capture occurs with a pronounced lateral bend
  and an energetic wake rather than after a settled, target-aligned approach.
- The distinct unguarded posterior-reserve sample captures earlier and on a
  shorter path (`17.8695T/13.0071L`) with better near alignment (`0.7875`), but
  gives back the leader's integrated closure at score/mean distance
  `-0.072146/1.958037L`. Inherited always-separated and carrier-recovery phase
  references likewise improved arrival/path/alignment but worsened mean
  distance. The parent's terminal-only phase-reference partition did not
  remove the reproduced leader's terminal defect. A phase-reference edit under
  the closure-qualified *extra-work* gate is therefore not a dependable way to
  regulate an energetic terminal stroke; the active lagged posterior wave is
  the next falsifiable allocation surface.

## Single policy hypothesis

Preserve the parent's odd body-frame curvature map, head oscillator, cadence,
far/middle posterior emphasis, posterior reserve guard, mean steering target,
half-cycle steering, and reversal-preserving rate governor. Add one continuous
joint-specific envelope to the actual lagged posterior wave: it is exactly one
outside the established `2.10L` approach region, but near the target it
withdraws a bounded fraction of posterior oscillatory excursion only when
target-course alignment is poor and observed body turn rate is appreciable.
It leaves the anterior carrier and mean posterior curvature untouched, so this
is terminal propulsion/steering allocation rather than a shared cadence cut or
scalar-only gain change.

The expected signature is unchanged pre-approach closure and wake class, with
lower near-target yaw/velocity misalignment, a shorter path, and capture no
later than the route-efficient comparators unless the improved alignment also
improves the distance integral. Falsify the mechanism if the trajectory moves
before `2.10L`, capture is lost or materially delayed, score/mean distance
regresses, posterior limit residence merely migrates to the anterior joint,
terminal alignment/yaw/path do not improve, reflection symmetry fails, or
either visual wake view loses coherence.

bookshelf_consulted: true
source_domain: terminal capture staging in fish and sensor-modulated robotic-fish oscillators, together with Lighthill-style posterior reactive propulsion
source_mechanism: preserve a posteriorly emphasized traveling wave for transit, then reduce excess posterior oscillatory excursion during a poorly aligned high-yaw terminal approach without removing mean steering or the anterior carrier
transferable_invariant: separate the propulsive carrier from terminal stabilization and condition only the actuator contribution responsible for excess lateral momentum using observed approach, alignment, and turn state
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: form bounded gates from normalized target distance, body-frame velocity-to-target alignment, and observed turn rate, and use their product only to envelope the lagged posterior wave target while preserving the two-joint state-feedback oscillator and mean curvature
falsification: reject if pre-approach behavior changes, capture or sampled-best mean distance is lost, terminal path/alignment/yaw does not improve, actuator pressure migrates without benefit, reflection fails, or either coherent wake view deteriorates

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account, so the checker agent
  could not start. Running its immutable checks directly exposed a duplicate
  assigned-parent marker in the rendered workspace `README.md`; removing only
  that duplicate preserved the parent selection. The rerun passes the material
  guidance check, and the repository boundary check passes with only the
  allowed active candidate changed under `solver/`.
- No Julia executable or `juliacall` runtime is installed, so the checker's
  exact Julia load probe could not run. Its deterministic schema condition was
  checked directly: every `params.FIELD` reference is present exactly once in
  `target_policy_params`, delimiters balance, and the candidate remains
  non-empty. The executable diff from the evaluated parent is confined to the
  new posterior-wave authority, its two owned parameters, and its wiring.
- Replaying the new gate over the parent's recorded trajectory with logged
  instantaneous yaw as a conservative proxy gives authority exactly `1.0` for
  all `2881` samples at or beyond `2.10L`; inside the approach it has mean/min
  authority `0.9015/0.7485` and is below `0.95` for `60.15%` of samples. Focused
  probes return exactly `1.0` outside approach, at full course alignment, and
  at zero yaw, while a mirrored state preserves the scalar authority and flips
  the lagged wave target. These are contract and activation checks, not CFD
  evidence; EvE must evaluate the capture prediction after this worker exits.
