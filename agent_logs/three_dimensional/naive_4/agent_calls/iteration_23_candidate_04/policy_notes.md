# Moment-led terminal yaw-response candidate

## Evidence diagnosis before the edit

- All four sampled episodes are valid direct-uniform still-water rollouts with
  `U_infinity=[0,0,0]`, no cylinders or prewarm, finite dynamics, capture at
  `16.054375T`, 2,919 steps, and 239 moving-window shifts. Three independently
  materialized copies of the assigned-parent complementary handoff/damper are
  exactly repeatable at final distance `0.745943L`, distance integral
  `1.929921L`, and score `-0.047001`. The informative contrast is the sampled
  yaw damper without redirect handoff: it captures on the same step at
  `0.746051L`, `1.930012L`, and `-0.047113`.
- I inspected the combined sheets for the best repeated policy and the
  yaw-damper contrast, including the top-down vorticity and oblique
  body/Lambda2 rows. The sheets show the same self-propelled smooth target arc,
  coherent alternating vorticity street, and compact three-dimensional caudal
  structures through capture. There is no passive advection, reciprocal
  standing wiggle, wake breakup, collision, exit, or out-of-plane instability.
  The carrier, redirect sign, posterior traveling wave, and approach scaffold
  should remain unchanged.
- The assigned-parent combination validates the staged terminal interpretation:
  alignment-conditioned handoff of only the high-minus-cruise curvature and
  later corridor-confined yaw damping are compatible, improving the sampled
  damper without changing any distance milestone or arrival time. This is a
  terminal-geometry improvement, not evidence for carrier-gain tuning or a new
  semantic success.
- A remaining response delay is visible in the best trace. From `0.901L` to
  `0.836L`, normalized body-frame yaw moment remains target-signed at roughly
  `0.008-0.011`, while measured yaw changes from `-1.50` to `+0.03 rad/T` and
  body-frame bearing changes from closing to reopening. The existing damper is
  gated by measured target-signed yaw, so this load signal precedes its onset.
  At capture, the policy remains finite and stable with a `0.368L` projected
  miss, `1.038U` closing speed, `0.183 rad` bearing, `3.36 rad/T` bearing rate,
  and `2.09 rad/T` target-signed yaw. Moment is therefore a candidate lead
  observation for the already evidenced terminal response, not a route command.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and wake/load-responsive swimming control
source_mechanism: preserve rhythmic propulsion while normalized sensory load provides a bounded lead correction to slower measured turning response
transferable_invariant: separate the productive traveling-wave carrier from a continuously gated response correction, and use force or moment only to anticipate target-relative response under reliable geometry
nontransferable_details: published gains, species-specific kinematics, dimensional torque scales, exact vortex phases, morphology-specific envelopes, and source-task routes
policy_translation: retain the two-joint carrier and all evaluated steering roles; inside the existing closing predicted-intercept corridor and only while bearing reopens, add a small body-frame yaw-moment lead to normalized measured yaw before computing the terminal posterior mean-curvature damper
falsification: reject if the lead changes pre-corridor milestones, disrupts the coherent two-view wake, delays or loses capture, activates for target-opposing moment, or regresses distance integral, crossing depth, limiting, or loads versus the repeated `-0.047001` parent

## One candidate hypothesis

Add normalized yaw moment as a small lead term to the existing terminal yaw
response, without creating a second steering branch. The moment term is signed
by the current target-directed redirect and affects posterior mean curvature
only when proximity, positive closing, predicted intercept, and bearing
reopening already agree. It cannot alter cruise, the alignment handoff, wave
relief, anterior behavior, or actuator projection. The expected test is an
unchanged route and wake with the same or earlier capture and a smaller
terminal distance integral or deeper crossing, because braking begins during
the observed positive-moment/near-zero-yaw transition instead of waiting for
yaw rate alone. The current worker does not claim this unevaluated CFD result.

## Non-CFD verification after the edit

- Candidate SHA-256:
  `677b9463d09066e5dd01dc973607a7615cc1fbc16a9d904ce09d00af2e116221`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its three prescribed commands were
  run directly and separately instead. The material guidance/notes check,
  Julia policy contract with the deterministic 48-field parameter-schema
  guard, and solver editable-boundary check all pass. The rendered workspace
  README contained the assigned-parent marker twice; the exact duplicate was
  removed so the prescribed guidance checker could resolve the parent.
- A deterministic 93,312-state sweep spanning target side and distance,
  body-frame course, bearing response, normalized yaw moment, yaw rate, and
  joint phase returned finite commands within `31.416 rad/T^2`, exact lateral
  reflection equivariance, a finite non-finite-observation fallback, and no
  outward acceleration at the exact joint-speed boundary.
- Counterfactual replay on the repeated best trace changes only 18 posterior
  commands from `0.848L` through capture, leaves anterior action identical,
  and has a maximum difference of `0.346 rad/T^2` near `0.819L`. This verifies
  bounded terminal support only; it is not a substitute for the later formal
  CFD evaluation.
