# Wake-policy candidate notes

## Inherited and sampled evidence

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm.
  Translation and wake formation are therefore policy-generated rather than
  ambient advection.
- The top-down rows show coherent alternating signed-vorticity structures
  throughout broad travel, and the oblique rows confirm persistent 3D
  Lambda2 structures. In every case the wake axis turns upward with the body
  after the near pass; the common failure is an actively propelled hook, not
  wake collapse or numerical instability.
- The three distance-only carrier reallocations reach minima of `3.162L`,
  `3.592L`, and `3.032L` and all leave through the upper boundary. The best
  scalar score, `-7.749`, comes from lower mean/final distance rather than a
  capture or improved termination class, so another distance threshold or
  carrier-floor edit is not supported.
- The assigned parent's full-quadrant, large-error C-bend candidate also
  repeats the upper-exit topology: minimum distance is `2.999L` at about
  `17.67T`, final distance is `6.335L`, and exit occurs at `23.24T`. Once its
  redirect gate is fully active, the joints settle near `(-10,-12) deg` with
  nearly zero rate and acceleration. The body then coasts past and upward.
  Thus a response-gated static distributed bend can consume the rhythmic
  state without supplying the hydrodynamic impulse needed to redirect the
  moving body; its small closest-distance change is not semantic recovery.
- The full normalized `target_body_L` vector remains useful because the
  adapter's scalar bearing folds the rear half-plane through `abs(x)`. Joint
  angle and velocity also expose carrier phase without a clock or mutable
  oscillator state.

## Policy hypothesis

Restore the demonstrated zero-centered anterior oscillator and unattenuated
posterior traveling carrier. Retain the bounded bearing-minus-body-slip mean
turn, using a signed full-quadrant target angle. Add one distinct actuator
mechanism: as steering error grows, modulate posterior lag mildly and
asymmetrically by the observed anterior velocity half-cycle. Algebraically the
modulation adds target-signed curvature only while the anterior joint is
moving, vanishes at stroke reversal, and never creates the static equilibrium
that stopped the parent redirect. A smooth error gate leaves the evidenced
far-field carrier unchanged and does not depend on distance, time, or a route.

The next rollout should preserve the coherent far-field wake, begin producing
additional target-normal impulse as lateral slip makes the steering request
large, and bend the wake axis toward the target before the high pass. Falsify
the mechanism if it changes broad travel, drives destructive tail limits,
settles into coasting, fails to improve on `2.999L`, or repeats the upper exit
without a meaningfully different corrective arc.

An algebraic replay on one sampled recorded trajectory (not a new CFD result)
keeps the effective lag within `0.506--1.094`; on those fixed states, the
fraction of raw posterior requests above `1800 deg/T^2` is `47.2%` versus
`51.1%` for the unmodulated expression, rather than increasing. A synthetic
left/right reflection check gives exactly negated joint accelerations. These
checks establish boundedness and symmetry only; the later CFD evaluation must
decide whether the phase modulation changes the trajectory usefully.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and asymmetric flapping for turning
source_mechanism: measured direction error changes the relative phase or strength of the two beat half-cycles while retaining the propulsive rhythm
transferable_invariant: when static curvature cannot redirect an already moving swimmer, apply bounded target-signed steering through observed beat phase without extinguishing the traveling carrier
nontransferable_details: published gains, dimensional frequencies, robot-specific duty ratios, species kinematics, exact vortex phases, clock phase, and task-specific routes
policy_translation: compute full-quadrant error from normalized `target_body_L`, combine it with bounded body-frame slip, and use anterior joint velocity phase to modulate posterior lag continuously around its demonstrated nominal value
falsification: reject if far-field propulsion changes, tail-limit occupancy worsens materially, phase modulation produces coasting or wake collapse, or the closest approach and upper-exit topology do not improve
