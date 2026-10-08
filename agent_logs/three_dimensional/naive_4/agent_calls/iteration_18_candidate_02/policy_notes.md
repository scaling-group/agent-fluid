# Closing-approach release of residual-yaw augmentation

## Visual and quantitative diagnosis recorded before the policy edit

- All four assigned solver rollouts satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics,
  and capture at `16.05448T` and `0.747530L`. Their policy and combined-sheet
  SHA-256 hashes are identical, so the four results are physical replications,
  not four distinct mechanisms.
- I inspected the combined top-down mid-plane-vorticity and oblique
  body/Lambda2 rows for the assigned yaw-opposition carrier and compared them
  with the inherited anterior-only carrier and the signed terminal-curvature
  regression. All show self-propulsion rather than advection: a traveling
  posterior bend establishes an alternating red/blue wake by about `4T`, the
  oblique row retains compact three-dimensional shed structures, and the body
  follows a smooth target-directed arc without collision, boundary exit, wake
  collapse, or instability. The informative contrast is therefore terminal
  control-role allocation within the capture class, not wake topology.
- Relative to the replicated anterior-only carrier, the yaw-opposition
  mechanism advances the `8/6/4/2L` milestones from
  `9.2015/11.1540/13.0130/14.9050T` to
  `9.0750/11.0440/12.9195/14.8005T`, improves the observed distance integral
  from `1.314014L` to `1.303739L`, and raises score from `-0.055617` to
  `-0.048654`, with unchanged capture time and slightly lower mean posterior
  acceleration and limit residence. This repeated evidence supports retaining
  the residual-yaw correction in the far and middle approach.
- Its terminal boundary is also repeated: the crossing is shallower
  (`0.747530L` rather than `0.744345L`), maximum posterior angle rises from
  `0.553` to `0.636 rad`, peak lateral force rises from `0.03193` to
  `0.03321`, and window shifts rise from `229` to `239`. Inherited signed-miss
  posterior centering was worse still (`0.745590L`, `-0.056917` in the
  available sampled run, with the parent log recording its adverse late-route
  response). The evidence does not support adding another terminal posterior
  direction signal.
- Fixed-trace replay shows that a proximity-and-closing taper of only the
  residual-yaw augmentation leaves every command unchanged outside `1.75L`,
  including the full route through the improved `2L` milestone. On inherited
  states it changes `17/89` posterior commands in `1.25-1.75L`, `10/48` in
  `1.00-1.25L`, and all `47` available pre-capture commands below `1.0L`;
  below `0.8L` it removes a mean `7.92 rad/T^2` of extra posterior demand and
  approaches the evaluated
  anterior-only terminal action. This is a pointwise scope check, not a
  closed-loop or CFD result.

## Policy hypothesis

Keep the evaluated state-feedback oscillator, carrier-phase residual redirect
selector, raw target-versus-course direction, one-sided opposing-wave relief,
mean-first posterior allocation, response-subordinate approach settling,
intercept-conditioned anterior damping release, exact speed-boundary
projection, and far/middle residual-yaw opposition. Change one control role:
multiply only `yaw_redirect_curvature` by the complement of the existing
bounded closing-approach gate. Thus extra yaw-response curvature fades as
normalized body-frame proximity and target closing jointly become reliable,
while the established posterior mean steering and wave shaping remain intact.

The falsifiable expectation is to retain the improved `8/6/4/2L` milestones
and coherent two-view wake while preventing a far/middle response correction
from accumulating as excess terminal posterior bend. Reject the mechanism if
capture or an earlier milestone regresses, the final crossing or distance
integral worsens, the alternating wake weakens, or the taper increases
posterior limiting/load despite removing only the augmentation. The new CFD
evaluation occurs after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and biological terminal capture
source_mechanism: preserve rhythmic propulsion and persistent route steering while continuously releasing a transient response correction once reliable target closing establishes the terminal regime
transferable_invariant: separate far/middle disturbance-response authority from terminal target steering, and remove only the auxiliary response term as measured body-frame proximity and closing make it redundant
nontransferable_details: published gains, dimensional distances, species-specific body waves, exact vortex or oscillator phases, source-task capture radii, and task-specific routes
policy_translation: use the existing normalized body-frame proximity-times-closing gate to taper only carrier-residual yaw-opposition curvature; retain raw bearing/course direction, posterior mean curvature, wave relief, and both-joint state-feedback carrier
falsification: reject if the taper acts outside a reliable closing approach, breaks lateral reflection equivariance, alters the route above `1.75L`, loses capture or wake coherence, delays milestones, or worsens terminal distance, limiting, or loads

## Non-CFD verification after the policy edit

- The final candidate SHA-256 is
  `c3ea6f5d610bedaf6cab42b9f740872907503ba93fd4a29fc42c4d2878fc65ad`.
  Static schema inspection finds `41` direct `params.FIELD` references and all
  `41` are returned by `target_policy_params()`.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed commands were therefore run directly and separately. The
  guidance check first identified a duplicated assigned-parent marker in the
  rendered workspace `README.md`; removing only that duplicate restored
  unique provenance. The rerun, lightweight Julia policy contract, and solver
  editable-boundary check all pass.
- A deterministic `59,049`-state sweep over both joint states, exact speed
  boundaries, target side, body-frame velocity, target range, and yaw rate
  returns finite bounded commands, zero same-sign outward acceleration at
  either exact speed boundary, and exactly zero lateral-reflection error.
- Replay from the sampled rollout's rounded state trace reproduces the
  evaluated source actions to `1.26e-4 rad/T^2`. Against those same states the
  new candidate changes no action at or above `1.75L`, changes `74` posterior
  actions below `1.75L`, and leaves every anterior action unchanged. This
  verifies mechanism scope only; no CFD or same-worker outcome is claimed.
