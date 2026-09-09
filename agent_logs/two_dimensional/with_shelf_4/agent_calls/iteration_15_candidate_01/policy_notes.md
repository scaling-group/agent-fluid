# Multi-wake policy candidate notes

## Evidence diagnosis

- The assigned parent and all four sampled solver examples use the same
  functional policy.  Their released keyframe sheets and prewarm sheets have
  identical hashes, and every rollout reaches the `0.75L` target after
  `137.357` released time units with `4.184L` mean distance, `-10.914L`
  upstream head displacement, and `90228` total command energy.  This is useful
  deterministic replication, not four independent controller mechanisms.
- The released sheet shows self-propelled upstream translation, a broad early
  targetward redirect, entry into the interacting wake region, continued
  alternating bends, and a clean target crossing.  This agrees with the
  `target_reached` termination, `0.9397` progress, and finite
  `0.1296/14.75/303.02` RMS relative crossflow/force/moment metrics.  There is
  no visible collision, passive downstream advection, or loss of the
  traveling wave to repair.
- The strongest remaining actuator warning is anterior acceleration:
  `max_abs_phi_ddot1=30.846` rad/time^2 is about 98% of the configured
  `31.416` rad/time^2 hard limit.  The inherited seed failure was more severe
  (both joint velocity and acceleration limits plus a bottom exit), while
  later scalar, bearing-history, tail-lag, and unconditioned additive-flow
  changes retained capture but delayed it.  Therefore this candidate must not
  weaken route ownership, move steering into the tail, or tune oscillator
  gains from the scalar score.
- No distinct failure keyframe exists under `solver_examples`: all four visual
  sheets are byte-identical successes.  The deeper inherited optimizer logs do
  contain the `279.439`-unit posterior-steering regression.  Its inspected
  sheet preserves alternating bends but makes repeated large loops above and
  below the useful wake corridor before eventual capture, consistent with its
  `6.982L` mean distance and nearly doubled `182836` energy.  That rules out
  changing the relative anterior/posterior steering distribution here; the
  proposed common actuator interface acts on both already-computed commands.

## Policy hypothesis

Preserve the replicated route and gait controller exactly through its raw
two-joint acceleration calculation, then pass both commands through one short,
continuous first-order actuator-tracking filter.  The filter uses only
`state.previous_action` and normalized nondimensional `state.history_dt`, with
its response time owned by `target_policy_params`.  It should trim transient
near-limit acceleration and command effort without filtering target bearing or
changing the anterior/posterior traveling-wave contract.  Reject the mechanism
if it loses target capture or upstream translation, delays the `137.357`
arrival materially, destroys alternating bends, or fails to improve effort or
peak/load behavior together.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and low-dimensional rhythmic actuator commands
source_mechanism: sensor-feedback tracking of a coherent oscillator command through bounded actuator dynamics
transferable_invariant: preserve the propulsive traveling-wave command while suppressing unrealizable fast acceleration changes at the actuator interface
nontransferable_details: published CPG gains, hardware servo constants, clock-driven phases, species kinematics, and exact wake timing
policy_translation: apply one timestep-aware first-order filter to both raw joint accelerations using previous applied action and normalized history dt
falsification: reject if capture, upstream translation, or the alternating wave is lost, or if arrival and effort/load do not improve jointly
