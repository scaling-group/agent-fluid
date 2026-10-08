# Translationally protected yaw-response handoff

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase 2 evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. No failed-termination
  sheet is allocated, so the two weaker but finite moment-only captures and
  inherited closed-loop regressions are the informative negative controls.
- I inspected the combined and view-specific sheets for the best finite
  translational-persistence policy (`solver_1a8c73736b49`) and the weaker
  moment-only policy (`solver_2acfcfa19ef8`) from release through capture. In
  both top-down rows, the release transient develops into a coherent
  alternating caudal wake behind a smooth target-directed arc; zero background
  velocity makes the translation self-propulsion rather than advection. Both
  oblique body/Lambda2 rows retain compact alternating three-dimensional
  structures without breakup, collision, domain exit, or out-of-plane
  instability. The sheets differ below topology-level visual resolution, so
  route, action, and load histories decide the mechanism comparison.
- The moment-only control and translational-terminal variant have distinct
  source hashes but byte-identical trajectories and wake sheets: capture at
  `15.735508T`, final/minimum distance `0.744372L`, distance integral
  `1.919818L`, `231` shifts, and score `-0.037222`. This independently repeats
  the inherited negative result that another terminal translational damping
  rewrite does not create trajectory diversity on this route.
- Keeping the same `2 deg` moment-response correction available while direct
  body-frame target-line translation remains adverse advances every
  `8/6/4/2/1.25/0.9L` milestone, captures at `15.686007T`, lowers the distance
  integral to `1.916135L`, and improves score to `-0.033442`. It also reduces
  posterior acceleration-limit residence from `23.59%` to `22.34%`, although
  mean posterior demand rises from `25.012` to `25.199 rad/T^2` and peak yaw
  moment rises from `0.01920` to `0.02036`; the route benefit, rather than load
  relief alone, supports the mechanism.
- The assigned parent's target-aiding yaw-response handoff is separately
  positive against the duplicated moment-only baseline. It preserves capture
  and advances the `6/4/2/1.25/0.9L` milestones, reaches at `15.713508T`, lowers
  the distance integral to `1.917987L`, and scores `-0.035331`. But it is weaker
  than translational persistence, so realized aiding yaw is not sufficient by
  itself to declare the target-line response corrected.
- Counterfactual reconstruction on the winning trace shows the proposed
  hierarchy is not clamp-equivalent: protecting the persistence gate while
  importing the sampled yaw handoff would reduce moment-response curvature on
  about `669` recorded states from `0.605T` through `15.219T`, with a maximum
  mean-curvature change near `0.40 deg`. This is action-support evidence only;
  it does not predict the unevaluated closed-loop result.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG steering
source_mechanism: sustain bounded curvature through adverse target response, then hand authority back to the propulsive rhythm when measured turning response is genuinely useful
transferable_invariant: preserve the traveling-bend carrier and target-defined turn while direct body-frame target-line slip protects needed steering persistence; release only supplemental mean curvature when carrier-demodulated yaw aids the target and the translational response no longer opposes the redirect
nontransferable_details: published gains, dimensional yaw and slip rates, species-specific burst kinematics, exact tail or vortex phase, clock-defined stages, world coordinates, and task-specific routes
policy_translation: start from the sampled translational-persistence controller, retain its smooth union of moment and normalized translational response inside the existing 2 degree ceiling, and apply the sampled target-aiding yaw handoff only to the portion not protected by adverse translational response
falsification: reject if capture or any established milestone regresses, distance integral or final crossing worsens, the coherent two-view wake or force envelope degrades, posterior limiting grows without route benefit, or the hierarchy changes no feasible posterior action

## One candidate hypothesis

Produce exactly one candidate by starting from the sampled winning
translational-response policy and preserving its anterior oscillator, posterior
traveling wave, axial-force allocation, target/course navigation, approach and
terminal shaping, mean-first acceleration allocation, and exact actuator
projection. Add only the assigned parent's already evaluated response-handoff
mechanism, but make it subordinate to direct adverse target-line translation:
carrier-demodulated target-aiding yaw releases the bounded moment correction
only as the translational opposition gate closes. This combines two positive
response mechanisms without adding curvature, changing its target-defined
sign, introducing a new scalar, or altering the base carrier.

The falsifiable expectation is that yaw handoff removes unnecessary
moment-response curvature during the winning route without surrendering its
translational persistence, advancing at least one milestone or the crossing
relative to `solver_1a8c73736b49` while retaining capture and wake coherence.
Formal CFD occurs only after this worker exits, so no outcome for this
candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `87c1dede443cdde1bf61b6bf6922ae90eeb485088cdbade8a5e8ed0775ad93d4`.
  Static schema validation resolves exactly 57 direct `params.FIELD`
  references against the same 57 fields returned by
  `target_policy_params()`, with no missing or unused parameter.
- The prescribed lightweight Julia contract returns two finite accelerations.
  A deterministic 10,000-pair sweep across mirrored body-frame target
  geometry, translation, loads, joint state, bearing response, and yaw
  response returns finite actions within the declared acceleration bound with
  zero lateral-reflection error. Six non-finite observation probes also select
  finite fallbacks.
- Guidance materiality and the solver editable-boundary check pass. The first
  materiality run exposed two identical assigned-parent markers in the
  rendered workspace `README.md`; removing only the duplicate marker repaired
  that inherited metadata defect.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported for this account, matching the inherited infrastructure
  limitation. Its three prescribed checks were therefore run directly and
  separately. No formal CFD was run.
