# Saturation-aware anterior steering-spillover candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts report direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In every combined sheet,
  the top-down row shows body-led progress and a coherent alternating
  vorticity street, while the oblique row shows compact three-dimensional
  Lambda2 structures following the fish. The motion is self-propelled rather
  than imposed-flow advection or moving-window transport.
- All four policies capture. The explicit acceleration-feasible pair is the
  strongest finite evidence, scoring `-0.17657` and `-0.18218` with arrivals at
  `19.2335--19.2830T`; the otherwise equivalent unbounded-output pair scores
  `-0.20338-- -0.20397` and arrives at `19.5855--19.8880T`. Because the episode
  applies the same componentwise acceleration limit, this spread supports
  selecting the feasible representation but does not prove that its redundant
  clamp caused the route difference.
- The successful sheets preserve their alternating wakes through a direct
  right-side approach. Trace cross-checks give speed RMS near `0.68--0.70U`,
  local-flow RMS only `0.0180--0.0188U`, force RMS `0.0126--0.0138`, and moment
  RMS `0.0066--0.0072`; there is no visible wake collapse or external flow
  event to fix. The remaining opportunity is route-response efficiency within
  the actuator envelope.
- Replaying the sampled states through the selected controller exposes a
  structural allocation loss. Desired posterior steering acceleration has
  mean absolute magnitude `17.7--18.0 rad/T^2`, but after comparing the
  clamped carrier-plus-steering command with the clamped carrier alone, only
  `3.8--4.5 rad/T^2` remains as incremental posterior steering. The posterior
  total is same-sign saturated in roughly `65--69%` of rows. Thus the hard
  limit often masks a route correction; larger curvature or oscillator gains
  cannot recover that authority.
- Inherited negative evidence rules out weakening the posterior route loop:
  terminal yaw/curvature release missed by `1.712L`, and removing `75%` of
  posterior mean curvature during anterior recruitment missed by `3.191L`;
  both retained visible wakes but exited left. Any allocation change must keep
  posterior feedback closed and preserve the carrier.

## Policy hypothesis recorded before editing

Start from the sampled acceleration-feasible response-triggered distributed
C-bend. Split the posterior acceleration algebraically into its phase-lagged
carrier and yaw-residual steering terms. At the same physical output limit,
measure how much incremental steering survives saturation relative to the
carrier alone. If the rejected steering has the same sign as the current
bounded route request, translate only that residual into unused capacity of
the existing anterior oscillator-center redirect, capped at the already owned
`6 degree` anterior bound. Do not subtract posterior curvature, change the
carrier, enlarge either actuator limit, or release feedback near capture.

This introduces saturation-aware, phase-separated control allocation rather
than a scalar gain trial. Offline replay says the anterior addition is active
in about `47--49%` of sampled rows, averages `1.24--1.81 degrees`, is largest
outside `4L`, and never enlarges the existing `6 degree` center bound. Expect
the coherent wake and capture topology to survive while the route request is
less frequently hidden by posterior carrier saturation, reducing early
distance integral or arrival time. Falsify the mechanism if capture is lost,
the path repeats an upper/lower exit, the anterior joint approaches its
`45 degree` limit, the alternating wake weakens, or score/arrival fails to
improve beyond the sampled feasible pair's variability.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG steering and half-cycle asymmetry
source_mechanism: preserve a traveling propulsive rhythm while observed direction error modulates phase-separated steering authority
transferable_invariant: when a physical limit masks sensory steering during one carrier phase, route correction may spill to another bounded bending actuator only while its sign agrees with the observed closed-loop route demand
nontransferable_details: published gains, robot linkage geometry, species envelopes, dimensional frequencies, exact vortex phases, actuator leverage ratios, and task-specific routes
policy_translation: compare feasible posterior carrier-plus-steering and carrier-only accelerations, convert only their same-sign rejected difference into remaining capacity of the normalized body-frame anterior C-bend, and keep both original joint feedback paths active
falsification: reject if capture or wake coherence is lost, the route oversteers, anterior position saturation appears, or the sampled score and arrival band does not improve

## Validation status

- The required guidance semantic-change check and solver editable-boundary
  check pass. The rendered `README.md` contained the same assigned-parent
  marker twice; removing the duplicate allowed the semantic checker to compare
  against the intended parent.
- Every direct `params.FIELD` reference is owned by
  `target_policy_params()`. The candidate contains no clock, step counter,
  randomness, file I/O, obstacle coordinate, or memorized route.
- Offline evaluation on all `14,180` sampled states produced finite commands
  no larger than `1800 degree/T^2`; mirrored body-frame states produced exactly
  sign-reflected commands. This replay checks algebra, scale, and symmetry, not
  changed closed-loop hydrodynamics.
- The mandated check runner was invoked. Its guidance and boundary checks pass;
  the Julia contract probe cannot start because no `julia` executable is
  installed or on `PATH`. No CFD was run and no outcome for this candidate is
  claimed.
