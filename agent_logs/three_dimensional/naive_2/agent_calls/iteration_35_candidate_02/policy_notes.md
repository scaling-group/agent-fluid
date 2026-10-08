# Predictive joint-speed feasibility candidate

## Evidence read before editing

All four assigned examples are exact repeats: their candidate, trajectory, and
combined-keyframe SHA-256 hashes match. Each directly initializes uniform still
water at `U_infinity=(0,0,0)`, captures at `16.604496T`, crosses at
`0.743958L`, has a `1.998146L` scored distance integral, and scores
`-0.113729`. Four inherited optimizer log records repeat the same capture
tuple. The sample set therefore contains a strong reproducible finite capture
but no informative failure or held-out perturbation.

The top-down sheet shows self-propelled target progress with a regular,
alternating mid-plane vortex street from release through capture. The route is
smooth at keyframe scale and does not show a late excursion that would justify
new steering. The oblique Lambda2 sheet shows finite alternating structures
remaining connected to the caudal region rather than an advected or detached
wake. The corresponding trace has bounded peak planar force and moment
(`0.037165` and `0.018356`) and no instability. These two views support
preserving the full traveling-wave carrier, phase-demodulated response cues,
raw anterior target geometry, and capture route.

The remaining concrete defect is at the released joint-speed envelope. The
trace resides in the final 1% of the `260 deg/T` limit for 11.59% of joint-1
samples and 16.00% of joint-2 samples. More specifically, post-integration
rows show the exact speed clamp together with same-direction applied
acceleration in 29 joint-1 frames (0.96%) and 34 joint-2 frames (1.13%). Since
the episode records the just-applied command with the resulting clipped joint
state, the existing current-speed-only guard is sometimes one update too late;
this is a feasibility defect even though nominal capture survives it.

## Policy hypothesis

Leave every propulsion and steering equation unchanged. Evaluate the existing
one-sided smooth speed projection on a predicted joint speed equal to observed
speed plus only the outward bounded acceleration over a small fraction of the
controller's own cycle. Preserve all inward/reversal acceleration. This
clock-free joint-state mechanism should begin suppressing infeasible outward
work before the integrator clips velocity, while avoiding route, wake, or
turning changes away from the speed boundary.

Falsify the candidate if it loses capture, increases the `1.998146L` distance
integral, makes the `0.743958L` crossing shallower, delays `16.604496T`
arrival, disrupts the alternating connected wake, worsens joint-limit
residence, or raises effort, force, or moment. A later worker should also
reject the mechanism if exact-clamp/same-direction rows do not fall, because
then the predictive observation has not addressed its motivating defect.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and robotic-fish CPG residual control
source_mechanism: preserve a stable state-feedback rhythmic carrier and place a small feedback residual around it
transferable_invariant: correct actuator feasibility without replacing the propulsive traveling-wave phase relationship
nontransferable_details: published oscillator gains, gait envelopes, dimensional update rates, species kinematics, and task-specific routes
policy_translation: keep the two-joint carrier and target feedback fixed; apply one bounded normalized joint-speed look-ahead only to outward acceleration
falsification: reject on lost or costlier capture, wake disconnection, worse limits or loads, or persistence of exact-clamp outward commands
