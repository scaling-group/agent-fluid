# Wake-policy candidate notes

## Evidence diagnosis

All four sampled evaluations report direct uniform still-water initialization,
capture, and finite dynamics. In both the top-down mid-plane row and the
oblique Lambda2 row, the fish self-propels rather than advecting: an alternating
vortex street grows behind a translating body, and compact three-dimensional
caudal structures remain attached to the traveling bend through approach. The
views are nearly indistinguishable through transit, so the current distinction
is terminal state feedback, not wake formation or propulsion loss.

The assigned v20 parent is the scalar leader (`-0.0640276`, `18.0070T`, mean
distance `1.95036L`), but its instantaneous positive-yaw-power qualifier ends
at only `0.1092` course alignment and `0.9840 rad/T` absolute yaw. The sampled
v16 alignment-qualified envelope is only `0.0165T` slower and scores
`-0.0645445`, while ending at `0.1818` alignment and `0.4200 rad/T` yaw. The
v12 and v15 samples have identical `18.0125T`, `-0.0645989` trajectories,
showing that a nominal terminal partition can be behaviorally inactive. Thus
another raw-yaw, moment-sign, course-gain, or envelope-floor edit is not
supported.

Across the sampled v12/v15, v16, and v20 approach traces, a reflection-odd
least-squares model of raw body yaw rate using normalized anterior angle and
rate has stable coefficients: angle `0.519--0.530`, rate from `-3.48` to `-3.31`,
`R^2=0.992--0.994`, and residual RMS `0.170--0.183 rad/T` versus raw RMS
`2.10--2.21 rad/T`. With common coefficients `(0.525,-3.40)`, a residual gate
scale of `0.060 rad/T` gives mean terminal activation `0.855--0.870`, comparable
to the v16 raw-yaw gate's `0.863--0.874`; this avoids silently removing the
established posterior-relief authority.

## Policy hypothesis

Keep v20's far/middle controller, odd target-to-curvature map, traveling-wave
drive, rate governor, v16 approach envelope, and v19 conserved forward
mean-bend allocation. Remove the falsified instantaneous yaw-power selector.
Within the already transit-inactive approach envelope only, predict the
phase-locked gait yaw from normalized anterior joint state and use the absolute
residual to qualify posterior-wave relief. Keep raw recent turn rate everywhere
in target-route feedback, recovery, and centerline braking. This tests whether
terminal allocation should respond to slower course rotation instead of the
large carrier-synchronous yaw that dominates the raw signal.

Expected result: exact pre-approach behavior and the coherent two-view wake are
preserved; capture and the parent's distance integral remain in class; terminal
alignment/yaw and posterior acceleration residence improve relative to v20.
Falsify the candidate if pre-approach commands change, capture/mean distance
regresses materially, terminal alignment or yaw fails to improve, limit
residence migrates between joints, or either wake view loses coherence.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and wake-interaction feedback
source_mechanism: represent rhythmic locomotion by joint-state phase and separate persistent route response from fast alternating hydrodynamic motion
transferable_invariant: isolate carrier-synchronous motion before using yaw to schedule a slower allocation response
nontransferable_details: published oscillator gains, species kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: subtract a sampled reflection-odd anterior-state yaw prediction from normalized raw yaw, then use only that residual inside the existing body-frame terminal posterior-wave envelope
falsification: reject if reflection oddness, exact transit inactivity, capture and closure, terminal yaw/alignment, actuator residence, or coherent top-down and oblique wakes are not preserved or improved

## Non-CFD validation

- Guidance provenance check: pass after removing a duplicated assigned-parent
  marker from the rendered workspace README.
- Solver boundary check: pass; the candidate policy is the only solver edit.
- Static public-contract/schema check: pass; the file is non-empty, defines one
  `target_policy_params` and one `target_policy`, and all 65 direct
  `params.FIELD` references are declared by the returned parameter object.
- The configured check-runner was invoked but its fixed model is unavailable in
  this account, and the local Julia smoke command could not run because no Julia
  executable is installed. No CFD was run.
