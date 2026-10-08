# Steering-priority low-energy posterior reserve

## Evidence and two-view diagnosis before editing

- All four sampled evaluations satisfy the frozen Phase-2 flow contract:
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, stable dynamics, and capture. Three samples are deterministic
  materializations of the error-qualified route baseline: `17.7265T`
  capture, score `-0.08139542`, and final distance `0.747287L`. The distinct
  low-energy posterior-reserve sample captures at `17.9740T`, score
  `-0.07395193`, and final distance `0.748104L`.
- I inspected the release-to-capture top-down vorticity and oblique Lambda2
  rows for the baseline and posterior-reserve sample. Both self-propel from
  rest, form a coherent alternating mid-plane street, and retain compact
  three-dimensional posterior structures through capture. Neither shows
  passive advection, collision, wake breakup, or out-of-plane instability.
  The reserve therefore does not repair wake existence; its useful and
  harmful effects are trajectory allocation changes within a sound carrier.
- The reserve achieves its intended early effect: first-`3T` mean speed rises
  from `0.2395U` to `0.2523U`, the score improves from `-0.08140` to
  `-0.07395`, and the cadence-adjusted phase-plane gate has reconstructed mean
  authority `0.2712` in the first `3T`, versus `0.0471` overall and only
  `0.0011` inside `2.1L`. But it fails the inherited hypothesis's baseline-like
  route boundary: arrival is `0.2475T` later,
  center path rises from `12.8468L` to `13.0672L`, maximum cross-track from
  `0.512L` to `0.663L`, approach course alignment falls from `0.899` to
  `0.740`, final alignment from `0.601` to `0.132`, and posterior approach
  acceleration-ceiling residence rises from `68.69%` to `72.83%`.
- The route change is seeded while the temporary reserve is active, not by a
  terminal mechanism. Reconstructing the public guidance law shows mean
  normalized turn load `0.284` while the energy gate is nonzero. The extra
  tail-wave target bypasses the baseline cadence controller's existing turn
  relief, so it increases posterior propulsion precisely while direction
  feedback is also asking for allocation; applying the same normalized relief
  would withdraw about `29%` of gate-weighted reserve on the evaluated
  trajectory. A scalar-only increase or decrease cannot distinguish useful
  low-energy thrust from this steering conflict.

## One policy hypothesis

Start from the evaluated posterior-reserve mechanism and make its extra
posterior excursion subordinate to simultaneous normalized target-turn load.
Keep the energy gate, posterior lag, base traveling-wave amplitude, odd
curvature polarity, two-joint steering, route/approach handoff, cadence, and
direction-selective rate governors unchanged. Multiply only the *additional*
low-energy posterior reserve by a bounded steering-priority factor derived
from `abs(turn_request) / turn_request_limit`; full baseline posterior motion
and full steering/reversal authority remain available at every load. This is
a state-feedback propulsion/steering allocation mechanism rather than a
global gain change, and it uses neither time nor world-frame route data.

Expected evidence is retention of some early speed/closure improvement over
the `0.2395U` baseline while reducing the reserve sample's `0.663L`
cross-track and restoring approach alignment toward `0.899`, with stable
capture no later than `17.9740T`, score above the `-0.08140` baseline, no new
limit-residence class, and the same coherent two-view wake. Falsify it if
turn relief suppresses the early benefit into baseline equivalence, if the
reserve trajectory still has the sampled route/terminal regressions, or if
capture, score, load, reflection symmetry, or either wake view deteriorates.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive-thrust allocation and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: tail-emphasized traveling-wave propulsion remains subordinate to simultaneous closed-loop direction demand
transferable_invariant: add posterior recovery power only in an observed low-energy regime and continuously withdraw that extra allocation as normalized steering demand consumes control authority
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, task routes, and clock-driven startup schedules
policy_translation: multiply only the low-carrier-energy posterior-wave reserve by a bounded body-frame turn-load relief factor while preserving the base posterior wave and odd two-joint steering path
falsification: reject if early closure is not retained while route directness and approach alignment improve, or if capture, score, actuator load, reflection symmetry, or top-down and oblique wake coherence regress
