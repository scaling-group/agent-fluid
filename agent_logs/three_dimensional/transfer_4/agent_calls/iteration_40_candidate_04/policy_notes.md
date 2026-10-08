# Candidate hypothesis: relative-flow-gated posterior startup boost

## Evidence and visual diagnosis before editing

- The four sampled solver directories are exact repeats of the v31 policy,
  trajectory, score (`-0.064000433`), and `18.0125T` capture. Each reports
  direct uniform quiescent initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, and 251 moving-window shifts. Thus the sample set has
  one strong finite behavior, not four independent mechanisms, and contains
  no boundary/numerical failure for a direct visual success/failure contrast.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets from
  release through capture for sampled v31 and for the distinct inherited v32
  carrier-demodulated relief result. Both show self-propulsion from rest, a
  coherent alternating traveling wake that grows behind the posterior body,
  a stable three-dimensional vortex train, target-directed motion, and no
  passive advection, standing reciprocal wiggle, wake breakup, collision, or
  out-of-plane instability. The useful mechanism to preserve is the
  posterior-emphasized traveling bend; the remaining opportunity is not wake
  creation or course polarity.
- Sampled v31 reaches the target with mean/observed distance integrals
  `1.950346/1.336756L`, center path `13.2149L`, and first-`3T` mean
  distance/speed `12.214593L/0.2519U`. Its weak terminal state
  (`0.1297` alignment, `0.8806U` speed, `0.8077 rad/T` absolute yaw) is real,
  but the inherited bank shows that common cadence/amplitude relief,
  anterior-rate relief, posterior positive-work relief, raw course/yaw loops,
  slip-duty, phase reset, and steering redistribution all preserved the wake
  while failing to improve closure and terminal state together.
- The latest inherited v32 test closes the remaining carrier-demodulated
  anterior half-cycle hypothesis. It retained capture and nearly identical
  observed distance integral, but regressed score/final distance to
  `-0.064008829/0.748404L`. Relative to v31 it changed only 47 logged actions
  above numerical equality, with maximum changes of just `0.0363/0.0384
  rad/T^2`; path/cross-track remained `13.2149/0.7327L`, near mean
  alignment/absolute yaw remained `0.6688/1.9538 rad/T`, and near
  acceleration-ceiling residence remained exactly `69.29/75.89%`. A selector
  that looks nonzero in counterfactual replay is therefore not useful if its
  chosen work channel has negligible realized authority after the existing
  oscillator, steering, and envelope composition.

## Single policy hypothesis written before the edit

Preserve v31's evaluated route controller, odd body-frame curvature map,
anterior state-feedback carrier, posterior lag, approach envelopes, conserved
mean bend, course-consensus duty surface, nominal cadence, and reversal-safe
rate governor. Add one startup propulsion mechanism: while the target remains
forward, range is outside the established approach, and normalized body/water
relative-flow speed indicates that self-propulsion is not yet established,
continuously increase only the lagged posterior wave target. Release the boost
as relative speed develops. Do not alter anterior amplitude, cadence, mean
steering, or terminal behavior.

This translation follows the evidence-backed joint roles: posterior priority
previously created the large transit gain, while recent terminal energy edits
only traded closure for prettier final samples. On the completed v31 trace,
the proposed normalized selector is active only during startup and is already
zero after about `3.01T`; a `12%` hard posterior boost gives roughly `3%--12%`
extra target authority during that interval and is exactly inactive at and
inside `2.10L`. The new CFD result is not available in this worker. Accept the
candidate only if first-`3T` speed rises and distance falls while the coherent
two-view traveling wake, capture, route, joint-angle margin, and load class
survive. Reject it if it merely increases posterior limit residence, creates
lateral route error, activates under strong relative inflow/passive advection,
or worsens arrival, distance integral, path, or terminal state.

bookshelf_consulted: true
source_domain: Lighthill-style elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: establish a traveling propulsive wave with posterior emphasis, then release extra posterior authority once sensed body-water relative motion shows that swimming is established
transferable_invariant: use bounded state feedback to concentrate startup work posteriorly without replacing the traveling wave, shared cadence, or body-frame route controller
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, full-body kinematics, initial joint phase, capture radius, target coordinates, and task-specific routes
policy_translation: multiply only the lagged posterior wave target by a small boost gated by normalized relative-flow speed, forward body-frame target geometry, and distance outside the existing approach; preserve anterior state-feedback rhythm and all steering terms
falsification: reject unless the boost is reachable, releases with developed relative speed, improves early closure and arrival or distance integral, and preserves capture, route, coherent two-view wake, joint margin, load class, and reflection symmetry without merely increasing posterior saturation

## Pre-evaluation contract and reachability audit

- Replay of the fully composed v33 and v31 actions on the completed v31 state
  trace gives exact equality on all 2,754 selector-inactive samples. The startup
  selector is nonzero on 514 samples from `0.044T` through `3.0085T`; after
  downstream steering, acceleration clamping, and the rate governor, 258
  actions still change (256 before `3T`). The anterior action remains exactly
  v31, while the posterior action changes by as much as `7.9693 rad/T^2`.
  This is a reachability check on inherited states, not a CFD performance claim.
- Simultaneous lateral reflection leaves the new scalar authority invariant
  and reverses its incremental posterior command to numerical precision. The
  public action remains a finite two-element `phi_ddot` tuple. Formal CFD is
  deferred to the downstream evaluator.
- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account. Running its immutable commands directly with
  the workspace Julia binary passes the guidance-materiality check, executable
  two-joint finite-output contract, and solver editable-boundary check. The
  deterministic schema audit finds all 71 direct `params.FIELD` references in
  the 73 fields returned by `target_policy_params()`, with no duplicates.
