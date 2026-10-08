# Reciprocal startup phase coordination

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, inherited optimizer notes and evaluated
  artifacts, all four sampled solver policies, scores, observations, metrics,
  diagnostics, and trajectories. I also inspected both rows of the strongest
  and most informative underperforming combined keyframe sheets. Every current
  rollout is a stable capture from direct-uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders. In both sheets the fish
  self-propels from rest: the top-down row develops a coherent alternating
  vorticity street and the oblique row retains compact three-dimensional
  posterior Lambda2 structures through capture. Gross wake formation, passive
  advection, and instability therefore do not distinguish the policies.
- The combined wave-plus-steering posterior-work guard is the deterministic
  sampled leader: two byte-identical policy artifacts capture at `18.0125T`
  with score/mean distance `-0.064599/1.950823L`, first-`3T` mean
  distance/speed `12.214593L/0.2519U`, and peak planar force/yaw moment
  `0.0391/0.0195`. Its cost is a `13.2330L` center path, `0.7417L` maximum
  head cross-track, and only `0.6637/0.0678` near/final course alignment.
  The unguarded comparator arrives sooner and follows a narrower
  `13.0071L/0.6102L` route, but worsens score/mean distance to
  `-0.072146/1.958037L`.
- Three completed phase-reference continuations now provide a concrete
  negative boundary. Full wave/steering separation retains capture and route
  quality but weakens startup speed to `0.2469U` and regresses score/mean
  distance to `-0.080637/1.966422L`. Carrier-energy interpolation retains the
  startup response and modestly improves path/alignment, yet still regresses
  to `-0.073525/1.959839L`. Terminal-only separation uses a distinct policy
  artifact but byte-reproduces the leader's trajectory and both-view sheet,
  including every score, arrival, path, and load metric. Same-trajectory
  screening explains that no-op: the closure/carrier reserve exceeds `0.01`
  only during approximately the first `1.84T` and is effectively zero inside
  the `2.10L` approach region. Later workers should not retry another selector
  on the same reserve-work phase reference without first showing that it has
  authority where the selected observation acts.
- During the active startup reserve, the zero-mean posterior wave tracking
  error has normalized RMS about `1.13`, while posterior motion is on average
  directed toward that target. The current architecture is one-way: the
  posterior joint tracks an anterior-derived lagged target, but its observed
  phase error cannot correct the anterior oscillator. This leaves a distinct
  coordination mechanism to test without altering the successful combined
  work guard, route law, mean curvature, cadence, or approach controller.

## One policy hypothesis

Add a small bounded reciprocal phase-error term from the posterior joint to
the anterior oscillator only while the existing carrier/closure reserve is
active. The error is the normalized difference between the zero-mean lagged
posterior wave target and measured posterior angle. Its sign is mapped through
the local coupling geometry: if the posterior angle lies below its wave target,
a positive anterior correction moves that target back toward the observation,
and reflection reverses the entire correction. A `tanh` bound and the existing
normalized reserve gate keep this a state-feedback phase coordinator rather
than a second clock or a prescribed vortex phase.

Expected result: reciprocal coordination should retain capture, the sampled
leader's early/mean-distance class, and the coherent two-view wake while
reducing the route-width and alignment penalty left by one-way posterior work.
Reject it if first-`3T` speed or mean distance regresses toward the fully
separated result, path/cross-track and approach alignment do not compensate,
capture or reflection behavior fails, force/moment or actuator-limit class
rises, or either visual wake view loses coherence.

bookshelf_consulted: true
source_domain: robotic-fish coupled-oscillator control and classical traveling-bend propulsion
source_mechanism: reciprocal state-feedback phase coordination around a posteriorly lagged traveling wave
transferable_invariant: when one joint supplies the rhythmic reference for a lagged propulsive joint, bounded feedback of observed phase error can coordinate the pair without changing mean steering or introducing an external clock
nontransferable_details: published CPG gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, and task-specific routes
policy_translation: feed the normalized zero-mean posterior wave tracking error back to anterior acceleration through a bounded odd term, gated by the existing normalized carrier/closure reserve, while preserving the two-joint contract and body-frame target controller
falsification: reject if early or mean-distance closure degrades, route metrics do not improve, capture or reflection fails, loads or saturation rise, or the coherent top-down and oblique wake class deteriorates

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account, so the checker agent
  could not start. Running its prescribed commands directly gives PASS for the
  material-guidance check and PASS for the solver repository boundary check.
- The check-runner's Julia contract command cannot execute because no `julia`
  binary is installed or discoverable in this workspace shell. The
  deterministic static schema guard passes: all 61 direct `params.FIELD`
  references name fields among the 63 unique values returned by
  `target_policy_params()`, including the new coupling gain.
- A focused algebraic check confirms that the added coupling term is finite,
  bounded by its parameterized acceleration scale and reserve authority, and
  odd under reflected anterior/posterior joint angle and rate. A diff against
  the evaluated leader confines executable changes to this reciprocal startup
  feedback and its owned parameter/diagnostics. These are contract checks, not
  CFD evidence; the rollout hypothesis remains unvalidated until EvE evaluates
  the candidate after this worker exits.
