# Multi-wake target-policy candidate notes

## Prior evidence diagnosis

- The shared prewarm sheet confirms the common initial condition: the fish is
  held near the upper-right boundary while four interacting vortex streets
  develop toward the target. It is identical across candidates and is not
  candidate-specific credit.
- The target-blind seed is the strongest finite propulsion example, although
  it is still an informative failure. Its released sheet shows an active wake
  and upstream head displacement of `-3.545L`, but the trajectory curls into
  a nearly monotone descent of `-13.300L` and leaves the lower boundary after
  `50.127` release-time units. Both joints hit the `260 deg/time` velocity and
  `1800 deg/time^2` acceleration caps, moment RMS is `541.704`, and its
  closest approach of `8.615L` is lost before termination.
- All three evaluated target-bearing mean-curvature candidates materially
  reduce joint rates and accelerations, but none begins a useful turn or
  upstream traverse. Their released sheets show almost the same short path
  out of the right boundary after only `17.04--18.11` units, with head
  displacement `+2.17--2.20L` in x, progress from `-0.147` to `-0.143`, and minimum
  distance still `12.424L`. The small score differences therefore do not
  represent semantic improvement.
- The same-period/same-amplitude candidate `solver_fcd2b160ff34` is especially
  diagnostic: adding a bearing-dependent joint equilibrium to the seed gait
  lowers observed joint-1 excursion from `0.459` to `0.214 rad` and peak
  joint-1 acceleration from the `31.416 rad/time^2` cap to `7.873`, but it is
  carried downstream rather than self-propelling upstream. Together with the
  inherited notes, this falsifies the tested recentering implementations:
  actuator headroom alone is not useful if the equilibrium shift erases the
  initialized traveling bend before thrust develops.

## Policy hypothesis

Retain a zero-centered state-feedback oscillator and the posterior lag so the
configured `(+8,-8) deg` release bend remains a propulsive startup condition.
Replace the failed mean-curvature equilibrium with one compact mechanism:
bounded half-cycle acceleration asymmetry. Body-frame bearing strengthens the
joint-1 acceleration half-cycle toward the requested bend and weakens the
opposite half-cycle, with a smaller share of the same asymmetry applied to the
posterior follower; zero bearing recovers the symmetric propulsive scaffold.
Moderate the nominal gait inside the documented velocity envelope without
subtracting the initial bend through a steering center, and let joint 2 follow
the resulting asymmetric head wave while retaining a smaller compatible
half-cycle bias rather than receiving a separate static curvature equilibrium.

Expected evidence is upstream rather than `+2.17L` downstream displacement in
the first release segment, survival beyond `18.11`, and a trajectory that does
not reproduce the seed's `-13.30L` lower-boundary escape. Falsify the candidate
if propulsion still collapses into the short right-boundary exit, the bearing
grows with the induced asymmetry (wrong turn sign), the lower-boundary topology
returns, or persistent hard-limit contact is required to recover upstream
motion.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: strengthen the locomotor half-cycle that produces the requested turn while weakening the opposing half-cycle
transferable_invariant: persistent normalized body-frame direction error can bias a rhythmic gait through bounded left-right half-cycle asymmetry without moving the oscillator equilibrium or discarding posterior phase lag
nontransferable_details: published gains, robot geometry, dimensional beat frequencies, prescribed CPG phase, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: retain the zero-centered joint-state oscillator; map body-frame bearing through a smooth bound, asymmetrically scale both sign-resolved joint accelerations with a smaller posterior share, and retain the lagged tail target
falsification: reject if upstream propulsion is not restored, target-bearing response has the wrong sign, the short downstream exit or saturated lower exit remains, or load and cap occupancy rise without a meaningfully better trajectory
