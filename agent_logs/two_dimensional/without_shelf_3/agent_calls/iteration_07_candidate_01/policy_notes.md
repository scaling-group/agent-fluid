# Wake-policy candidate diagnosis

## Evidence read before editing

- The shared prewarm sheet shows the common held fish at the upper-right and
  four developed, interacting vortex streets extending downstream through the
  target station. Because every sample loads this same snapshot, it establishes
  the release geometry and wake phase but does not distinguish controllers.
- The strongest finite sample, `solver_6d4abab307d3`, visibly turns from the
  release pose, swims left through the far-wake corridor, and then makes a broad
  upward bend before leaving the domain. This is active propulsion rather than
  passive advection: its head moves `-4.08L`, mean x velocity is `-0.0673`, and
  mean local flow x is only `-0.0457`. It reaches `6.71L` range with progress
  `0.217`, remains finite for `65.47` released time, and has moderate RMS
  force/moment `66.5/958`. The same diagnostics bound its joint excursion at
  `0.568/0.453 rad`, joint-one speed at `4.361 rad/time`, and acceleration at
  `27.78/25.54 rad/time^2`, so the localized guards are active near the
  actuator envelope without reproducing the parent's load spike.
- The assigned parent `solver_1f077a569164` follows the same visible topology
  but turns upward sooner: it moves only `-2.45L`, never gets closer than
  `10.35L`, exits after `47.35`, and raises RMS force/moment to `350/5007`.
  Its `16 deg` ceiling, absent turn damping, and different guard bundle make it
  unsuitable as a causal static-authority comparison.
- The two later controlled descendants do provide negative boundaries.
  Lowering the fixed steering ceiling from `12` to `10 deg`
  (`solver_d9efac4c1c29`) reduces upstream head travel to `-1.43L` and minimum
  range to `9.00L`. Adding up to `0.02` approach-only turn damping at the same
  `12 deg` ceiling (`solver_b30fdea3f171`) also begins the upward loop earlier,
  moving only `-2.48L` and reaching `8.59L`. Both remain low-load, so these are
  course/propulsion regressions rather than stability failures. All four
  sampled sheets end at the upper boundary, consistent with head y displacement
  clustered at `+1.73` to `+1.81L`; the best sample's rebound from minimum
  distance is therefore the current failure to target.

## Single candidate hypothesis

Use the complete `solver_6d4abab307d3` guarded angle-only architecture and
change only its proportional bearing gain from `0.60` to the already sampled
`0.75`, while holding the `12 deg` steering ceiling and `0.04` opposing recent
turn-rate gain fixed. The bounded `tanh` remains saturated at the same maximum
for large far-field bearing, so the progress-producing curvature and gait are
not given more peak authority. Near small bearing, the steeper unsaturated
slope should reverse or resize mean curvature sooner as the target-relative
course changes, without repeating the failed lower ceiling or added derivative
damping mechanisms.

The evaluation should preserve genuine upstream relative motion and at least
the `6.71L` approach while reducing the terminal positive-y excursion or
extending the finite release. Falsify the hypothesis if upstream displacement
falls materially below `-4.08L`, minimum range rises, force/moment returns
toward the assigned parent's `350/5007`, or the same roughly `+1.8L` upper exit
recurs. The current candidate has no same-worker CFD result; those tests belong
to the next evaluation.
