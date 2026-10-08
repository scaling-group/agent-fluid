# Evidence-backed intercept-only terminal release

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 evidence contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  dynamics, and capture from `12.327720 L` at `25.118523 T` after 268 window
  shifts.
- I inspected the complete combined keyframe sheets for the three
  byte-identical intercept-only samples and the force-vetoed prefill, including
  the top-down mid-plane vorticity and oblique body/Lambda2 rows from release
  through capture. The fish is self-propelled rather than advected: a coherent
  alternating wake grows behind the posterior body along the same compact
  target-directed arc, then subsides as the controller enters a quiet
  held-bend glide. Neither view shows a collision, loop, boundary-exit
  precursor, out-of-plane excursion, terminal thrashing, or numerical
  instability. The policies are visually indistinguishable at sheet
  resolution, so the terminal telemetry decides between them.
- Three independent evaluations of the intercept-only policy reproduce
  exactly: score `-0.5280772274`, mean distance `2.429087214 L`, final distance
  `0.746135294 L`, and capture on the same solver step. Below `1.6 L`, distance
  decreases monotonically; action maxima are only
  `0.09772/0.24610 rad/T^2`, posterior angle remains below `0.21719 rad`, and
  lateral-force and moment magnitudes remain below `0.002095` and `0.000566`
  in their normalized diagnostic units.
- The prefilled adverse-force veto first changes a command only at
  `1.32513 L`, while the fish is already closing along the validated
  intercept. It preserves capture and the visible wake but regresses to score
  `-0.5280778498`, mean distance `2.429087705 L`, and final distance
  `0.746135950 L`; its terminal action maxima also rise slightly to
  `0.09791/0.24656 rad/T^2`. This reproduces the assigned-parent negative
  result: instantaneous lateral force is too fast and ambiguous to veto an
  already geometry-supported terminal response in this still-water pass.

## Policy hypothesis

Use the three-times-reproduced intercept-only controller as the single
candidate. Preserve its state-feedback oscillator, posterior lag,
target-angle redirect, scalar closure preview, shared two-joint mean-curvature
equilibrium, helpful-crossflow response gate, coupled carrier release, and
command limits. In the existing late, closing, settled response regime,
normalized body-frame target and velocity vectors estimate constant-velocity
cross-track miss; only a miss inside the declared corridor earns the inherited
bounded `3.5%` paired release toward the same mean-centered carrier. Remove
the adverse-force veto because completed rollouts show it is independently
active but deterministically harmful.

This changes one response-composition mechanism rather than tuning a scalar:
target-relative intercept geometry remains the sole optional release
condition, without a second fast force gate. Falsify the candidate if it fails
to reproduce capture, changes any pre-terminal command or the compact outer
path, delays crossing, worsens mean/final distance or predicted miss, renews
terminal oscillation, saturation or joint-stop dwell, increases force/moment
loads, becomes unstable, or degrades either wake view.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and biological burst-response release
source_mechanism: preserve an established traveling rhythm and relax corrective allocation only after measured target-relative motion demonstrates a viable intercept
transferable_invariant: bounded corrective release should follow normalized geometric response and preserve the proven propulsive scaffold; a fast hydrodynamic response should not be stacked without independent benefit
nontransferable_details: published gains, dimensional cadence, species-specific bend envelopes, duty ratios, clock or vortex phase, exact capture radius, and task-specific routes
policy_translation: normalized body-frame target and velocity vectors form the existing bounded predicted-miss condition for a small coupled two-joint carrier release, with proximity, positive closure, helpful crossflow, and settled response retained as independent support
falsification: reject on non-reproduction, changed outer motion, increased authority, delayed or lost capture, worse miss or distance, renewed terminal oscillation or joint stops, load growth, instability, or wake loss

The current candidate's CFD evaluation occurs only after this worker exits and
is not claimed as evidence here.
