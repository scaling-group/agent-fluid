# Candidate diagnosis and hypothesis

## Inherited and sampled evidence

- The assigned parent establishes that the naive joint-state oscillator makes a
  coherent traveling bend but lacks target-relative course recovery. Its later
  posterior mean-curvature family preserves propulsion yet repeatedly crosses
  into diverging bearing and exits the upper boundary; static-offset tuning is
  therefore not a sufficient new mechanism.
- The inherited completed-rollout logs progress from a weak step-2 result
  (`11.655L` minimum) to the unrelieved bearing-minus-slip carrier at step 3
  (`2.960L` minimum, `7.786L` final), then to posterior-only approach relief at
  step 4 (`3.162L` minimum, `6.555L` final) and a full-quadrant static redirect
  at step 5 (`2.999L` minimum, `6.335L` final). All still terminate
  `left_domain`; no completed result demonstrates capture or course recovery.
- All four sampled diagnostics confirm direct uniform still-water initialization
  with no prewarm. Their trajectories are nearly identical through about
  `12T`: speed rises to about `1.0U`, distance falls from `12.328L` to about
  `6.67L`, and the combined top-down/oblique sheets show a coherent alternating
  mid-plane and three-dimensional wake. This is self-propulsion, not advection.
- The best sampled scalar result, the approach-hold variant, scores `-7.749`
  but reaches only `3.592L`. Its joints decay to an almost static posterior bend
  while the fish still coasts at `0.726U` into the upper boundary at `21.54T`.
  The most informative redirect failure reaches `2.999L`, but its distributed
  static bend freezes near `(-10,-12) deg`; it likewise coasts at `0.733U` and
  exits high at `23.24T`. Thus lower joint demand and freed actuator reserve did
  not become corrective hydrodynamic action. The sampled distance schedules
  (`3.032L`, `3.162L`, and `3.592L`) all miss farther than the inherited
  unrelieved `2.960L` approach.
- Visually, both compared sheets retain a clean alternating wake in the broad
  approach and rotate into a near-vertical upper hook after passing high. The
  synchronized traces agree: full-quadrant target bearing grows from roughly
  `-0.4 rad` near `14T` to beyond `-1 rad` near closest approach, while the
  speed remains approximately `0.7--0.8U`. Uniform carrier attenuation and a
  static C-like redirect therefore remove or freeze the rhythm without arresting
  the inertial miss.

## Policy hypothesis

Restore the unrelieved anterior oscillator and posterior lag carrier. Retain
the evidenced posterior mean-curvature/slip channel, but compute target angle
from normalized `target_body_L` so a rearward target is not folded into the
front half-plane. Add one new actuator primitive: once full-quadrant angular
error is materially outside the broad-approach corridor, infer the posterior
carrier side from `(phi1, phi_dot1)` and attenuate only the half-cycle opposed
to the requested turn. The aligned half-cycle remains at the demonstrated
carrier amplitude and the opposing half-cycle has a nonzero floor. This should
create active turning impulse without the peak amplification, carrier-wide
relief, or static-joint collapse seen in the samples.

The next CFD evaluation should falsify the hypothesis if wake alternation or
far-field progress is lost, joint-limit occupancy materially increases, the
rhythm collapses to a fixed bend, or closest approach/upper-exit topology does
not improve relative to the `2.960L` unrelieved benchmark.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical asymmetric fish turning
source_mechanism: half-cycle amplitude or duty-ratio asymmetry during a propulsive rhythm
transferable_invariant: preserve the traveling wave while favoring the half-cycle that produces the requested turn
nontransferable_details: published gains, clock-driven CPG phase, species-specific envelopes, exact duty ratios, and task routes
policy_translation: use normalized full-quadrant target_body_L and body slip for turn direction, infer carrier side from joint state, and bound the counter-turn half-cycle multiplier above a nonzero floor
falsification: reject if broad-approach propulsion or 3D wake coherence degrades, limit occupancy rises, the joints settle to a static bend, or bearing and termination class do not improve
```
