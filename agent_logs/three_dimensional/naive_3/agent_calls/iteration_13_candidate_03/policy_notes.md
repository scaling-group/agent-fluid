# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Their
  translation and wakes are self-propulsion rather than advection or inherited
  flow.
- I inspected every combined sheet from release to termination, including the
  top-down mid-plane vorticity and oblique body/Lambda2 rows. The `2.385L`
  response-selective brake, `2.494L` full-direction gate, `2.512L` posterior
  half-cycle counterbend, and `2.536L` response-released S-bend all retain a
  coherent alternating planar street and compact three-dimensional vortex
  chain. Each passes below the target, turns into a nearly vertical path, and
  remains powered into the lower virtual boundary near `31T`; none is advected,
  collides, loses wake coherence, or becomes unstable.
- The assigned parent's whole-wave brake is a small geometric improvement but
  not a semantic one. Relative to the inherited alignment-gated carrier, its
  minimum improves from `2.443L` to `2.385L`, while mean distance changes only
  from about `8.443L` to `8.436L` and the same `left_domain` topology remains.
  The other current allocation variants are worse at `2.494--2.536L` and also
  retain the powered lower exit. Thus another gate conjunction, persistent
  equilibrium redirect, or symmetric drive reduction is not supported.
- Reconstructed full body-frame target direction at the four minima remains
  `1.38--1.58 rad`, speed remains `0.65--0.71U`, and target-ray cross-track
  speed is `0.63--0.65U`. Inside `3L`, instantaneous heading rate is almost a
  gait-phase proxy: its correlation with anterior joint velocity is
  `-0.992-- -0.997`, and the sign that grows full target-direction error occurs
  on `48.5--52.7%` of samples. The parent's brake therefore selects essentially
  one beat half-cycle; it does not establish that raw yaw is a slow course
  response.

## Policy hypothesis

Start from the strongest sampled response-selective carrier and keep its
anterior oscillator, bounded target-curvature mean, alignment envelope,
approach/direction/response gate, posterior mean, and command reserve. Replace
whole-posterior-wave attenuation with one new actuator mechanism: on the
measured wrong-way half-cycle, continuously reduce only the joint-velocity
quadrature coefficient that creates posterior phase lag. Preserve the
position-dependent posterior bend and restore the original lag on corrective
response. This changes wave phase/shape rather than applying another scalar
carrier gain.

The expected result is the established cruise path and coherent wake, followed
by a less counterproductive terminal phase without removing the whole
posterior bend. Capture, a useful new termination class, or a minimum
materially below `2.385L` without worse mean distance supports the mechanism.
Reject it on changed cruise, a one-sided or collapsed wake, a tight curl,
greater actuator/load residence, or persistence of the same lower exit without
material distance improvement.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and phase-lag or wave-shape control
source_mechanism: preserve the rhythmic carrier while changing only the posterior quadrature lag during the response half-cycle that turns away from the target
transferable_invariant: separate propulsion and steering by retaining the position-dependent traveling bend while applying bounded state-selected phase modulation, then restore the nominal lag on corrective response
nontransferable_details: published gains, dimensional frequencies, robot duty ratios, species-specific envelopes, exact vortex phases, fixed burst durations, approach radii, and task-specific routes
policy_translation: normalized target_body_L and distance_L localize the response; bounded heading_rate and joint state select a reflection-equivariant effective tail_lag_gain between parameter-owned limits in the two-joint state-feedback carrier
falsification: reject on altered cruise, lost or strongly asymmetric wake coherence, a short-radius curl, increased command or load residence, no material improvement below 2.385L, or persistence of the powered lower exit
```

## Evaluation boundary

This candidate has no CFD result. Replay and contract probes can establish only
signal locality, symmetry, finite bounds, and implementation behavior; formal
hydrodynamic evaluation occurs after this worker exits.

## Implemented candidate and pre-CFD checks

The candidate returns to the assigned parent's `2.385L` carrier and preserves
its full state gate. The only actuator change is to replace multiplication of
the whole posterior wave by a brake scale with a bounded effective
`tail_lag_gain`: the nominal `0.8` quadrature coefficient can relax toward a
parameter-owned `0.2` floor, while the position-dependent posterior bend and
posterior mean remain present.

Replay of completed traces through this state gate is a signal diagnostic, not
a coupled hydrodynamic prediction. Mean phase-relief weight is
`0.0030--0.0032` beyond `4L`, `0.090--0.120` between `3--4L`, and
`0.254--0.302` inside `3L`; corresponding mean effective lag is
`0.798`, `0.728--0.746`, and `0.619--0.648`. At the assigned parent's recorded
minimum the relief weight is `0.913` and effective lag is `0.252`; on the
sample whose minimum occurs during the complementary half-cycle, relief is
only `0.0065` and nominal lag is restored to `0.796`. Thus the new mechanism is
far-field local and phase-selective on the inherited state histories.

Direct Julia probes pass global reflection equivariance, far-field locality,
corrective-response release, finite hard-envelope inputs, and configured
command bounds. Relative to a nominal-lag control probe, posterior acceleration
changes by about `-14.51 rad/T^2` for the representative `2.4L` wrong-way
state, but only `-0.0105 rad/T^2` at `8L` and `-0.0359 rad/T^2` on corrective
response. The deterministic schema scan finds all `21` direct `params.FIELD`
references declared and no unused returned field. All `324` repository non-CFD
assertions pass, as do the lightweight policy contract, solver boundary, and
material-guidance checks. The duplicate assigned-parent marker in the rendered
workspace `README.md` was removed so the required guidance checker could
identify its baseline. Formal CFD was not run.
