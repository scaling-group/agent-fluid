# Multi-Wake Candidate Diagnosis

## Evidence scope

- The live guidance exactly matches the assigned fresh-lineage parent
  `optimizer_e78dbe103512`. The sampled rollouts are the naive seed and three
  first-generation target-aware policies; all use the same certified held-fish
  prewarm.
- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting streets, with the target in their overlap
  corridor. Because this sheet is common to every rollout, it establishes the
  initial wake and geometry but does not rank policies.
- The inherited optimizer logs add one evaluated first-generation controller
  not present among the sampled solvers. It is used only as prior evidence;
  this worker's candidate has not yet had a CFD evaluation.

## Visual diagnosis and metric cross-check

The naive seed is the strongest finite rollout by score (`-14.294201`) and the
only sampled policy that develops a vigorous traveling bend. Its released
sheet shows the initially target-facing fish curl into a steep downward track,
pass well to the right of the target/wake corridor, and leave the lower domain.
The metrics agree: head displacement is `(-3.545,-13.300)L`, distance improves
only transiently to `8.615L` before ending at `12.123L`, and release lasts
`50.127` of `300`. Both joint velocity and acceleration reach the hard limits,
mean command energy is `1496.25`, and RMS lateral force/moment are
`21.94/541.70`. Mean velocity differs from mean local flow by only about
`(-0.031,-0.022)`, so the dramatic motion does not become efficient
target-directed translation.

The three sampled target-aware failures are the informative counterexample.
Their sheets show the fish remain nearly straight near the release location
and drift to the downstream boundary without entering the useful wake region
or making a genuine target approach. Each exits after only `16.27--16.73`
released units. Their minimum distances (`12.4235--12.4239L`) are essentially
the initial distance, progress is negative (`-0.1480` to `-0.1583`), and fish
velocity stays close to local-flow velocity. Although their `1.0--1.1` periods,
`12--24 deg` amplitude scales, and bounded steering reduce command-energy mean
to `0.218--1.513`, observed peak accelerations are only `1.09--6.59`, so they
remove the seed's clipping by failing to establish useful propulsion before
downstream exit.

The inherited unsoftened bearing/heading-rate policy supplies the other safety
boundary. Its two-frame sheet shows almost no translation before
`unstable_dynamics` at `1.009`; the diagnostics reach the angle, velocity, and
anterior acceleration caps with RMS force/moment about
`9.46e4/1.30e6`. Thus an abrupt raw turn-rate correction without smooth output
limiting is not a defensible way to start or steer the gait.

## Candidate hypothesis

Use one bounded intermediate controller that separates prompt gait startup
from target steering. A joint-state energy regulator will grow an oscillation
around the steering center faster than the weak first-generation Van der Pol
terms, with a `0.70` period and `22 deg` amplitude between the passive variants
and the clipped seed. A `26 rad/time^2` smooth acceleration limit keeps the
requested action below the episode's `31.416` hard cap; the corresponding
nominal joint-speed scale is about `3.45 rad/time`, below the `4.538` cap.

Target steering uses only bounded bearing and windowed bearing-rate feedback.
Positive bearing is corrected with a negative anterior curvature in the
documented body convention; the posterior target cancels only the oscillatory
anterior component, so the mean cumulative bend retains that steering sign.
No force, moment, raw heading-rate, global coordinate, elapsed time, prescribed
inflow, or remote wake probe is used.

The hypothesis is falsified if the fish does not develop visible oscillation
and material flow-relative upstream motion before the roughly `16`-unit
passive-exit time, if bearing grows under the chosen curvature sign, if joint
states persist at the hard limits, or if force/moment growth resembles the
inherited one-second instability. A longer finite rollout alone is not enough:
distance must fall beyond the seed's transient topology and the fish must turn
into the target/wake corridor.
