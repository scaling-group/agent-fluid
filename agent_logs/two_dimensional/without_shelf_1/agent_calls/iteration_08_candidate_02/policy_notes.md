# Candidate wake-policy notes

## Evidence diagnosis

The shared prewarm sheet fixes a common developed four-street wake with the
held fish above and downstream of the target.  The released sheets show that
all four sampled heading-rate variants self-propel upstream but miss the useful
wake corridor: each first translates left across the quiet upper region, then
turns nearly vertical and exits the upper boundary after about `+1.20L` center
displacement.  This topology is not passive advection.  For the sampled
`turn_rate_damping=0.70`, `turn_rate_scale=0.35` best case, mean fish velocity
is `-0.1300 L/time` while mean local flow is `-0.0908`; it reaches `0.3796`
progress, `5.334L` minimum distance, and `-6.934L` head displacement before
the loop.

The assigned parent's sensitivity hypothesis is falsified by its evaluated
child.  Lowering only `turn_rate_scale` from `0.35` to `0.25` at gain `0.70`
leaves the same upper exit, but progress falls from `0.3796` to `0.2911`,
minimum distance worsens from `5.334L` to `6.414L`, mean distance rises from
`8.026L` to `9.024L`, and upstream head displacement falls from `-6.934L` to
`-5.295L`.  The current `0.80` gain bracket also retains the loop and regresses
to `0.3512` progress and `5.660L` minimum distance.  Together with the inherited
`1.05` result (`0.3686` progress, `5.644L` minimum distance, and higher
`334/3463` RMS force/moment), these samples close the heading-rate gain and
sensitivity continuation.  Every sample still reaches both joint-rate and
command caps; the best case also reaches `0.770 rad` posterior angle, so the
remaining visible failure is excessive sustained posterior steering rather
than inadequate propulsion.

## Policy hypothesis

Restore the evidence-best gait and `turn_rate_damping=0.70` at scale `0.35`,
but replace only the target-bearing component of posterior steering.  The
prior `tanh(bearing / 25 deg)` maps the initial approximately `8.5 deg` target
error to about `0.33` of full bias even though the fish already points close to
the target.  Use the normalized body-frame lateral unit direction
`lateral_distance_L / distance_L` instead; it is bounded in `[-1,1]`, preserves
the evidence-backed positive target-to-posterior sign, and requests only about
`0.15` of full bias initially while remaining responsive as lateral
misalignment grows.  Steering remains posterior-only, and no coordinate,
target identity, time, route, wake probe, or prescribed inflow enters the
policy.

This candidate is supported only if it preserves useful self-propelled
upstream progress while reducing the upper displacement or visibly bending
toward the target before the prior exit.  Repeating an approximately `+1.20L`
upper exit, losing progress below `0.3796`, or failing to reduce posterior
saturation falsifies lateral-unit-direction steering.  A later worker should
then restore the `0.70/0.35` anchor and abandon simple memoryless target
geometry in the posterior equilibrium rather than retuning heading-rate gain,
heading-rate sensitivity, bearing scale, or propulsion.
