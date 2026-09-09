# Candidate diagnosis and hypothesis

## Prior evidence

- The only sampled solver is the common target-blind seed. Its released rollout
  failed by `left_domain` after 50.127 time units. It briefly reduced distance
  to 8.615 L, but finished at 12.123 L after head displacement
  `(-3.545, -13.300) L`; this is useful initial propulsion followed by loss of
  route control, not a collision or numerical-instability failure.
- In the released keyframes, the fish initially follows the desired left/down
  diagonal, then turns into a tight downward arc while still well downstream
  of the cylinders and exits through the lower boundary. The dense interacting
  wakes are visible around and downstream of the cylinder rows, but the fatal
  turn begins before the fish reaches the target or obstacle region. The best
  finite segment is therefore the initial diagonal approach; no successful or
  horizon-surviving comparison candidate is available in this fresh lineage.
- Both joint accelerations reach 31.416 rad/time^2 and both joint speeds reach
  4.538 rad/time, exactly the configured 1800 deg/time^2 and 260 deg/time
  limits. The 0.55-period rhythm is estimated at 32.83 times the cylinder
  shedding frequency. Thus the seed does not establish that stronger or faster
  beating is useful, and scalar-only gain escalation would be poorly grounded.
- The inherited optimizer guidance contains no completed child logs or
  comparative controller result beyond this seed, so it cannot establish the
  sign or benefit of a wake-phase, force, or moment residual.

## Policy hypothesis

Preserve the seed's state-encoded traveling bend, but make its equilibrium a
bounded mean curvature derived from body-frame target bearing. Slow and reduce
the oscillator enough that its nominal anterior motion fits inside the hard
speed and acceleration envelope, leaving steering authority. Apply a smaller
share of the same curvature to the posterior target so steering does not erase
the lagged propulsive wave. Do not add instantaneous vortex, force, or moment
rejection on this first candidate because the single sampled failure does not
separate their sign from the fish's own target-blind turn.

Expected test: compared with the seed, target bearing should remain bounded as
the fish continues leftward, the early downward hairpin/lower-domain exit
should disappear or occur materially later, and joint-limit contact and mean
command energy should fall. Falsify the mechanism if it preserves the same
downward-exit topology, reverses the initial target progress, or replaces it
with persistent static curvature and lost propulsion.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and classical fish turning
source_mechanism: sensor-driven bounded mean-curvature bias superposed on a traveling bend
transferable_invariant: persistent target error should shift average body curvature while posterior lag preserves propulsion
nontransferable_details: published gains, species-specific envelopes, dimensional beat rates, exact wake phase, and task-specific routes
policy_translation: map clamped body-frame bearing to a bounded joint-angle equilibrium and retain a lagged second-joint state target
falsification: reject if target progress is lost, the same downward exit persists, limit contact remains dominant, or static bend suppresses the traveling wave
