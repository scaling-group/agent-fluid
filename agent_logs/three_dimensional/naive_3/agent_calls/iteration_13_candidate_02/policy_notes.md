# Response-gated terminal drive-relief candidate

## Visual diagnosis and inherited evidence

- The four sampled rollouts and both inherited parent rollouts report direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm. Their translation is self-propelled rather than ambient
  advection.
- The sampled full-quadrant redirect (`solver_bf09617243bd`) is the strongest
  finite sampled approach at `2.999L`. Its top-down vorticity row and oblique
  Lambda2 row show a coherent alternating three-dimensional wake during the
  approach, but the joints approach a held redirect near the pass and the path
  hooks into the upper boundary. The sampled anterior half-cycle stiffness
  case (`solver_eaa778e34ed6`) keeps alternating shedding yet reaches only
  `4.859L`, raises raw acceleration-envelope exceedance, and repeats the upper
  exit. Wake coherence alone therefore does not supply target recovery.
- The assigned parent's speed-gated body-frame velocity-course controller is a
  meaningful semantic improvement. Both visual rows retain alternating wake
  structures through a substantially different, target-directed trajectory;
  closest head distance improves to `0.857L`, only `0.107L` outside the
  `0.75L` capture radius, and termination moves from the common upper hook to
  the left boundary at `(0.799,11.381)L`. Peak swimming speed is `1.052U`,
  whereas peak local flow is only `0.031U`, so neither the near pass nor the
  later overshoot is passive advection.
- At the parent's closest approach (`19.058T`), swimming speed remains about
  `0.845U`; distance has fallen from `2.041L` at `17.001T` to `1.281L` at
  `18.001T`, with radial closing still about `0.923U` and `0.652U` at those
  samples. The velocity-course error is already saturated in the requested
  direction near the pass, so adding another steering residual does not
  address the evidenced excess closing energy.
- Earlier broad distance relief is a negative boundary, not a reusable recipe:
  activating carrier relief around `5--6L` worsened closest approach to
  `3.162L` or `3.592L`. Inherited posterior counterstroke relief and a
  receding-gated distributed burst also retained the upper-exit topology at
  `2.978L` and `2.959L`. A terminal schedule is justified here only because
  course feedback first established a repeatable sub-`1L` approach; it must be
  narrow, preserve the anterior oscillator and mean-curvature steering, and
  release when motion becomes target-receding.

## Policy hypothesis

Preserve the assigned parent's full-quadrant velocity-course feedback,
zero-centered anterior Van der Pol oscillator, posterior lag, and bounded mean
curvature exactly outside the terminal neighborhood. Within a narrow
body-length range, smoothly attenuate only the oscillatory posterior carrier
while normalized radial motion is target-closing. Keep the anterior rhythm and
posterior mean curvature active, and release the attenuation continuously as
closing changes sign. This is one response-gated drive-relief mechanism rather
than another steering gain or a held redirect.

The expected result is the parent's coherent broad approach with less forward
impulse over its final `1--2L`, enough time for the already saturated
course-curvature request to cross the `0.75L` circle. Falsify it if it changes
the wake or trajectory before `2.25L`, stalls outside capture, materially
increases joint-limit occupancy, worsens the `0.857L` closest approach, or
fails to release after a miss.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical posterior traveling-wave propulsion
source_mechanism: preserve the target-directed rhythmic carrier in the far field, then continuously relieve propulsive wave amplitude near capture according to range and radial response
transferable_invariant: terminal drive relief is appropriate only after broad target-directed motion works; keep steering authority active, avoid coasting too soon, and release relief when target-closing motion is lost
nontransferable_details: published CPG gains, dimensional distance and speed thresholds, species-specific gait envelopes, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame velocity-course steering; form radial closing from target_body_L and velocity_body_U; use smooth range and closing gates to attenuate only the posterior traveling component while preserving anterior rhythm and bounded mean curvature
falsification: reject if broad approach changes, alternating 3D shedding is lost, the fish stalls outside capture, closest distance does not improve beyond 0.857L, limit occupancy rises materially, or relief remains active after target-receding motion begins
```
