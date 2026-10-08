# Terminal course-continuity candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts and the inherited terminal-hold rollout satisfy
  the frozen experiment: direct uniform still water (`U_infinity=[0,0,0]`),
  no cylinders, no prewarm, and a moving L64 storage window.  Two v35 and two
  v36 samples have byte-identical `4486`-row trajectories and combined
  keyframes.  They capture at `24.6730T` and `0.748684L`, with mean distance
  `2.348256L` and score `-0.448647`.
- The top-down and oblique rows were inspected from release through capture.
  The fish is self-propelled, not advected: it lays down a coherent alternating
  mid-plane vortex street and compact three-dimensional Lambda2 structures
  along a long diagonal approach, then executes a bounded hook into the target.
  The v36 sign-only course veto is visually and numerically inactive, so it is
  not a semantic improvement over v35.  No failed-rollout keyframe is present
  in this workspace; the failure comparison is therefore limited to inherited
  audited metrics rather than an invented visual claim.  Those metrics show
  that reference-velocity follower feedforward reduced exact-rate occupancy
  but missed at `0.993L` and exited left, while two dual-joint velocity barriers
  converted capture into `0.933/0.848L` pass-and-turn failures.
- The completed v37 terminal carrier hold is the most informative local
  regression comparator.  Its combined sheet retains the same coherent wake
  and capture topology, but reducing both carriers on `292` near-target states
  does not correct the transverse terminal sweep.  Relative to v35 it crosses
  only `0.011T` earlier (`24.6620T`) while mean distance and score regress to
  `2.348972L/-0.449580`, the terminal crossing margin shrinks from
  `0.001316L` to `0.000339L`, raw acceleration and total exact-rate exposure
  remain essentially unchanged (`73.483/13.894%` versus
  `73.473/13.932%`), and peak lateral-force/yaw-moment coefficients rise from
  `0.0309/0.0156` to `0.0347/0.0180`.  Near-target carrier relief is therefore
  not supported as course-alignment or constraint relief.
- The remaining visible issue is semantic: the successful fish reaches the
  disk during a strongly transverse sweep.  At v35 capture its inertial
  velocity is about `(-0.371,0.637)U`, recent heading rate is `2.180/T`, and
  heading error is `0.384 rad`.  The existing normalized velocity-course
  correction is appropriate for this miss geometry, but its body-axis passage
  gate progressively releases it precisely as the near-range target moves
  posterior, even while measured closing remains positive.

## Policy hypothesis

Preserve the evaluated v35 anterior state-feedback phase anchor, lagged
posterior traveling wave, mean-curvature and half-cycle steering, posterior
steering-residual coast, stroke prediction, braking reserve, and every owned
gain.  Change one scheduling mechanism only: outside the established
`approach_distance_L` neighborhood, keep the existing body-axis release of the
velocity-course preview exactly; inside that neighborhood, continuously bridge
the release toward full course feedback as range closes.  Existing positive
closing, speed, range, and bounded course-error gates remain mandatory, so the
bridge vanishes on an opening trajectory and creates no clock, world-frame
direction, route, or new acceleration source.

The expected result is unchanged far-path commands and wake, followed by a
less transverse target crossing with capture no later than the v35
`24.6730T`, mean distance no worse than `2.348256L`, and the same zero
posterior hard-stop and low-load classes.  Falsify the mechanism if any command
changes at or beyond `2.10L`, capture or the coherent route is lost, the same
terminal sweep is merely delayed, the crossing margin shrinks, or posterior
hard-stop, exact-rate, raw-command, force, or moment behavior regresses.  The
new CFD outcome is not available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish coupled oscillators
source_mechanism: preserve a propulsive rhythm while near-target velocity-course feedback remains active until the observed intercept is complete
transferable_invariant: separate route completion from body-axis passage, and preserve bounded course correction while range is near and measured closing is still positive
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, prescribed paths, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain the evaluated two-joint carrier and steering law, but continuously bridge the existing normalized body-frame velocity-course request across its posterior body-axis release only inside the owned approach neighborhood
falsification: reject if the far path changes, capture or coherent wake is lost, terminal course alignment does not improve, or hard-stop, rate, raw-command, force, or moment classes regress

## Pre-evaluation validation

- A deterministic fixed-state application to all `4486` rows of the completed
  v35 trace changes `62` commands, all between `24.0515--24.6730T` and
  `0.9264--0.7487L`; no reconstructed state at or beyond `2.10L` changes.
  The largest same-state acceleration delta is `6.161 rad/T^2`, below the
  owned `31.416 rad/T^2` envelope.  This is a locality/materiality audit, not
  coupled-CFD evidence.
- Across `2304` deterministic probes, the new bridge scalar is reflection
  invariant, its signed course request is mirror-equivariant, every command is
  finite, and the candidate is exactly equal to v35 at and outside the approach
  distance.  The public Julia contract returns two finite accelerations, and
  all `84` direct `params.FIELD` references resolve among the `86` fields
  returned by `target_policy_params()`.
- The reusable-guidance semantic check and solver editable-boundary audit pass.
  The configured checker was invoked but its pinned `gpt-5.4-mini` model is
  unavailable on this account; an available independent checker reran the same
  three `.toml` commands separately and confirmed all checks pass.  No formal
  CFD was run.
