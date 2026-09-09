# Multi-wake target-policy candidate notes

## Prior evidence and visual diagnosis

- The shared prewarm sheet shows the common upper-right release pose and four
  interacting vortex streets advecting across the target. It is identical
  across candidates and supplies an initial condition, not policy credit.
- The target-blind seed visibly sustains a traveling bend but curls into an
  almost monotone lower-boundary escape. It lasts `50.127`, moves its head
  `(-3.545,-13.300)L`, reaches only `8.615L` minimum distance, and contacts
  both the `260 deg/time` velocity and `1800 deg/time^2` acceleration caps.
- Posterior-only half-cycle amplitude variants preserve that same failure
  topology. `solver_785c44ad57e0` modestly improves upstream displacement to
  `-4.557L` and minimum distance to `8.203L`, but still moves `-13.291L`
  laterally and exits at `54.896`; its opposite-sign relative
  `solver_ab5b90e78e2b` is slightly worse in upstream displacement and closest
  approach. The sheets do not support more posterior amplitude-asymmetry gain.
- `solver_928f830d4c45` is the strongest finite trajectory and a semantic
  propulsion improvement over both the seed and the earlier equilibrium-shift
  family. Its acceleration half-cycle asymmetry moves the head `-9.726L`
  upstream, survives `91.245`, and reaches `4.621L` minimum distance. The
  released sheet nevertheless shows the path pass below the target and end in
  the same lower-boundary class, with `-13.313L` lateral displacement.
  Joint 1 grows to `0.732 rad` (about `42 deg`), both joint velocities reach
  the hard cap, and force/moment RMS rise from the seed's `21.94/541.70` to
  `314.32/3430.21`. Thus anterior half-cycle asymmetry recovered upstream
  propulsion but is neither sufficient steering nor a safe axis to increase.

## Policy hypothesis

Preserve the evaluated slower zero-centered oscillator and anterior
half-cycle acceleration asymmetry as the upstream propulsion scaffold, but
separate posterior steering from that mechanism. A bounded prediction of
body-frame bearing, formed from current bearing plus its short-window rate,
sets a mean total-tail curvature while the original posterior phase lag
continues to carry the traveling wave. As the bearing closes, the rate term
releases the mean curvature rather than waiting for the target to cross the
body axis. Smooth joint-angle envelopes fade the added anterior asymmetry and
posterior mean curvature near the owned soft bend limit; the symmetric
oscillator and lagged follower remain available to restore the normal gait.

Expected evidence is retention of substantial negative/upstream x
displacement, less than the repeated `-13.29--13.31L` lateral loss, survival
beyond `91.245` or a better termination class, and reduced joint-angle/
velocity-cap contact and force/moment RMS. Falsify the candidate if posterior
mean curvature erases upstream propulsion like the prior oscillator-
equilibrium shifts, if the bearing response turns with the wrong sign, if the
same lower exit persists without a better distance history, or if the new
curvature causes collision or comparable load growth.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and adaptive wake swimming with observation history
source_mechanism: separate a rhythmic propulsion scaffold from bounded sensor-driven direction modulation, using recent target-error response to release the turn command
transferable_invariant: persistent normalized body-frame direction error should bias posterior wave shape, while the error rate distinguishes a growing miss from an already-correcting turn and joint state bounds the added authority
nontransferable_details: published gains, prescribed CPG phase, robot or species geometry, dimensional frequencies, exact vortex phases, fixed routes, and source-task state histories
policy_translation: retain the joint-state anterior oscillator and its evidenced half-cycle propulsion; map bearing plus short-window bearing rate to bounded total-tail mean curvature, preserve the posterior velocity lag, and taper anterior asymmetry near a candidate-owned bend envelope
falsification: reject if upstream displacement collapses, the target-bearing sign is wrong, lateral loss remains near 13.3L without a better distance trajectory, or angle/velocity/load evidence does not improve
