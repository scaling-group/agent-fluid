# Slip-confirmed moment-to-yaw handoff

## Evidence diagnosis before the policy edit

- All four allocated solver examples satisfy the frozen Phase 2 contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. No failed-termination
  sheet is allocated, so the weaker finite captures and inherited completed
  regressions are the informative negative controls.
- I inspected the combined sheets for the strongest sampled policy
  (`solver_1a8c73736b49`) and the assigned-parent/weakest outcome
  (`solver_2acfcfa19ef8`) from release through capture. Both top-down rows show
  a release transient growing into a coherent alternating caudal wake behind
  a smooth target-directed arc. Since the reported background flow is exactly
  zero, the translation is self-propulsion rather than advection. Both oblique
  body/Lambda2 rows retain compact alternating three-dimensional structures;
  neither shows wake collapse, collision, domain exit, or out-of-plane
  instability. The wake topology is effectively indistinguishable at sheet
  resolution, so response allocation and route metrics—not vortex prominence—
  decide the next mechanism.
- The assigned parent and a different translational-terminal source are
  trajectory-identical at `15.735508T`, distance integral `1.919818L`, final
  distance `0.744372L`, `231` window shifts, and score `-0.037222`. This
  repeats the inherited negative result that another terminal line-of-sight
  rewrite is not physical trajectory diversity.
- The sampled translational-response persistence policy is a positive
  route-scale result. Keeping the existing `2 deg` supplemental correction
  available while normalized target-line translation remains adverse advances
  all `8/6/4/2/1.25L` milestones, captures at `15.686007T`, lowers the
  distance integral to `1.916135L`, uses `226` shifts, and improves score to
  `-0.033442`. The coherent two-view wake is preserved. Posterior
  acceleration-limit residence also falls from `23.59%` to `22.34%`, although
  peak axial force and moment rise from `0.02435/0.01920` to
  `0.02656/0.02036`; the gain is therefore route response, not uniform load
  relief.
- The independently sampled yaw-response handoff is positive but weaker: it
  captures at `15.713508T`, reaches integral `1.917987L`, and scores
  `-0.035331`. It advances the `6/4/2/1.25L` milestones versus the parent but
  does not match translational persistence. The inherited odd-cubic carrier
  veto and moment-plus-lateral-force consensus extensions both delayed the
  route despite retaining a coherent wake. These controls reject another
  fitted carrier classifier, another corroborating-load increment, and any
  scalar-only curvature increase.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG direction control
source_mechanism: apply bounded anticipatory steering for adverse target-relative response, then hand it continuously to measured target-aiding yaw without interrupting the propulsive rhythm
transferable_invariant: preserve the traveling-bend carrier and direct target-relative response backstop; release only the hydrodynamic-moment share of supplemental curvature after an aiding body response appears, while automatically reopening it if either adverse slip or missing yaw response indicates unfinished redirection
nontransferable_details: published gains, dimensional rates or moments, species-specific burst kinematics, exact tail-beat or vortex phase, clock-defined maneuver stages, source wake geometry, world coordinates, and task-specific routes
policy_translation: start from the sampled translational-persistence envelope; form target-aiding yaw from the existing carrier-demodulated normalized heading rate, attenuate only the moment-opposition component, and smoothly union the remainder with the independently measured body-frame translational-slip opposition gate inside the unchanged reliable route envelope and `2 deg` ceiling
falsification: reject if capture or any established milestone regresses, distance integral worsens, the coherent two-view wake or force envelope degrades, posterior limiting grows without route benefit, or the handoff changes no feasible posterior action and merely reproduces translational persistence

## One candidate hypothesis

Produce exactly one candidate by preserving the sampled best policy's anterior
oscillator, posterior traveling wave, axial-force response allocator,
target/course steering, base redirect, approach and terminal shaping,
mean-first allocation, and exact actuator projection. Adopt its evidenced
body-frame translational-slip persistence inside the existing moment-correction
ceiling. Within that shared envelope, apply the separately positive handoff
only to the moment-residual share: carrier-demodulated target-aiding yaw reduces
that anticipatory share, but never suppresses the direct slip backstop.

This is a response hierarchy, not a gain increase. Adverse target-line
translation retains bounded correction even when yaw is momentarily aiding;
when slip clears, measured aiding yaw can release residual moment duty; loss of
the aiding response restores it continuously. The falsifiable expectation is
to preserve the translational-persistence policy's earlier route while avoiding
some redundant moment curvature, improving an established milestone, distance
integral, or force/limit exposure without sacrificing capture or wake
coherence. Formal CFD remains post-exit evidence, so no outcome for this
candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `01e07549593eca792bca1896d94eea9c5cd52dbf9bd76bbc1b1c5b6bd1b339f4`.
  Static schema validation finds exactly `57` fields returned by
  `target_policy_params()` and the same `57` direct `params.FIELD`
  references, with no missing or unused controller parameter.
- The prescribed lightweight Julia contract returns two finite accelerations,
  guidance materiality passes, and the solver editable-boundary check passes.
  A deterministic sweep of `5,000` mirrored state pairs spans target side and
  distance, joint state, body-frame translation, force, moment, and yaw/line-
  of-sight response. All actions remain finite and within the declared
  acceleration bound, with exactly zero lateral-reflection error.
- Against the sampled-best translational-persistence policy, the deterministic
  sweep changes feasible action on `322/5,000` states by up to
  `2.71336 rad/T^2`. Counterfactual evaluation on reconstructed sampled-best
  trace states changes only the posterior action on `85/2,852` states over
  `0.5665-13.8655T`, with mean/max changed magnitude
  `0.0649/0.5810 rad/T^2`. One reconstructed state reaches the posterior
  acceleration ceiling where the comparator does not; the formal rollout
  must therefore decide whether the response handoff improves the route
  rather than assuming it is pointwise actuator relief.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its exact three prescribed commands were
  run directly and then independently rerun through an available checker;
  guidance materiality, Julia policy contract, and solver boundary all report
  `PASS`. No CFD was run.
