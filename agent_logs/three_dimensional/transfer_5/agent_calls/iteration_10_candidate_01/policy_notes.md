# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts are valid direct-uniform, zero-inflow episodes and
  terminate by capture. In both the top-down vorticity row and oblique Lambda2
  row, the fish is visibly self-propelled: a coherent alternating wake grows
  behind the tail as the body follows the target-directed arc. There is no
  prewarm wake, passive advection, boundary contact, or visible loss of the
  three-dimensional wake structure.
- The strongest progress sample is the direct phase-demodulated course brake
  (`solver_8ce1bc88a53c`): capture at `23.832T` with mean distance
  `2.434073L`. Hard course/yaw consensus (`solver_3b3fa6c1a86f`) and yaw-chosen
  direction (`solver_ceb6585a8076`) preserve essentially the same visible path
  and wake but arrive at `23.859T`/`2.434115L` and
  `23.854T`/`2.434214L`. Thus cue remapping did not create a useful trajectory
  change.
- The assigned half-cycle candidate (`solver_a16245299a15`) reduces terminal
  peak/mean absolute yaw inside `3L` from the direct-course sample's
  `3.208/1.684 rad/T` to `2.991/1.616 rad/T`, and mean absolute normalized yaw
  moment from `0.006402` to `0.006104`, but it delays capture to `23.909T` and
  worsens mean distance to `2.434609L`. Its joint-phase gate therefore buys
  modest yaw cleanliness by withholding too much useful terminal curvature.
- Across the four traces inside `3L`, normalized yaw moment has mean absolute
  magnitude `0.00610-0.00641`, a roughly `0.0107` 90th percentile, and its sign
  agrees with measured yaw acceleration for `97.2-97.7%` of samples with
  correlation `0.935-0.940`. This is a substantially more direct response
  observable than binary cue agreement or inferred beat side.

## Policy hypothesis

Restore the evaluated direct-course terminal brake, which retains the best
progress topology, and replace the regressive half-cycle gate with a bounded
moment-conditioned urgency multiplier. The existing carrier-rejected
route-relative yaw-rate error identifies whether the measured normalized yaw
moment is currently accelerating or decelerating the error. Course residual
continues to select the correction direction; moment can only scale its
magnitude within a narrow positive interval. This preserves the traveling
carrier and C-bend redirect while adding a genuinely new hydrodynamic response
mechanism rather than another scalar gain change.

Expected result: retain capture and coherent wake near the `23.832T` baseline,
while reducing terminal yaw/transverse motion and moment/load exposure without
the `0.077T` delay of the half-cycle gate. Falsify the mechanism if capture or
mean-distance progress regresses, if the wake/trajectory topology degrades, or
if terminal yaw, transverse speed, moment/load, joint-speed exposure, and
command exposure do not improve jointly.

```text
bookshelf_consulted: true
source_domain: wake-interaction control and terminal target capture
source_mechanism: separate slow target steering from bounded fast disturbance rejection, with response-conditioned approach damping
transferable_invariant: preserve the propulsive route loop and let a normalized hydrodynamic response alter only the urgency of near-target correction
nontransferable_details: published gains, species-specific body waves, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use body-frame-normalized moment_z_L2 and carrier-rejected route-relative yaw-rate error to bound a positive multiplier on the existing course-directed two-joint terminal C-bend
falsification: reject if capture/progress or coherent wake regresses, or if terminal yaw, transverse motion, loads, joint-speed exposure, and command exposure fail to improve together
```
