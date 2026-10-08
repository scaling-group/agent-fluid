# Candidate diagnosis and hypothesis

## Inherited and sampled evidence

- The assigned parent and every sampled diagnostic report direct uniform
  still-water initialization, `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. In both rows of the combined sheets, the fish moves left while an
  alternating mid-plane vorticity street and three-dimensional Lambda2 trail
  develop behind it. The broad approach is therefore self-propulsion, not
  advection.
- The unrelieved bearing-minus-slip carrier is the useful reference: it keeps
  both joints rhythmic and reaches `2.960L`, but full-quadrant bearing becomes
  strongly negative and the fish exits the upper boundary. Distance-based
  carrier relief reaches only `3.162L` or `3.592L`; its late wake fades while
  the joints approach a fixed posterior bend and the fish coasts out near
  `0.73U`. A full-quadrant C-like redirect likewise settles near
  `(-10,-12) deg`, reaches `2.999L`, and coasts into the same exit. Removing
  rhythm or creating a static center does not turn freed actuation reserve
  into corrective impulse.
- The inherited tail-only counterstroke policy keeps an active wake but reaches
  `2.986L` and finishes at `6.616L`, again by upper exit. Tail-only half-cycle
  allocation therefore changes demand without a semantic improvement.
- The latest inherited phase-lag contraction is a narrower positive result. It
  preserves a visibly coherent alternating wake through the close pass,
  improves minimum distance from `2.960L` to `2.682L`, and keeps both joints
  oscillating. The trace nevertheless places the fish near `(9.91,12.18)L` at
  `18T`, with full bearing about `-1.52 rad` and speed about `0.79U`; it then
  remains actively propelled to an upper exit at `27.61T`, finishing `8.020L`
  away. Posterior wave-shape modulation influences the pass, but it neither
  corrects the several-body-length vertical miss nor recovers after the target
  enters the rear quadrant.
- Across the useful carriers, the control residual becomes urgent before
  full-quadrant bearing alone is large: near `12T`, lateral body velocity is
  about `+0.64--0.66U` while bearing is near zero. Bearing-minus-slip already
  requests the opposite turn then, but posterior-only mechanisms do not recruit
  the anterior joint. Raw acceleration demand is already limit-heavy, so the
  evidence does not support a larger carrier or curvature cap.

## Policy hypothesis

Restore the unrelieved zero-centered anterior oscillator, posterior lag, and
bounded posterior mean-curvature/slip channel. Add one new actuator mechanism:
when the bounded bearing-minus-slip request is large, infer the anterior beat
side from `phi1` and smoothly slow only the half-cycle already bent in the
requested direction. The opposite half-cycle and the entire small-error
carrier remain unchanged, and the selected half-cycle retains a nonzero
acceleration floor. This state-feedback duty asymmetry should recruit anterior
body curvature without a static center, peak amplification, clock phase, or
world-frame route. Slip-based activation should begin during the evidenced
centerline crossing rather than waiting for large rear-quadrant bearing.

The next CFD result should falsify the hypothesis if the broad-approach wake or
progress changes before a meaningful steering request, the anterior joint
sticks on one side, angle/rate/acceleration limit occupancy rises materially,
or minimum distance and upper-exit topology do not improve over the `2.960L`
unrelieved carrier and the `2.682L` lag-modulation pass.

An actuator-only integration at the evaluator timestep and `45/260/1800`
envelope bounds the mechanism without predicting its fluid outcome. With a
persistent full negative request applied after `12T`, the `0.35` acceleration
floor keeps the anterior joint oscillating from about `-38.3` to `+26.3 deg`
through `28T`, with a mean near `-6.8 deg`, no angle-limit contact, and less
raw acceleration clipping than the symmetric carrier. This supports testing a
distributed rhythmic bend rather than recreating the fixed `-10 deg` redirect.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical asymmetric fish turning
source_mechanism: sensor-driven half-cycle duty asymmetry superposed on a propulsive traveling bend
transferable_invariant: preserve the traveling wave while spending more of each beat on the body-curvature side requested by target-relative error
nontransferable_details: published gains, clock-driven CPG phase, species-specific envelopes, exact duty ratios, dimensional cadence, vortex phase, and task-specific routes
policy_translation: use normalized full-quadrant target_body_L and bounded body lateral slip for turn request, infer anterior phase from joint state, and slow only the requested-side anterior half-cycle above a nonzero floor while retaining the posterior lag carrier
falsification: reject if far-field propulsion or 3D wake coherence degrades, the anterior joint becomes static or more limit-heavy, or closest approach, bearing containment, and termination class do not improve
```
