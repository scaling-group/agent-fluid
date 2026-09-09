# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled episodes satisfy the experiment contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Their motion and wakes therefore diagnose self-propulsion and
  target steering rather than ambient advection.
- The strongest finite rollout (`solver_b6bb94d9cdaf`) is the compact
  bearing/curvature controller. Its top-down row shows a coherent alternating
  wake and sustained leftward self-propulsion; the oblique Lambda2 row confirms
  organized three-dimensional structures rather than numerical breakup. It
  reduces distance from `12.3277L` to `5.3570L` and has the best sampled score
  (`-7.6367`), but repeatedly reverses yaw, rises after roughly `10T`, and
  exits the upper boundary at center `(8.6493,15.2024)L`, final distance
  `5.8935L`. Its controller-owned acceleration bound works, but joint speed
  still resides near the `260 deg/T` limit on about `10.3%/16.4%` of rows.
- The inherited parent's signed-curvature flip (`solver_e450df1efa49`) is a
  useful negative result, not confirmation of its sign hypothesis. Both visual
  rows retain the coherent propulsive wake, and the almost-flat leftward route
  reaches the best sampled closest distance (`4.1281L`), but it never turns
  enough toward target `y=9.5L`; it passes above the target and exits the left
  boundary at center `y=12.4806L`, final distance `9.1538L`. Raw acceleration
  exceeds the physical limit on about `71.3%/68.4%` of joint rows.
- The prefill (`solver_e699ec5c28f1`) supplies the opposite bracket: its
  branch-heavy positive-tail-tangent response descends too aggressively,
  reaches only `6.1797L`, reverses progress, and exits the lower boundary at
  center `y=0.7976L`. The response-gated distributed-curvature failure
  (`solver_9d409fc369f7`) nearly stalls, reaches only `12.3038L`, then curls
  upward and exits at `9.8725T`; shifting the oscillator equilibrium is not a
  safe way to add steering in this lineage.
- Taken together, the samples bracket the needed route between a lower-boundary
  overturn and two above-target passes. The best compact controller already
  has the right propulsion scaffold, but its short-window yaw-rate term can
  reverse curvature on beat-scale rate excursions even while bearing retains
  one sign. The trajectory's repeated heading-rate sign changes and broad
  centerline crossings make that reversal semantics the next mechanism to
  isolate; adding approach scheduling or wake rejection is unsupported because
  no sample reached the `0.75L` capture neighborhood or encountered a wake.

## Policy hypothesis

Preserve the strongest sample's joint-state oscillator, posterior lag, bounded
tail-curvature scale, small anterior steering share, and smooth acceleration
limit. Replace its additive yaw-rate brake with a response-release gate:
body-frame bearing alone fixes the requested curvature sign, while the signed
windowed bearing rate can attenuate that request when the line of sight is
already moving toward the body centerline. The gate cannot reverse curvature;
the command reverses only after bearing crosses zero. This translates a
target-conditioned asymmetric beat without moving the oscillator equilibrium
or introducing a clock, route, or world-frame direction.

Expected result: retain the coherent propulsive wake and leftward progress,
remove beat-scale curvature reversals while bearing is persistent, and hold a
middle trajectory between the sampled upper/left and lower exits. Falsify the
mechanism if it repeats the upper-boundary topology of the compact parent, does
not improve target alignment or closest distance relative to `5.3570L`, loses
the coherent traveling wake, or increases angle/speed-limit residence. A
better termination class or a materially more target-directed finite path is
useful evidence even without capture.

bookshelf_consulted: true
source_domain: classical fish turning and robotic-fish closed-loop CPG modulation
source_mechanism: target-conditioned mean-curvature bias whose authority releases after an observed turn response
transferable_invariant: persistent body-frame target error sets a bounded average bend while measured motion toward alignment reduces, but does not prematurely reverse, that bend and posterior lag continues to carry propulsion
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, full-body waveforms, exact vortex phases, and source-task routes
policy_translation: map normalized body-frame bearing to posterior mean curvature and use signed windowed bearing rate only as a bounded release gate; retain joint-state phase, posterior lag, and two controller-bounded accelerations
falsification: reject if the same upper exit or broad yaw reversals persist, closest approach and alignment do not improve, propulsion collapses, or actuator-limit residence worsens
