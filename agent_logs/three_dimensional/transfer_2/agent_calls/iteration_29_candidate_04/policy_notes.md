# Coupled terminal-residual anti-windup candidate

## Visual diagnosis before policy edit

- The four assigned solver examples contain the same v41 policy, combined
  keyframe sheet, trajectory, and outcome.  They are exact nominal
  replications, not four controller mechanisms: each captures at
  `24.640015T`, reaches `0.748356L`, has mean distance `2.347937L`, scores
  `-0.448328283`, and performs 284 moving-window shifts.
- The rollout satisfies the frozen evidence contract: diagnostics report
  direct uniform initialization in still water (`U_infinity=[0,0,0]`), no
  cylinders, and no prewarm snapshot.  In the top-down row the fish generates
  an alternating, coherent wake from rest, makes sustained diagonal progress,
  and executes a bounded transverse hook into the capture disk.  The oblique
  Lambda2 row shows compact three-dimensional wake structures persisting
  through the hook.  This is self-propulsion rather than advection, with no
  visible breakup or out-of-plane escape.
- The trace agrees with the visual stability: peak absolute planar
  body-force/yaw-moment coefficients are approximately
  `0.0230/0.0317/0.0156`, and posterior hard-stop occupancy is zero.  The
  crossing remains narrow, however: final margin is only `0.001644L`, the
  terminal constant-velocity projected miss is `0.631928L`, and raw
  acceleration-envelope exposure remains `73.59%`.
- No termination failure is present among the assigned solver sheets.  The
  most informative available negative comparison is therefore inherited.
  Moving the whole phase-selected terminal residual to the posterior captures
  later at `24.673016T` and scores `-0.448773`; transferring posterior share
  to the anterior according to stroke headroom crosses one row earlier but
  degrades final/mean distance to `0.749001/2.348455L`, raises raw envelope
  exposure, and scores `-0.448986`.  More broadly, posterior reference-rate
  feedforward and dual-joint rate barriers changed the established route and
  lost capture despite lower rate statistics.  The useful boundary is local
  coupled allocation, not another scalar, broad rate correction, or authority
  transfer.
- A counterfactual replay of the v41 modules on its completed trace isolates a
  mismatch inside that local allocation.  The terminal phase residual is
  active on 245 logged states from about `2.10L` inward.  The posterior
  stroke-braking and rate-coast filters realize only about `47%` of the
  marginal tail contribution on average; 54 active states retain less than
  `5%`.  The anterior command is currently finalized before those posterior
  filters and can therefore retain a one-joint residual precisely when the
  follower has rejected its coupled share.

## Policy hypothesis

Preserve v41's carrier, normalized body-frame course/miss feedback, phase gate,
joint shares, posterior braking reserve, and posterior rate coast.  Add one
instantaneous coupled anti-windup mechanism: compute the posterior terminal
residual that survives the existing allocator and safety filters relative to
the route-only counterfactual, then admit the anterior terminal increment only
in that same realized fraction.  Leave the posterior command itself unchanged.

This does not synthesize acceleration, reclaim rejected tail effort through
the head, add memory, or change the far route.  It is identically inactive when
the terminal residual is absent and retains the full v41 coupled pulse when
the posterior follower realizes it.  It only vetoes the unilateral anterior
remainder when posterior stroke/rate safety has already removed the matching
tail contribution.  Because the gate is formed from sign-consistent absolute
command differences, the gate itself adds no lateral preference under
simultaneous sign reversal of the marginal commands.

The post-worker evaluator should retain capture, the coherent wake, exact far
route before terminal activation, zero posterior hard-stop occupancy, and the
low-load class while improving the narrow terminal margin or distance
integral.  Falsify the mechanism if it loses capture, changes the path before
the inherited terminal residual activates, increases posterior constraint
occupancy or peak loads, or merely reproduces the worse v40 no-residual class.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish control and bounded asymmetric fish turning
source_mechanism: embed sensory steering inside a stable anterior-to-posterior traveling bend while preserving phase coupling instead of treating independently saturated joints as interchangeable authority
transferable_invariant: infer phase and actuator availability from observed joint state, preserve the established traveling wave, and keep a target-derived residual coupled across the two joints when a follower safety constraint removes its share
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, robot or species kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's normalized body-frame projected-miss residual and joint-state phase gate, compare full and route-only posterior commands through the owned acceleration/stroke/rate filters, and scale only the matching anterior residual by the sign-consistent realized posterior fraction
falsification: reject if nominal capture, far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if the coupled veto falls back to the v40 terminal class rather than improving v41's narrow crossing

## Evaluation boundary

Formal CFD is intentionally deferred to the post-worker evaluator.  The trace
audit establishes locality and command semantics only; it is not a same-worker
hydrodynamic result, and fixed-pose evidence does not establish reflected or
perturbed-route robustness.

## Pre-evaluation validation

- Replaying v41 and this candidate on the same completed states changes 147
  anterior commands, all from approximately `2.10L` inward.  The maximum
  fixed-state anterior difference is `0.2952 rad/T^2`; every posterior command
  is unchanged, and both policies have the same 3291 raw-envelope-exceedance
  rows on that trace.  This is a locality audit, not a predicted CFD outcome.
- The public contract probe returns two finite accelerations
  `(-14.3858335, 0.0005062)`.  The deterministic schema audit resolves all 87
  direct `params.FIELD` references among the 89 fields returned by
  `target_policy_params()`.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account.  Its three declared no-CFD commands were
  therefore run directly and separately: durable-guidance semantics, the
  Julia public policy contract, and the solver editable-boundary audit all
  pass.
- The resulting candidate LF SHA-256 is
  `c30c27ca9618290e3123aec25dc2a14579c90966add3aef1ecb03a7ecba41ec1`.
