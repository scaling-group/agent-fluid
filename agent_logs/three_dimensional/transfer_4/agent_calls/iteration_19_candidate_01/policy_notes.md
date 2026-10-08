# Terminal-only separation of steering from posterior reserve work

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance and inherited rollout, all four sampled
  policies, scores, observations, metrics, diagnostics, and trajectories, and
  both the top-down vorticity and oblique Lambda2 rows of the combined sheets.
  Every sampled rollout and the parent rollout is a stable capture from direct
  uniform still water with `U_infinity=(0,0,0)`, no prewarm, and no cylinders.
  The fish self-propel from rest; the top-down views show a coherent alternating
  wake and the oblique views show compact posterior vortex structures through
  capture. The useful distinction is closure and route control, not wake
  existence or passive advection.
- The phase-consistent combined-target guard is the sampled leader, reproduced
  twice at score/mean distance `-0.064599/1.950823L`. It retains the best
  first-`3T` distance/speed (`12.214593L/0.2519U`), but captures at `18.0125T`
  on a `13.2330L` path with near/final course alignment only
  `0.6637/0.0678`. The consensus reserve captures sooner and straighter at
  `17.7870T/12.9495L` with `0.8366/0.2863` alignment, but gives up the early
  carrier response and regresses to `-0.073937/1.959602L`.
- The assigned parent's carrier-energy interpolation was an informative failed
  hypothesis. It retained the leader's first-`3T` response
  (`12.214601L/0.2517U`) and improved arrival/path/near alignment to
  `17.9960T/13.1056L/0.7217`, but regressed score/mean distance to
  `-0.073525/1.959839L`. Its mean distance was already worse than the leader
  in every post-start window: `10.4723` versus `10.4470L` over `3--8T`,
  `7.0427` versus `6.9551L` over `8--12T`, `3.6832` versus `3.5913L` over
  `12--16T`, and `1.3542` versus `1.2960L` thereafter. The visual wake and
  capture class remained intact. Carrier recovery therefore does not identify
  a safe far/middle boundary for removing steering from the posterior-work
  phase reference.

## Policy hypothesis

Start from the sampled-leading phase-consistent policy, including its odd
body-frame curvature map, traveling wave, posterior emphasis, route observer,
approach handoff, half-cycle steering, closure-qualified reserve, and
reversal-preserving rate governor. Keep the full wave-plus-steering target as
the posterior-work phase reference throughout far and middle transit. Only
inside the already established normalized approach region, smoothly withdraw
mean steering from that *extra-work phase reference* as distance closes. The
actual mean-curvature target, base traveling wave, cadence, and steering
accelerations remain unchanged. This is a terminal allocation change, not a
new gain or a global route stage.

Because the new authority is exactly one outside `2.10L`, it should preserve
the leader's early and middle closure. Near capture it should prevent reserve
work from being admitted merely because the mean bend offsets posterior
tracking error, moving arrival/path and course alignment toward the separated
comparators without their transit-distance cost. Falsify this mechanism if
far/middle trajectories differ from the sampled leader, score or mean distance
loses its advantage, terminal alignment/path does not improve, capture or
reflection behavior fails, actuator/load class worsens, or either visual wake
view loses coherence.

bookshelf_consulted: true
source_domain: terminal capture staging in fish and robotic-fish feedback, combined with Lighthill-style posterior reactive propulsion
source_mechanism: preserve posteriorly emphasized traveling-wave work during transit, then separate surplus rhythmic work from slower mean steering during close capture
transferable_invariant: a propulsive carrier and its route bias may be coordinated while closure is built, but extra work should be partitioned from mean turning when observed target distance enters the terminal regime
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: use the existing normalized body-frame distance approach gate to fade mean curvature only from the posterior reserve-work phase reference, while leaving the two-joint wave target and steering command unchanged
falsification: reject if pre-approach closure changes, sampled-best mean distance is lost, terminal arrival/path/alignment does not improve, loads or saturation worsen, reflection fails, or either coherent wake view deteriorates

## Lightweight validation

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account, so the checker agent did
  not start. Running its commands locally gives PASS for the material-guidance
  check and repository boundary check. The guidance check initially exposed a
  duplicate assigned-parent marker in the rendered workspace `README.md`;
  removing only that duplicate left the parent selection unchanged.
- The deterministic schema guard passes: every direct `params.FIELD` reference
  names a unique field returned by `target_policy_params()`. A diff against the
  evaluated phase-consistent leader confirms that executable changes are
  confined to the terminal phase-reference authority and its wiring; all base
  drive, steering, guidance, and actuator-envelope expressions are preserved.
- The check-runner's Julia load command could not execute because no `julia`
  binary is installed or discoverable in this workspace or shell. This is an
  environment limitation rather than CFD evidence; the candidate remains for
  EvE's post-worker evaluation.
