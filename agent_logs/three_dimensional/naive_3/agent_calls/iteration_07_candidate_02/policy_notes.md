# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All sampled and inherited evaluations use direct uniform quiescent
  initialization (`U_infinity=(0,0,0)`), no cylinders, and finite dynamics.
  Their motion and wakes are therefore self-propulsion, not advection or a
  prewarm artifact.
- I inspected both rows of the combined top-down-vorticity and oblique-Lambda2
  sheets for the strongest completed carrier (`2.443L` minimum) and the most
  informative inherited failure (course-aware sideslip compensation,
  `12.150L` minimum). The strongest carrier maintains a long, coherent,
  alternating three-dimensional wake while approaching from the upper right;
  it passes below the target with substantial speed, turns onto a powered
  downward path, and exits the lower boundary at `31.097T`. The course-aware
  failure instead curls the body and short wake toward the wrong, upper side,
  makes almost no target progress, and exits the upper boundary at `9.295T`.
  Its `12.785L` mean and `12.835L` final distances confirm that this is a
  catastrophic steering result rather than a visual ambiguity.
- The sampled slip-gated posterior phase rotation is a second completed
  negative result. It preserves the long alternating wake and lower-exit
  topology but worsens minimum distance from `2.443L` to `2.822L` and mean
  distance from `8.443L` to `8.508L`. Full-direction posterior gating likewise
  reaches only `2.494L`. Thus neither direct sideslip-to-curvature replacement,
  posterior phase rotation, nor repair of the acute-bearing alias earns
  adoption here.
- A matched-window decomposition exposes a quieter signal before the shared
  lateral miss. Replaying the four sampled completed traces, the body-frame
  target-ray drift `bearing_window_rate - turn_rate_recent` is only about
  `-0.02--0.05 rad/T` at the inbound `8--9L` crossings, but it rises
  consistently to `0.06--0.11 rad/T` at `5L`, `0.11--0.14 rad/T` at `4L`, and
  `0.17--0.23 rad/T` at `3L`. The subtraction uses rates over the same history
  window, cancelling most beat-scale body yaw rather than treating sideslip
  angle as a direct curvature error.

## Policy hypothesis

Retain the strongest completed alignment-gated `7 deg` carrier exactly: the
acute body-frame bearing, measured-yaw term, anterior joint-state oscillator,
posterior lag, signed tail mean, alignment gate, and command reserve all stay
in place. Add one mechanism only: a bounded lead term from the matched-window
target-ray drift to the existing steering error. Positive translational sweep
of the target ray then requests earlier same-side curvature, while the term
vanishes at startup and remains small on the evidenced far-field route. No
distance gate, velocity angle, world coordinate, hidden stage, clock, carrier
gain, or posterior phase change is introduced.

The expected useful change is preservation of the coherent far-field wake with
an earlier correction between roughly `5L` and `3L`, a shallower lower-side
pass, and a minimum below `2.443L`, ideally capture or a different useful
termination class. Falsify the mechanism if it repeats the course-aware upper
curl, damages early progress or wake coherence, increases clamp/load residence,
or retains the same powered lower exit and `2.4--2.9L` closest-approach band.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and bounded mean-curvature turning
source_mechanism: use observed target-direction dynamics to modulate a slow steering bias around an intact state-feedback propulsive rhythm
transferable_invariant: separate matched-window target-ray sweep from measured body yaw, then use only the bounded translational residual as anticipatory body-frame steering feedback
nontransferable_details: published gains, dimensional beat timing, robot or species kinematics, open-loop phases, exact vortex timing, and task-specific routes
policy_translation: add a saturated bearing-window-rate minus recent-turn-rate lead to the existing two-joint mean-curvature request while preserving the sampled posterior-lag carrier
falsification: reject on wrong-side release, degraded far-field progress or wake coherence, a short-radius curl, no improvement beyond 2.443L or the lower-exit topology, or greater actuator/load residence
```

## Implemented candidate and pre-CFD checks

The implemented candidate adds only the matched-window target-ray-drift lead
described above. Synthetic mirrored bearing/rate/joint states produce exactly
sign-mirrored finite commands, startup history produces zero lead, positive
and negative drift order anterior commands in the expected direction, and
extreme finite rate inputs remain bounded. All `324` repository tests pass.

Replaying completed observations through the steering map (not a hydrodynamic
rollout) gives only about `0.16--0.24 deg` mean curvature change above `8L`,
about `0.77--0.85 deg` between `5--8L`, and `0.77--0.98 deg` between `3--5L`
across all four sampled traces. Inside `3L`, the existing `7 deg` saturation
limits the mean change to `0.13--0.23 deg`. This is the intended bounded
mid-approach lead and is not evidence that the unevaluated candidate improves
CFD behavior.
