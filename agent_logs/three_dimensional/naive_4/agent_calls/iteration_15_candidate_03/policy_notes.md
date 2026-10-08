# Capture-corridor aiding-lobe wave restoration

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct, uniform still-water contract:
  `initialization_mode=uniform_direct`, `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. I inspected both the top-down vorticity and oblique Lambda2
  rows in every combined keyframe sheet. Each fish self-propels from quiescent
  water, forms a coherent alternating red/blue street by about `4T`, retains
  compact three-dimensional posterior wake structures, turns toward the
  target, and captures without collision, domain exit, or numerical
  instability. The sheets are visually almost indistinguishable, so the
  informative contrast is the measured closing-approach response rather than
  an unsupported visual attribution.
- The sampled-best `solver_5187bb13ebc0` releases only anterior approach
  damping when a reliable closing course lies inside the capture corridor;
  posterior approach wave attenuation remains active. It captures at
  `16.054512T`, reaches the shared `8/6/4/2L` milestones at
  `9.201503/11.153998/13.013008/14.905006T`, has mean/held distance
  `1.938857L`, final distance `0.744345L`, and score `-0.055617`.
- The assigned parent `solver_736250db9a8b` differs from that best sample only
  by letting the same corridor release posterior wave attenuation as well as
  anterior damping. It has the same milestones and capture time, but regresses
  to mean/held distance `1.939710L`, final distance `0.745354L`, and score
  `-0.056672`. Its approach posterior acceleration-limit residence is
  `29.24%` versus `23.98%` for the anterior-only sample, while full-episode
  posterior acceleration- and speed-limit residence rise from
  `22.47/6.20%` to `22.78/6.27%`. This is closed-loop factorial evidence that
  restoring the complete posterior wave in an intercept corridor dilutes the
  benefit of anterior energy release; lower mean posterior action alone is
  not evidence of better allocation.
- The other samples reinforce the control boundary. Attenuating mean redirect
  in `solver_3b5e36735c7f` preserves the `16.049T` capture but scores only
  `-0.056973`, so a safe projected miss does not make target-directed steering
  redundant. The pre-limit posterior wave guard in
  `solver_29c7c83f8e3e` lowers limiting and peak load but delays milestones,
  captures at `16.071T`, and scores `-0.057037`; cosmetic headroom is not worth
  route regression. The current edit therefore preserves mean curvature,
  anterior corridor release, exact-limit projection, and all far/middle
  commands.

## Policy hypothesis

Start from the evaluated anterior-only corridor release. Add one compact
half-cycle allocation mechanism only to the posterior wave amplitude that
approach settling would otherwise suppress. Inside a reliable, closing capture
corridor, infer the instantaneous traveling-wave lobe from posterior wave state
and compare its reflection-odd sign with the existing target-directed steering
sign. Restore suppressed wave amplitude continuously only on the aiding lobe;
the opposing lobe retains the sampled-best attenuation, and neither lobe may
exceed the established cruise carrier. Mean steering, anterior damping release,
redirect gating, and acceleration allocation remain unchanged.

This isolates whether the assigned parent's full wave restoration failed
because it restored an unhelpful half-cycle. Expect the sampled-best coherent
wake and route with no pre-approach action change, less approach posterior
limit residence than the assigned parent, and either earlier capture or a
smaller held/final distance than the anterior-only sample. Falsify the
mechanism if it changes commands outside the reliable closing corridor,
restores the opposing lobe, alters mean curvature, breaks lateral-reflection
equivariance, loses wake coherence or capture, delays any milestone, or fails
to improve route metrics while increasing saturation or load.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning with asymmetric flapping and closed-loop amplitude modulation
source_mechanism: preserve a propulsive traveling-wave carrier while sensor feedback allocates rhythmic amplitude preferentially to the turn-aiding half-cycle
transferable_invariant: when complete terminal wave restoration is harmful, retain opposing-lobe relief and restore only the bounded rhythmic component whose observed joint-state phase agrees with the target-directed bend
nontransferable_details: published gains, motor dynamics, species-specific envelopes, dimensional frequencies, prescribed oscillator or vortex phases, exact capture radii, and task-specific routes
policy_translation: combine the existing reflection-odd steering sign with normalized posterior wave state to form a reflection-even aiding-lobe gate; inside the normalized body-frame closing/intercept gate, restore only approach-suppressed posterior amplitude and retain all mean steering and cruise bounds
falsification: reject if any far-field or mean-steering command changes, the opposing lobe is restored, reflection symmetry fails, posterior limiting or loads rise without route benefit, or the coherent wake, milestones, capture, score, or held distance regress

The candidate has no same-worker CFD evidence. Fixed-trace replay can establish
locality, branch semantics, bounds, and symmetry; only the later EvE rollout
can establish a wake or trajectory improvement.

## Non-CFD verification after the policy edit

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. I ran its three
  prescribed commands separately instead. The guidance check initially found
  the same duplicated assigned-parent marker present in inherited rendered
  workspaces; removing only that duplicate made the material guidance check
  pass. The lightweight Julia contract and solver editable-boundary check also
  pass. No CFD was run.
- Replay on all `2,919` sampled-best states changes exactly 20 posterior
  commands between `1.626L` and `0.772L`; every anterior command and every
  command outside the `1.75L` closing approach is exact. On the same states,
  each changed command lies between the evaluated anterior-only and full-wave-
  restoration commands, with maximum posterior difference
  `4.891 rad/T^2`. Fixed-trace mean posterior action is
  `24.8927/24.8834/24.8850 rad/T^2` for anterior-only/full/aiding-lobe
  restoration, respectively, and approach posterior acceleration-limit rows
  are `41/40/40`. These establish bounded interpolation and locality, not a
  closed-loop improvement.
- Static schema inspection finds `35` direct `params.FIELD` references and all
  `35` fields are returned by `target_policy_params()`. A deterministic
  `54,675`-state sweep spanning both target sides, body-frame velocity, joint
  state, and exact speed boundaries returns finite bounded actions, no outward
  command at either exact speed limit, and zero lateral-reflection error.
