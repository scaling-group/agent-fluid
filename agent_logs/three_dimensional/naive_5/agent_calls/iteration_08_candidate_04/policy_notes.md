# Capture-neighborhood redirect-release candidate

## Visual and trace diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm). In both the
  top-down vorticity and oblique Lambda2 rows, the moving window follows real
  self-propulsion and each candidate forms a body-generated alternating 3D
  wake. The steering differences are therefore controller responses rather
  than imposed advection or a moving-window artifact.
- The assigned parent, `solver_b3b6be8f076f`, applies interception and positive
  closing-speed qualifications to every large-error redirect release. Its two
  visual rows retain a coherent wake but stay in the high corridor and curl
  into the upper margin at `(8.132,15.202)L` after `27.066T`; its minimum is
  only `4.278L`. At closest approach, the reconstructed projected miss is
  `4.277L`, so interception release is zero while the joints have nearly
  settled into a same-sign bend (`-0.308,-0.292 rad`) with small velocities and
  commands. This is an observed far-field static-redirect latch, not evidence
  that interception is a bad terminal signal.
- `solver_29282ff8dbf4` is the strongest semantic trajectory despite the worst
  scalar score. It differs from the parent in release structure: normalized
  two-joint bend attainment can return the redirect to the traveling carrier.
  The top-down row then curves downward through the target neighborhood, and
  the oblique row keeps a coherent alternating 3D trail to `43.197T`. It avoids
  angle contact, has peak planar force and yaw moment near `0.0214` and
  `0.0098`, and reaches `0.8307L` at `27.484T`, only `0.0807L` outside the
  capture radius, before overshooting and exiting the left boundary.
- That near miss is a terminal interception error rather than wake collapse or
  lack of broad steering authority. From `1.50L` to closest approach, planar
  speed stays about `0.64--0.66L/T`, projected miss falls only from `1.095L` to
  `0.824L`, and closing speed decays from `0.513L/T` to nearly zero. At the
  minimum, bearing is still large (`-1.275 rad`), the course is almost
  perpendicular to the target vector, heading response still has the requested
  sign, and replayed joint/yaw release leaves about `15%` of the propulsive
  carrier mixed into the redirect. The evidence supports a little more
  terminal redirect/drive relief, not another carrier gain increase.
- The other failures bound the change. The raw-yaw closure exits upward at
  `20.790T` with a `6.268L` minimum and much higher limit residence, while
  headroom-gated posterior asymmetry reaches only `5.386L` and produces roughly
  tenfold larger peak load and moment than the near-miss trajectory. Preserve
  the measured steering side, anterior carrier, posterior lag, and bounded
  same-sign redirect rather than retuning those channels.

## Policy hypothesis

Start from the sampled joint-state-released redirect that produced the
`0.8307L` approach. Add one continuous terminal semantic: below a small
body-length approach radius, suppress redirect release only while the
body-frame velocity/target cross product predicts a miss outside an inner
capture corridor. This reuses the existing bounded same-sign redirect, so it
simultaneously sustains curvature and replaces excess carrier drive during the
last approach. Outside that neighborhood the veto is exactly zero, preserving
the trajectory-producing bend/yaw release and avoiding the assigned parent's
global static-bend latch. If the projected miss becomes safe, release resumes;
if a miss grows back outside the neighborhood, the original controller resumes
without a hidden stage.

Expected evidence is preservation of the downward coherent trajectory with a
first crossing inside `0.75L`, or at minimum a closest approach below
`0.8307L`. Falsify the mechanism if it raises the target-neighborhood crossing,
recreates the parent's high-corridor latch, prevents rhythmic recovery outside
the approach zone, breaks the alternating 3D wake, touches the angle boundary,
or materially increases actuator-limit residence or the near-miss load scale.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and fish-inspired terminal capture control
source_mechanism: preserve rhythmic propulsion at range, but use current target-relative motion to retain bounded curvature and relieve drive during a bad terminal intercept
transferable_invariant: far-field steering release and near-field capture release need not use the same criterion; close to the target, measured projected miss should qualify return from redirect to propulsion
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species-specific bend timing, exact vortex phase, world coordinates, capture route, and dimensional cadence
policy_translation: retain joint-state/yaw release outside the approach zone, then smoothly attenuate that release using only normalized target distance and body-frame projected miss when both indicate a terminal miss
falsification: reject if the approach does not beat 0.8307L, the high-corridor static bend returns, carrier recovery is delayed outside the terminal zone, or wake coherence, loads, and limit residence worsen

## Non-CFD implementation audit

Replaying both the sampled near-miss policy and this candidate on the frozen
`solver_29282ff8dbf4` states gives exactly zero command difference throughout
the first approach while distance is at least `1.75L`. Inside that boundary,
the new semantic changes `88.6%` of sampled commands and increases redirect
authority smoothly: at the `0.8307L` minimum the command changes from about
`(0.25,-0.20)` to `(-1.18,-3.43) rad/T^2`. Frozen-state acceleration-clamp
incidence through closest approach remains identical (`34.4%`), and direct
finite/reflection tests negate both joint accelerations to machine precision.
This verifies activation, locality, boundedness, and symmetry only; it is not a
claim about the unevaluated fluid or trajectory response.
