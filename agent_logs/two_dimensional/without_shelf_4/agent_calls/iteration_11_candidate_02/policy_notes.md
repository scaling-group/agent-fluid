# Wake-policy candidate diagnosis

## Evidence scope

- The assigned parent is the prefilled `20.25 deg`, `0.67`-period controller
  with `0.30` bearing scale and `0.25` bounded bearing-rate lookahead. This
  diagnosis uses only the workspace task contract, current guidance, the four
  sampled solver results, and inherited optimizer score logs. No omitted shelf,
  neighboring configuration, repository history, external VTK, or archival
  video was used.
- All four sampled shared-prewarm sheets have the same digest. They show the
  fish held at the upper-right release pose while four developed vortex streets
  fill the route to the target. All four released sheets also have the same
  digest and the same trajectory/diagnostics, despite comment or parameter-name
  differences in two candidate files, so they are replications rather than four
  independent control mechanisms.
- No sampled failure keyframe is materialized in this workspace. The strongest
  local visual comparison is therefore the replicated finite success against
  the inherited horizon miss in the optimizer score logs; visual claims below
  are limited to the local success sheet, while failure claims use metrics only.

## Visual and metric diagnosis

- From release to capture, the fish first dives from the upper-right pose, then
  makes repeated broad down/up reversals before approaching the target from the
  right. It eventually enters the developed wake region and crosses the
  `0.75L` target ring at `244.547`, but the polyline and changing headings show
  route-scale yaw reversals rather than merely tailbeat-scale lateral motion.
- The controller is self-propelling upstream rather than being passively
  advected: mean x velocity is `-0.04443`, versus mean local-flow x `-0.03649`,
  leaving `0.00793` controller-relative upstream transport. Capture progress is
  `0.93965`, but the broad route produces `6.452L` mean distance and a
  `4.293L` maximum absolute lateral target offset.
- Propulsion is already close to its local safety guard and should not be
  intensified. The sampled maxima are `0.3531/0.4404 rad` joint angles,
  `3.316/2.497 rad/time` joint rates, and `31.055/23.436 rad/time^2`
  accelerations. The anterior acceleration is just below the policy's `31.2`
  guard and the `31.416` episode hard limit. RMS lateral force and moment are
  `18.263` and `362.214`.
- The informative inherited miss ended at the horizon after only `0.7077`
  progress, with `3.290L` minimum and `3.632L` final distance, `8.447L` mean
  distance, and higher mean command energy `708.034`, even though RMS lateral
  force fell to `17.349`. Inherited `0.20`-lead/closing-relief variants also
  captured later and had worse mean distance and lateral force than the
  `0.25` anchor. Thus neither lower force by itself nor another constant
  bearing-lead sweep is evidence of corridor retention.

## Single policy hypothesis

Preserve the demonstrated propulsion, posterior phasing, static bearing scale,
and `0.25` bearing-rate lookahead exactly. Add one separately bounded
body-frame yaw-rate term to the steering prediction:

```text
steering_error = bearing + 0.25 * bounded_bearing_rate
                 - 0.08 * bounded_turn_rate
```

`turn_rate_recent` is the policy-facing heading-rate observation. The negative
term weakens curvature while the body is already rotating in the commanded
direction, without weakening correction caused by translational bearing drift.
Clamping it to `0.30` limits its contribution to `0.024 rad` of predicted
bearing, or at most about `0.8 deg` of posterior bias near the linear region.
This is deliberately small because the current anchor captures reliably.

The candidate is supported if it preserves finite capture and upstream margin
while reducing route reversals, `6.452L` mean distance, `4.293L` lateral offset,
or lateral force/moment. It is falsified by lost or materially later capture,
guard contact, mean distance or offset at/above the anchor, increased loads or
command effort, or reduced controller-relative upstream transport. The current
worker does not claim an outcome; formal CFD occurs after exit.
