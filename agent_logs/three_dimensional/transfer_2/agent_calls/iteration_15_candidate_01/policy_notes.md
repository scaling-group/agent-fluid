# Evaluated braking-reserve candidate

## Evidence diagnosis before the policy edit

- The four sampled solver examples are byte-identical v27 course-preview
  policies. They also have byte-identical combined keyframes and reproduce one
  deterministic capture at `24.5795T`, minimum/final distance `0.746968L`,
  mean distance `2.36044L`, and score `-0.460673`; they are replication of one
  useful controller mechanism, not four independent improvements. Diagnostics
  confirm direct uniform still-water initialization with `U_infinity=[0,0,0]`,
  no cylinders, no prewarm, finite dynamics, and inertial moving-window
  transport.
- Both visual rows were inspected for the sampled capture, the inherited
  braking-reserve capture, and the inherited active-brake failure. In the
  top-down views all three are self-propelled from quiescent water and retain a
  coherent alternating wake along the common early diagonal. The successful
  policies redirect before passage and cross the capture circle near `24.6T`.
  The failed active brake passes outside at `0.913L`, continues its turn until
  the fish is nearly vertical, and exits the virtual domain at `36.872T`.
  Oblique Lambda2 views show compact three-dimensional structures through the
  successful redirects and the failed near pass, so passive advection, wake
  breakup, and numerical instability do not explain the semantic difference.
- The inherited v31 predictive stroke guard retains capture at `24.5960T`, but
  its earlier allocation blend does not improve posterior hard-stop, any-joint
  rate-limit, or applied acceleration-limit exposure
  (`12.63/15.14/72.74%`). It does reduce peak absolute body-frame
  force/yaw-moment coefficients to `0.149/0.097/0.0667`, making prediction
  useful for load shaping but not sufficient constraint protection.
- The completed v32 braking-reserve filter is the strongest physical result.
  It preserves the established trajectory and capture at `24.6290T` and
  `0.748702L` with mean distance `2.36161L` and score `-0.462093`, eliminates
  posterior hard-stop occupancy (`12.63%` to `0%`), and lowers peak absolute
  body-frame force/yaw-moment coefficients again to
  `0.0241/0.0303/0.0149`. Any-joint rate-limit exposure remains essentially
  unchanged at `15.16%`, split between the anterior carrier (`9.36%`) and
  posterior joint (`5.81%`); the result supports a stroke reserve, not a claim
  that all actuator saturation is solved.
- The nearby active-brake sibling is a concrete negative control. Its
  route-gated, fixed-15-percent braking budget nearly removes hard-stop
  occupancy (`0.045%`) but loses capture, leaves the domain at `6.522L`, and
  scores `-7.5700`. Together with the completed conditional handoffs and
  downstream-equivalent output clip in inherited logs, this rules out another
  phase handoff, weak braking scalar, or output-only saturation edit. The
  command-selective braking reserve should be preserved exactly rather than
  combined with an unevaluated rate governor that would reshape the proven
  carrier on every beat.

## Policy hypothesis

Replace the prefilled v27 course-preview policy with the already completed v32
predictive braking-reserve controller. Preserve the course-preview route
request, state-feedback traveling-wave carrier, predictive posterior guard,
and command-selective reserve as one compatible mechanism stack. The reserve
uses posterior angle and outward rate to estimate stopping stroke, passes
unconstrained and inward-recovering motion unchanged, and replaces only an
insufficient near-boundary posterior command with bounded inward deceleration.
This is a materially different candidate from the prefill, but it does not add
an unsupported scalar or a new switching surface beyond the evaluated policy.

Expected evidence: reproduce capture and the common far trajectory while
retaining zero posterior hard-stop occupancy and the v32 low-load class.
Falsify this selection if the new formal rollout loses capture, materially
changes the pre-passage redirect, exhibits any posterior hard-stop occupancy,
or returns peak force/moment toward the v31 class. Do not reject it solely for
unchanged rate-limit exposure; that remains a separate carrier-design problem
for a later candidate with evidence that it can preserve capture.

## Bookshelf transfer

The shelf was consulted after the current metrics and both visual views. Its
sensor-modulated rhythmic-control and elongated-body posterior-thrust
guardrails support the completed command-selective reserve and argue against
disturbing the coherent carrier merely to tune a scalar saturation statistic.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body reactive swimming
source_mechanism: preserve a posterior traveling wave while proprioceptive feedback reserves finite actuator stroke for continued reactive thrust
transferable_invariant: modify rhythmic actuation only when measured joint position and outward momentum predict a constraint conflict, while passing unconstrained and recovery motion through
nontransferable_details: published gains, motor curves, dimensional cadence, species-specific kinematics, full-body envelopes, exact vortex phases, and task-specific routes
policy_translation: use normalized posterior joint angle, outward rate, the owned soft-stroke band, and the owned acceleration envelope to replace only insufficient near-boundary commands with mirror-equivariant inward braking
falsification: reject if capture or far-path topology is lost, posterior hard-stop occupancy returns, or the low force and yaw-moment class is not preserved

## Pre-evaluation validation

- The candidate is byte-identical to the completed v32 braking-reserve policy
  whose inherited evaluation supplies the selection evidence.
- The required public-contract smoke state returns two finite accelerations.
  All `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`. Direct reserve probes are
  mirror-equivariant and pass inward-recovering motion unchanged.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its three prescribed no-CFD commands were
  therefore run directly and separately: the reusable-guidance semantic
  check, Julia contract check, and solver editable-boundary audit all pass.
  The semantic check initially exposed a duplicate identical assigned-parent
  marker in the rendered workspace README; removing only that duplicate made
  parent selection unambiguous. No formal CFD was run.
