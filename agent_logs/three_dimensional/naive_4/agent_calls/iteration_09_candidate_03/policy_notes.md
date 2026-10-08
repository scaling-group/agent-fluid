# Response-gated terminal wave unloading

## Pre-edit evidence diagnosis

- The assigned parent and all four sampled solvers satisfy the experiment
  contract: direct uniform initialization with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite dynamics, and capture at `0.745-0.748L`.
  Translation is therefore self-propelled rather than imposed advection.
- I inspected the top-down vorticity and oblique body/Lambda2 rows in every
  sampled combined keyframe sheet. All four establish the same useful visual
  scaffold: the body turns down-left, a coherent alternating red/blue wake is
  established by the early frames, and compact three-dimensional structures
  persist behind the traveling bend through capture. No sampled rollout has a
  failure termination; the widest-crossing `-0.066284` capture is therefore
  the most informative underperformer available, while inherited logs supply
  the earlier upper-exit contrast. The present distinction is terminal
  trajectory/control quality, not wake production or termination class.
- Closing-conditioned redirect continuity is the strongest current evidence.
  Relative to the assigned approach-course-weight parent, it improves score
  from `-0.066256` to `-0.063208`, capture time from `16.258T` to `16.225T`,
  mean distance from `1.94978L` to `1.94670L`, and posterior acceleration-limit
  residence from `58.3%` to `21.3%`. It also beats the standalone selective
  relief result (`-0.066121`, `16.258T`, `59.3%` posterior residence). Its
  mean/max planar force coefficients (`0.01559/0.03890`) and mean/max yaw
  moment magnitudes (`0.00793/0.01954`) remain close to the other finite
  captures, and both visual wake rows remain coherent.
- The best rollout leaves a localized, beat-sensitive approach defect. At its
  `1.20L` crossing, body-frame bearing is `+0.035 rad`, course is `-0.621 rad`,
  response error is `+0.613 rad`, and the redirect gate is about `0.92`; the
  posterior joint is at `31.1 deg` while the approach law still admits about
  `82%` of the nominal wave. At `0.80L`, response error temporarily falls to
  `+0.262 rad`, then grows to `+0.465 rad` at capture as course changes from
  `+0.051` to `-0.112 rad`. The strong mean redirect is already active, so a
  still larger static curvature or another course-weight blend is not the
  supported first test. The assigned course-weight blend regressed, while the
  sampled continuity controller shows that preserving the mean bend and low
  actuator residence is valuable.
- Inherited guidance rules out shared anterior bias, two-sided lobe
  amplification, short-window yaw-rate feedback, and full zero-bend holds.
  Those changes either damaged the traveling carrier, retained an exit
  topology, or removed useful mean curvature. The remaining separable test is
  whether the posterior oscillatory component should yield more authority only
  during a reliable, still-misaligned terminal redirect.

## Policy hypothesis

Start from the best sampled closing-conditioned redirect controller, including
its state-feedback carrier, posterior lag, attenuation-only opposing-lobe
relief, approach damping, closing-conditioned redirect onset, and mean-first
posterior acceleration allocation. Add one bounded mode interaction: multiply
the already available approach and redirect gates to identify a nearby,
closing fish whose measured course is still unresolved, and continuously lower
the posterior-wave floor from the evidenced approach floor toward a more
redirect-prioritized floor. The mean-tail tangent is not attenuated, neither
wave lobe is amplified, and the candidate is algebraically identical to the
sampled best policy outside the approach neighborhood or when the redirect
gate releases.

The expected result is the same transit, coherent wake, early milestones, and
low posterior hard-limit residence, with less beat-scale course reversal over
the final `1.2L` and an equal or earlier, better-aligned capture. Falsify the
mechanism if capture is later than `16.225T`, score does not beat `-0.063208`,
the path changes before `1.75L`, terminal response error does not shrink, the
coherent wake weakens, or force/limit residence increases materially.

bookshelf_consulted: true
source_domain: biological burst redirection, sensor-modulated robotic-fish direction tracking, and terminal capture control
source_mechanism: temporarily prioritize observed-error mean curvature over the propulsive wave, then restore the traveling bend continuously as measured course aligns
transferable_invariant: preserve an established traveling-wave carrier in cruise, but let the oscillatory component yield bounded authority during a nearby closing redirect whose observed target-versus-course mismatch remains large
nontransferable_details: species-specific C-start shapes, published gains, dimensional approach ranges, prescribed CPG phases, exact vortex phases, actuator torques, and task-specific routes
policy_translation: normalized body-frame distance and target-aligned velocity form the existing approach gate; multiplying it by the existing course-response redirect gate lowers only the posterior-wave floor while preserving two-joint mean-bend feedback and all hard bounds
falsification: reject if pre-approach behavior changes, capture or coherent wake is lost, arrival or score regresses from the sampled best, terminal mismatch persists, or reduced wave authority increases limiting or hydrodynamic loads

The new candidate has no same-worker CFD evidence. Only deterministic contract,
boundedness, and equivariance checks are claimed before downstream evaluation.

## Non-CFD verification

- The required checker configuration was invoked, but its pinned
  `gpt-5.4-mini` runtime is unavailable in this account. Its three prescribed
  commands were then run directly. Guidance provenance, the Julia policy
  contract, and the solver editable-boundary check all pass. The provenance
  check initially exposed a duplicated rendering of the same assigned guidance
  parent in the workspace `README.md`; removing only the duplicate listing
  restored the unique-parent contract without changing which parent is used.
- A deterministic `19,683`-state sweep over joint state, body-frame target
  bearing/distance, and normalized body velocity produced finite bounded
  actions with exact lateral-reflection sign reversal. All swept states at or
  beyond `1.75L` match the sampled-best controller exactly, while `3,710`
  nearby states exercise the new terminal wave-unloading mechanism.
