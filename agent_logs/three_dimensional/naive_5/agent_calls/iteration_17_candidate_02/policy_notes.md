# Posterior kinetic-headroom governor candidate

## Visual and trace diagnosis before the edit

- All four sampled solver examples byte-match one controller and one combined
  keyframe sheet, and their separate evaluation workspaces reproduce the same
  contract-valid direct-uniform still-water result: capture at `0.749769L` and
  `27.6045T`.  In both the top-down mid-plane row and the oblique body/Lambda2
  row, the fish translates with an organized body-attached alternating wake
  and continues its late downward path rotation through the target.  The
  moving window follows controlled self-propulsion; the success is not inflow
  advection, a prewarm artifact, or a collapsing wake.
- The inherited instantaneous-intercept-hold failure is the most informative
  visual contrast.  Its two rows retain a similarly coherent wake, but the
  late trajectory straightens into a pass-by, reaches only `1.096087L`, and
  exits the left domain.  Together with the inherited terminal-pulse cluster,
  this rules out another intercept threshold, terminal waveform, or scalar
  navigation-gain edit as the evidence-led next test.
- Reproduction at the identical initial condition makes the line-of-sight
  response closure a stronger carrier to preserve, but it does not add capture
  clearance: every sampled crossing is only `0.000231L` inside the radius.
  The trace has modest peak planar force/yaw moment (`0.03397/0.01548`) yet
  `1183/10038` joint samples lie at the speed cap, `1878/10038` commands lie at
  the policy acceleration clamp, and posterior joint 2 hits the `45 deg` hard
  boundary three times near `16.92T`, `17.87T`, and `18.84T`.  At each contact
  joint 2 is already requesting maximum inward braking, showing that the
  relevant deficit is earlier kinetic-headroom management rather than a
  stronger terminal turn.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, redirect, terminal miss veto,
and inertial line-of-sight response exactly.  Add one posterior-only safety
mechanism after their control allocation: estimate the stopping angle of joint
2 from its observed outward speed and available inward acceleration, compare
that prediction with the nearer `45 deg` boundary, and smoothly blend toward
maximum inward braking only when predicted stopping clearance falls inside a
one-degree reserve.  The governor is reflection-equivariant, has no clock or
route state, and leaves anterior line-of-sight steering untouched.

The falsifiable expectation is repeat capture with the same coherent late
route while removing posterior hard-stop contact and reducing speed/clamp
residence.  Reject this mechanism if capture is lost, minimum distance is not
inside `0.75L`, the broad path or wake changes before the guarded posterior
excursions, limit residence or loads increase, or the governor frequently
activates despite positive stopping clearance.  Even if capture repeats, the
fixed-condition duplicates do not establish held-out robustness; later work
must test added geometric clearance or varied initial conditions.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion and robotic-fish CPG residual control
source_mechanism: preserve the productive phase-lagged rhythmic carrier while bounded joint-state feedback modifies only the actuation component whose measured envelope is unsafe
transferable_invariant: retain traveling-wave direction and task steering while attenuating outward posterior energy before finite joint authority can no longer stop it inside the physical envelope
nontransferable_details: published gains, species-specific amplitude envelopes, linkage geometry, dimensional beat timing, exact vortex phase, world coordinates, and task-specific routes
policy_translation: observed posterior angle and speed define normalized stopping clearance under the policy acceleration bound; a smooth body-reflection-equivariant gate blends only joint 2 toward inward braking inside a parameter-owned angular reserve
falsification: reject if the controller does not repeat capture, fails to remove posterior hard-limit contact, changes the coherent carrier outside guarded excursions, or increases actuator-limit residence, force, or yaw moment

## Non-CFD implementation audit

- The guidance-semantic check, lightweight Julia contract, and solver editable
  boundary pass.  All `39` directly referenced parameter fields are owned by
  `target_policy_params()`, and exactly one `candidate_target_policy.jl` exists
  under `solver/`.  The configured check-runner was invoked but its pinned
  model is unsupported by this account, so its three prescribed non-CFD
  commands were run directly and separately.
- Applying only the new final governor algebra to the sampled capture trace
  changes joint-2 action at `181/5019` recorded states (`166` by more than
  `0.1 rad/T^2`), changes no joint-1 action, and changes no state whose
  maximum-braking stopping clearance is at least the one-degree reserve.  The
  maximum frozen-state difference is `5.931 rad/T^2`; material differences
  span `10.109--21.736T` and `9.835--3.619L` from the target.  This locality
  audit does not predict the counterfactual joint path or CFD outcome.
- A synthetic unguarded state produces exactly the sampled controller's two
  actions.  A synthetic guarded outward posterior state advances joint 2 from
  `-19.884` to bounded `-30.0 rad/T^2` while leaving joint 1 exactly unchanged;
  reflecting all lateral target, velocity, rate, angle, and angular-velocity
  signals negates both outputs with zero numerical error.  These checks
  establish activation, reflection equivariance, and boundedness only.  No CFD
  was run.
