# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm, no cylinders), so the visible motion and
  wakes are self-generated. Every rollout exits through the upper virtual
  boundary near `y=15.20L`; none establishes target-directed travel.
- In both the top-down vorticity and oblique Lambda2 rows, the assigned parent
  `solver_77089a0404da` retains a coherent alternating posterior wake and has
  the strongest useful translation. It moves the center `2.041L` left and
  improves closest distance to `11.347L`, compared with only `1.056L` and
  `12.056L` for the posterior mean-curvature sample. Its smooth limiter also
  bounds logged accelerations near `30 rad/T^2` rather than the posterior
  sample's `112 rad/T^2` peak. These are positive propulsion and actuation
  results worth preserving.
- The parent nevertheless drifts `1.202L` upward, finishes with target bearing
  `1.467 rad`, and exits at `9.251T`; its closest approach occurs only shortly
  before exit. The long curved wake is therefore productive propulsion on the
  wrong trajectory, not passive advection or a weak-wake failure.
- The cross-candidate early response separates actuator distribution from
  scalar authority. At about `3T`, all three posterior-only steering samples
  retain headings of `0.523--0.546 rad`, slightly targetward from the initial
  `0.506 rad`, whereas the parent has already fallen to `0.432 rad`. By `6T`
  the parent is at `-0.177 rad` and eventually reaches `-0.956 rad`, with a
  larger final bearing than the posterior-only samples (`1.29--1.49 rad`).
  Thus adding the same signed acceleration asymmetry to the anterior joint
  bought surge but reversed the useful initial yaw response; another increase
  of common asymmetry would repeat the upper-exit topology.
- The inherited logs already falsify static shared curvature, common
  acceleration offsets, and a slower mean-curvature carrier. The newest CFD
  evidence additionally falsifies interpreting a positive joint-only mean
  curvature as a carrier-independent yaw sign. The next test should change
  wave shape across the two joints rather than tune carrier frequency,
  amplitude, or a common steering gain.

## Single candidate hypothesis

Preserve the parent's joint-state oscillator, posterior lag, bounded
bearing/slip response, and smooth acceleration envelope. Change only the
half-cycle actuator basis: the target-selected posterior half-cycle keeps its
existing sign and full authority, while the anterior half-cycle receives the
opposite signed, smaller command. This differential wave-shape steering should
retain posterior thrust while countering the parent's wrong-sign body yaw,
without imposing a static equilibrium or copying a world-frame route. It is
falsified if the early heading does not remain above the parent's `0.432 rad`
at `3T`, closest distance does not beat `11.347L`, the same upper-boundary exit
persists without a materially different useful trajectory, coherent wake or
leftward translation collapses, or joint-limit occupancy grows.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and phase-lag or wave-shape modulation
source_mechanism: redistribute target-selected beat authority across linked joints so the posterior segment preserves thrust while the anterior segment redirects the body wave
transferable_invariant: a bounded body-frame turn request can change inter-joint wave shape with posterior emphasis instead of applying the same signed mean shift to every joint
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species-specific envelopes, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: retain the normalized bearing-minus-lateral-slip request and joint-state phase; apply its half-cycle acceleration bias with opposite anterior and posterior signs and smaller anterior magnitude
falsification: reject if early yaw sign, closest approach, and exit topology do not improve together, or if posterior wake coherence, targetward surge, or bounded actuation deteriorates

## Dry validation (not rollout evidence)

The candidate passes the required parameter-schema and finite-output contract
and is reflection equivariant under simultaneous sign reversal of joint state,
bearing, and body-frame lateral velocity. A joint-only `50T` integration with
the physical angle/rate envelope preserves approximately `1.02/1.05 rad`
anterior/posterior peak-to-peak motion. Its rate-limit contact fraction remains
near `6.9%` for bearings `-0.155`, `0`, and `+0.155`, while the late joint means
reverse as intended: approximately `(0.016,-0.042)`, `(0,0)`, and
`(-0.016,0.043) rad`. This probe establishes only bounded differential wave
shape; post-worker CFD must decide the trajectory, wake, and yaw falsifiers.
