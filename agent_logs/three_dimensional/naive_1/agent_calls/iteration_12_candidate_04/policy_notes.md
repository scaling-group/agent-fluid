# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no prewarm, and no instability. Three evaluations
  use the same policy hash and reproduce the same `24.3375T` capture and
  `2.224316L` mean distance exactly, so the successful route is no longer a
  one-off numerical result.
- In the valid `solver_1a1f00e33399` sheet, the top-down row shows continuous
  self-propelled closure rather than advection or a coast, and the oblique row
  shows an alternating three-dimensional Lambda2 wake through capture. The
  fish first reaches `1.5L` at `22.2915T` and crosses `0.75L` at `24.3375T`.
  Over that terminal interval, median closure is `0.367L/T` but falls to about
  `0.109L/T`; final speed is `0.607L/T`, full head-relative target error is
  about `-1.324 rad`, and heading rate is `-1.231 rad/T`. The carrier is still
  active, but much of its velocity is being spent across rather than down the
  line of sight. Anterior/posterior rate-cap occupancy is `14.0/6.9%`, with
  peak planar force and yaw moment near `0.03165/0.01638`.
- The assigned-parent `solver_666b72f43d6a` multiplies the same posterior
  rudder by up to `1.2` when instantaneous closure falls. Its top-down route is
  unchanged through `1.5L`, but capture is delayed by `0.077T`, mean distance
  worsens from `2.224316L` to `2.224632L`, final speed falls from `0.607` to
  `0.578L/T`, and full error grows from about `1.324` to `1.366 rad`. Loads
  and rate-cap occupancy do not materially change. Thus extra mean-rudder
  authority is a concrete negative result, not terminal recovery. Its oblique
  sheet is black after the frame labels, so that view is an evidence-rendering
  failure and supports no comparative wake claim; the valid successful sheet
  remains the wake reference.

## Candidate hypothesis

Preserve the replicated capture controller, including its slip-aware anterior
center, full-angle half-cycle carrier, and proximity/error-gated posterior
rudder. Add one distinct response-conditioned allocation mechanism: once
distance is below `1.5L`, smoothly restore at most `0.20` of the symmetric
phase-lagged posterior carrier when closing speed falls below `0.30L/T`,
reaching full restoration near `0.10L/T`. The posterior mean rudder is not
increased or retuned. The new term is zero on the far and middle route, zero
during healthy terminal closure, and changes only the oscillatory carrier so
that deficient closure recruits posterior propulsion without erasing the
evidenced yaw-load path.

Expected result: reproduce the route and wake to `1.5L`, retain capture, and
shorten the slow final interval by maintaining terminal speed or closure.
Falsify the mechanism if the pre-`1.5L` trajectory changes, capture is lost or
later than `24.3375T`, median terminal closure and arrival do not improve, or
posterior rate-cap occupancy and force/moment peaks materially exceed the
sampled `14.0/6.9%` and `0.03165/0.01638` envelope.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG control
source_mechanism: separate a propulsion-producing phase-lagged posterior beat from a bounded mean steering load, and change their allocation from observed task response
transferable_invariant: preserve the established steering mean while deficient closure recruits only the oscillatory posterior component that supplies reactive thrust
nontransferable_details: elongated-body coefficients, published CPG gains, robot linkage geometry, species-specific amplitudes, dimensional frequencies, exact vortex phase, and prescribed routes
policy_translation: normalized distance and closing speed smoothly restore a bounded share of the joint-state phase-lagged tail carrier without altering the target-gated posterior rudder
falsification: reject if the established route changes before the terminal gate, capture is delayed or lost, closure fails to improve, or wake coherence, saturation, force, or moment exceeds the successful envelope
