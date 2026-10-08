# Four-replicated one-sided speed-guard candidate

## Visual and metric diagnosis before the candidate decision

- All four sampled rollouts satisfy the released direct-uniform contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, finite dynamics, and
  `capture`. Their policies, `trajectory.csv` files, and combined two-view
  keyframe sheets are byte-identical. Each captures at `16.609995T`, reaches
  `0.745621L`, and scores `-0.115560`; the four results are fixed-case
  replications rather than four distinct controller tests.
- I inspected the top-down and oblique rows of the replicated candidate and
  the preceding mean-preserving capture. In both, the top-down mid-plane row
  shows self-propelled targetward translation with a coherent alternating
  wake, and the oblique row shows finite, tail-connected three-dimensional
  Lambda2 structures through the shallow target crossing. The replicated
  sheets preserve the route and wake class; there is no sampled semantic
  failure or distinct failure image in this assigned set, so the preceding
  captured parent is the informative controlled comparator.
- The completed speed guard improves that comparator consistently: arrival
  changes from `16.631994T` to `16.609995T`, score from `-0.118307` to
  `-0.115560`, scored distance integral from `2.001992L` to `1.999656L`, and
  observed distance integral from `1.378485L` to `1.377882L`. Maximum joint
  magnitudes fall from `0.547719/0.555689 rad` to
  `0.541097/0.549208 rad`, while peak planar force/moment fall from
  `0.036777/0.018272` to `0.035828/0.017759`.
- Direct trace reconstruction also shows that the final-one-percent guard
  preserves near-speed residence (`11.59%/15.83%` for the two joints) while
  limiting outward acceleration there to `1.85%/1.39%` of all samples. Its
  logged mean absolute output is `21.74/22.69 rad/T^2`. This agrees with the
  inherited diagnosis: the mechanism removes only infeasible outward effort,
  not the useful traveling-wave carrier or inward reversal.
- The assigned guidance has not yet distilled this completed speed-guard
  result, while inherited optimizer logs record the controlled predecessor,
  the one-sided intervention, and the later evaluation. Earlier inherited
  failures rule out treating lower effort alone as sufficient: whole-wave
  relief, startup recruitment, added terminal mean curvature, and the combined
  steering sign flip all damaged approach or termination despite finite wakes.

## Single policy hypothesis

Promote the sampled one-sided speed guard byte-for-byte as this workspace's
sole candidate. Preserve the mean-removed yaw demodulator, body-frame route and
course feedback, phase-selective posterior steering, full-amplitude carrier,
all evaluated gains, and the smooth final-one-percent speed projection. The
projection acts identically on both joints: as normalized speed enters the
declared boundary band, remove only the acceleration component aligned with
the measured joint velocity and retain every inward or reversal command.

This is the strongest available positive evidence and avoids confounding its
four exact replications with an untested controller change. The expected
fixed-case result is repeated capture near `16.61T` with the same connected
wake and bounded load envelope. The replications do not establish robustness
to a new pose, inflow, morphology, or actuator integration order. Falsify this
promotion if capture, target-crossing arc, reversal timing, wake connectivity,
joint contact, distance cost, force, or moment fails to repeat, and do not
widen the guard unless a controlled rollout shows that pre-boundary damping
preserves the carrier.

bookshelf_consulted: true
source_domain: bounded low-dimensional robotic-fish CPG control and traveling-wave reactive propulsion
source_mechanism: preserve a rhythmic propulsive carrier while applying a separate state-feedback correction compatible with actuator feasibility
transferable_invariant: remove only command effort that points farther outward near a normalized joint-speed constraint while preserving interior motion and inward reversal
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, waveform envelopes, exact vortex phases, maneuver timing, and task-specific routes
policy_translation: retain the normalized body-frame two-joint carrier and steering law, then smoothly project only outward acceleration over the parameter-owned final one percent of the speed envelope
falsification: reject if capture, arrival, distance cost, targetward arc, connected wake, reversal timing, joint contact, force, moment, or feasible command effort worsens

## Evaluation boundary

No new CFD outcome is claimed in this workspace. The candidate is an exact
promotion of four completed sampled rollouts. Later evaluation should first
require capture and the same two-view wake/trajectory class, then compare
arrival, scored and observed distance integrals, outward acceleration
conditional on normalized speed, reversal timing, joint contact, peak
force/moment, and command effort. A repeat confirms only this released fixed
case; a changed pose or flow remains a held-out test.
