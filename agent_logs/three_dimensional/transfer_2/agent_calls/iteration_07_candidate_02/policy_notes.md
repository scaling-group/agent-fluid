# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=0`; no prewarm artifact is present.
- The top-down vorticity and oblique Lambda2 rows show self-propulsion with a
  coherent, alternating three-dimensional wake rather than passive advection.
  The useful carrier should therefore be preserved outside the correction.
- The passage-recapture, recapture pivot-and-release, and persistent-route
  variants all follow the same useful early approach and then the same broad
  upper loop: minimum distances are `3.031`, `3.024`, and `2.996L`, followed
  by upper exits near `49.4T` with final distances `7.53`, `7.42`, and
  `7.52L`. Their similar force/moment scales and trajectory topology show that
  posterior recapture and late carrier relief do not reacquire the target.
- The assigned sector-pulse parent changes the topology. It stays on a
  westward runout and exits left at `39.70T`, but improves closest approach to
  `2.606L` at `24.525T`. Around `20--24T` its target direction moves from
  normalized body-frame `(forward,lateral)=(0.55,0.84)` to approximately
  `(-0.09,1.00)`: the bounded closing-sector correction acts in the useful
  interval, yet the fish passes about `2.5L` below the target before enough
  yaw develops.
- This is not weak propulsion or a load instability. All examples remain
  numerically stable with similar peak normalized planar force
  (`|Fx|<=0.0143`, `|Fy|<=0.0276`) and yaw moment (`|Mz|<=0.0149`). The more
  direct limitation is allocation: the sector parent exposes at least one raw
  joint acceleration above the actuator envelope on `92.24%` of samples and a
  joint-rate limit on `12.70%`, so extra steering summed after the carrier is
  often presented to the hard clip instead of receiving reliable authority.

## Policy hypothesis

Preserve the parent's body-frame, closing-sector pulse and the demonstrated
phase-selective carrier everywhere else. During that pulse only, split each
joint command into carrier and steering components and smoothly reserve the
finite acceleration envelope for bounded curvature/turning before admitting
the remaining carrier. This implements an observed-state pivot-and-release:
it is dormant on the common target-ahead approach, becomes strongest as the
target approaches abeam with material lateral error, and restores the full
traveling wave when closing stops or the target moves deeply posterior. The
falsifiable expectation is earlier useful negative yaw during the existing
`~16--25T` correction window, a closest approach below `2.606L`, and less raw
acceleration exceedance without the sampled broad upper loop. Reject it if it
changes the pre-gate trajectory, suppresses propulsion after release, worsens
closest approach, or merely exchanges the left exit for the same upper loop.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish turning
source_mechanism: C-start-like burst redirect with response-gated release
transferable_invariant: under large observed target-angle error, temporarily prioritize bounded curvature over the propulsive rhythm, then restore propulsion as the redirect gate releases
nontransferable_details: species kinematics, published gains, dimensional timing, exact vortex phase, and any task-specific route
policy_translation: use the existing normalized body-frame closing-sector pulse as a mirror-equivariant gate; within that gate reserve joint-acceleration headroom for mean-curvature and turn terms before admitting carrier acceleration
falsification: reject if the gate perturbs the common early approach, fails to beat the parent's 2.606L minimum, retains pervasive in-gate clipping, destroys the coherent wake, or latches into the completed upper-loop failure
