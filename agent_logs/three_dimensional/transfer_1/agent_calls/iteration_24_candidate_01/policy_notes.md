# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled evaluations satisfy the frozen experiment contract:
  direct uniform initialization, `U_infinity=(0,0,0)`, no cylinders, finite
  dynamics, and capture termination. Their motion is self-propelled rather
  than advection from an initialized current.
- Both rows of every sampled combined sheet were inspected. The top-down row
  shows an alternating signed wake from about `4T` through capture, while the
  oblique Lambda2 row shows compact alternating three-dimensional structures
  attached to the traveling bend. The fish translates and turns toward the
  target without collision, wake collapse, or numerical instability.
- The three sampled exact speed-reserve rollouts capture at
  `0.7466--0.7494L` in `18.287--18.601T`; the sampled posterior-pulse rollout
  captures at `0.7480L` in `18.199T`. Their terminal speeds
  (`0.827--0.905L/T`), force and moment ranges, and actuator use overlap.
  Speed-reserve action clamps on about `68.5--68.7% / 70.6--70.7%` of rows
  and exact joint-speed residence is about `10.4--11.6%`.
- The most informative inherited failure is
  `solver_3e2299c57726`, whose policy bytes exactly match the current
  speed-reserve prefill. Its top-down and oblique sheets retain the same
  active alternating wake, but after passing below the target it continues
  self-propelling toward the lower boundary. Metrics confirm a stable
  `left_domain` result after a `1.6441L` closest pass at about `18.216T`, not
  a propulsion or stability failure. A second exact-byte inherited rollout
  repeats the topology after a `1.7276L` pass.
- In the `1.6441L` failure, distance has reopened to `1.660L` by `18.60T`
  and `2.087L` by `20.00T` while speed remains about `0.82L/T`; the normalized
  route error is already at its `1.25 rad` clamp and actions continue to hit
  the acceleration envelope. By contrast, the best sampled exact-byte run
  continues closing monotonically to capture at `18.601T`. Thus the missing
  capability is recovery after an opening near pass, not more far-field
  cadence, another projected-miss route replacement, or carrier suppression.

## Architecture proposal written before the policy edit

Retain the exact evaluated achieved-course/intercept servo, traveling-bend
carrier, phase-independent steering, and conditional outward-carrier reserve.
Add one compact opening-pass burst-redirect module. It is enabled only by the
product of three normalized body-frame conditions: distance is within a near
recovery region, signed closing speed reports that the pass is opening, and
the existing route error is large. While enabled it adds bounded same-sign
mean-curvature acceleration to both joints; closure immediately releases the
extra curvature back into the unchanged carrier. No clock, hidden state,
fixed route, world coordinate, or exact wake phase is introduced.

Expected result: sampled capture trajectories remain on the established
controller because their positive closure keeps the recovery gate zero, while
an exact-byte-style `1.64--1.73L` miss receives a decisive but transient turn
before it can develop into the lower-exit topology. Falsify the mechanism if
it activates during ordinary far-field beat-scale closure fluctuations,
changes the established approach or wake on a closing run, fails to restore
positive closure before the fish leaves the near region, creates a static
bend/coasting wake, increases load or saturation materially, or retains the
same lower-boundary exit.

## Offline gate audit after the edit

Replaying only the new observation gate on prior traces (not claiming a new
CFD result) gives zero recovery activation on every row of the best sampled
capture. On the exact-byte `1.6441L` failure it first becomes nonzero at
`18.287T`, after the pass has begun opening, exceeds `0.1` by `18.337T`, and
reaches full authority during the persistent `1.71--2.25L` departure. This
supports the intended semantic isolation: the candidate preserves the
evidenced closing trajectory while testing recovery specifically on the
failure topology. Formal closed-loop falsification remains the next CFD run.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish mean-curvature turning
source_mechanism: geometry-gated strong curvature followed by response-gated release into the propulsive rhythm
transferable_invariant: when a close pass is opening with a large route error, use a bounded transient average bend to reacquire closure, then release it as soon as measured closure returns
nontransferable_details: published gains, dimensional beat rates, species-specific C-start shapes, full-body curvature envelopes, exact vortex phases, and task-specific routes
policy_translation: multiply normalized distance, signed-closing-speed, and body-frame route-error gates; add the resulting bounded same-sign acceleration to both joints while preserving the state-feedback oscillator and posterior lag
falsification: reject if the gate alters a still-closing approach, weakens the alternating top-down or oblique wake, cannot reverse an opening pass before its near gate expires, or worsens actuator and force/moment envelopes
