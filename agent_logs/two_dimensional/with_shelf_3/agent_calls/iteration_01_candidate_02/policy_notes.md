# Multi-wake policy candidate notes

## Evidence diagnosis before policy edit

- Evidence scope: the workspace contains one sampled finite rollout, the common
  naive seed (`solver_4b03cd285d3a`), and no successful or near-successful
  comparator. It is therefore both the best finite example and the only
  informative failure; conclusions below are deliberately limited to repairing
  its failure topology.
- The held-fish prewarm sheet shows four developed, interacting vortex streets
  extending through the target corridor before release. This is shared initial
  condition evidence, not policy evidence.
- Released keyframes show active undulation and self-motion, but the fish turns
  from its initially useful upstream-left orientation into a steep descent. It
  never approaches the second-row target corridor and exits through the lower
  boundary after `50.1269` released time units.
- The metrics agree with the visual diagnosis: head displacement is
  `(-3.545L, -13.300L)` although the initial target displacement is primarily
  upstream; minimum distance remains `8.615L`, progress is only `0.0243`, and
  termination is `left_domain`. Both joints reach the `1800 deg/time^2`
  acceleration cap and `260 deg/time` velocity cap, while moment RMS is
  `541.704`. Thus the seed already produces strong motion, but has no mechanism
  to turn that motion toward the target. More oscillator gain alone is not a
  supported remedy.

## Candidate hypothesis

Retain the state-feedback oscillator and posterior lag because they visibly
produce propulsion. Add one bounded target-bearing-to-mean-curvature mechanism:
recenter the anterior oscillator about a body-frame bearing-dependent bend and
give the posterior target a smaller same-sign mean bend while preserving the
traveling-wave component. Bounding the bias at `10 deg` leaves nominal room
inside the `45 deg` joint limits, and keeping all seed propulsion values fixed
makes the new steering structure the interpretable change.

Expected test: compared with the sampled seed, released motion should retain a
clear upstream component, avoid the immediate near-vertical descent, improve
minimum/mean distance, and change termination from lower-domain exit toward a
horizon miss or target capture without increasing saturation or load spikes.
Falsify the transfer if the turn sign is wrong, the same lower-exit trajectory
persists, the traveling bend collapses, or joint/load saturation becomes more
persistent.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and classical fish turning
source_mechanism: sensor-modulated CPG mean-curvature or tail-beat bias
transferable_invariant: persistent body-frame target error can steer an otherwise propulsive rhythm through a bounded average bend
nontransferable_details: published gains, actuator geometry, species kinematics, exact beat timing, vortex phase, and source-task routes
policy_translation: map bounded body-frame bearing to anterior oscillator equilibrium and a smaller same-sign posterior mean bend while retaining state-derived phase lag
falsification: reject if target-relative turning has the wrong sign, upstream progress does not improve, propulsion collapses, or saturation and moment loads worsen
