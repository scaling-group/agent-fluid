# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization in still water (`U_infinity=[0,0,0]`), no cylinders, and a
  moving window. Every sample captures, so the useful failure comparison is
  mechanistic rather than a termination-class failure.
- The two exact v12 samples capture at `18.0125T`, score `-0.064599`, and mean
  distance `1.950823L`. In both visual rows the fish is self-propelled: the
  top-down row shows a coherent alternating reverse-street-like wake growing
  behind the translating body, and the oblique Lambda2 row shows an organized
  three-dimensional traveling wake rather than passive advection or a
  prewarmed structure. The body turns toward the target without wake collapse,
  but the route bends more widely near capture.
- The v11 comparator has the same coherent two-view wake and captures slightly
  earlier at `17.8695T`, but its score and mean distance are worse
  (`-0.072146`, `1.958037L`). Inherited measured diagnostics place its
  path/cross-track at `13.0071L/0.6102L` with near/final course alignment
  `0.787/-0.003`; v12's local tracking-work direction guard improves early and
  integrated closure but widens path/cross-track to `13.2330L/0.7417L` and
  delays capture. Thus the deficit is not propulsion onset or turn polarity;
  it is the route coupling introduced when posterior reserve-work direction is
  tested against a phase reference containing mean steering curvature.
- The sampled v15 distance-conditioned terminal partition is exactly
  episode-equivalent to v12: trajectory, force history, score, and arrival all
  match. This falsifies terminal distance alone as an effective scheduling
  signal for the extra posterior work; the reserve is evidently inactive or
  immaterial where that partition changes. The inherited unconditional
  zero-mean phase reference captures at `17.8585T` and repairs route width but
  regresses to score `-0.080637`, so full separation during deep carrier
  establishment also discards useful recovery work.

## Policy hypothesis

Keep the evaluated v12 carrier, odd mean-curvature steering, closure-qualified
posterior reserve, half-cycle steering, and direction-selective rate governor.
Change only the phase reference used by the one-sided reserve-work guard. Use
the already normalized anterior phase-plane carrier-energy gate to include the
mean steering offset fully at the deepest deficit and remove it continuously
as carrier energy recovers. The actual posterior target remains the combined
mean-curvature plus lagged-wave target, so this is an allocation change rather
than a new route command or scalar gain tune.

Expected result: retain v12's first-`3T` and mean-distance benefit while moving
arrival, path/cross-track, and terminal alignment toward the zero-mean result.
The mechanism is falsified if it loses capture, gives back the early or mean
distance gain, fails to narrow the route, raises the actuator/load class, or
degrades either coherent wake view. Exact reproduction of v12 would show that
the energy-conditioned phase partition also lacks effective authority.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and low-dimensional robotic-fish CPG control
source_mechanism: preserve a direction-bearing traveling bend with posterior lag/emphasis while treating steering offset and propulsive phase allocation as distinct bounded feedback roles
transferable_invariant: posterior motion should reinforce the traveling wave, and any phase/allocation modulation should be driven by observed oscillator state and target-relative feedback rather than a clock or prescribed vortex phase
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: compute normalized anterior carrier energy from joint angle and rate; use its smooth deficit gate to mix the bounded mean tail tangent into the posterior reserve-work phase reference, while leaving the normalized body-frame target steering and two-joint wave target unchanged
falsification: reject if capture, early or integrated closure, route width, terminal alignment, actuator/load class, or either top-down/oblique wake view worsens; treat exact v12 behavior as evidence that the translated allocation has no authority
