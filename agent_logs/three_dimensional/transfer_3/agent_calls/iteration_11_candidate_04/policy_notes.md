# Closure-supported carrier-energy recovery candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, active moving-window transport, finite dynamics, and
  capture. Their trajectories are byte-identical and all score
  `-0.5283387731`, capture at `25.1185226 T`, and finish at
  `0.746410191 L`; three policy files are byte-identical and the fourth changes
  only version text and comments.
- I inspected the combined keyframe sheets from release through capture for
  the repeated best baseline (`solver_b79884a946b7`) and the distinct weaker
  body-alignment-release result (`solver_3048facdc958`), including both the
  top-down mid-plane vorticity row and oblique body/Lambda2 row. Both are
  self-propelled along the same compact, target-directed arc. A coherent
  alternating posterior wake and finite three-dimensional structures develop
  through the outer approach, followed by a smooth held bend into capture;
  neither sheet shows passive advection, collision, a boundary-exit precursor,
  wasteful terminal flailing, or instability. Their visible similarity agrees
  with equal capture time and moving-window shift count, while the weaker
  result's shallower crossing and worse distance integral remain numeric—not
  visible—differences.
- The inherited terminal experiments now span extra shared yaw-response
  curvature (`-0.5287819`), direction-aware release (`-0.5292957`),
  body-alignment release (`-0.5303978`), productive-crossflow curvature relief
  (`-0.5285807`), and zero-sum anterior curvature redistribution
  (`-0.5288434`). All retain capture but regress from the repeated baseline.
  Together with earlier phase-selective, posterior-only, and stacked-release
  negatives, this rules out another terminal gain, phase split, joint-role
  change, total-bend residual, or carrier-release condition for this candidate.
- The baseline instead exposes a pre-wake startup deficit. From release to
  `2 T`, range changes only from `12.3277 L` to `12.284 L`, mean closure is
  about `0.022 L/T`, and roughly `26%` of short-window samples have negative
  closure. The normalized anterior oscillator radius
  `hypot(q1/A, q1_dot/(A*omega))` grows only from about `0.29` to `0.64`; after
  it reaches roughly `0.8`, closure becomes sustained and averages
  `0.50--0.54 L/T` through most of the outer route. Target bearing remains
  only about `0.04 rad` near `2 T`, so the low closure is not a demonstrated
  steering or terminal-allocation failure.
- The change is therefore bounded away from the proven terminal topology. It
  must vanish once carrier state is established, whenever target geometry
  requests a large redirect, and while measured closure is already healthy.
  The evaluated terminal equilibrium, closure preview, paired response release,
  redirect sign, posterior lag, hard limits, and observation-unit adapter stay
  unchanged.

## Policy hypothesis

Add one state-feedback carrier-energy recovery mechanism to the anterior
oscillator. Measure its normalized phase-space radius from current joint angle
and velocity. Only when this carrier radius is below a declared support level,
target-relative redirect is small, and short-window range closure is deficient,
apply bounded negative damping along the current anterior joint velocity. This
injects energy without prescribing a phase, clock, route, world direction, or
new mean curvature; it fades continuously as any of the three observed support
conditions disappears. The posterior joint continues to follow the existing
lagged anterior state, so the edit builds the same traveling-bend architecture
rather than adding a standing or symmetric wiggle.

Expected evidence is earlier formation of the existing coherent wake and
earlier sustained target closure, followed by recovery to the inherited outer
carrier and exact preservation of the terminal allocator. Reject the mechanism
if the energy gate remains active after the established outer gait, if bearing
or redirect error grows during startup, if the later wake/path changes into an
exit or loop, if capture is delayed/lost, or if acceleration clipping,
joint-stop dwell, force, or moment excursions increase materially. The new CFD
evaluation occurs after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG locomotion and biological burst-to-cruise transitions
source_mechanism: use observed locomotor state and task response to build a rhythmic traveling wave, then release the extra excitation once the carrier supports useful swimming
transferable_invariant: a rhythmic carrier can receive bounded state-dependent energy only while its normalized joint-state orbit is underdeveloped and target progress supports propulsion rather than redirection
nontransferable_details: published oscillator gains, dimensional cadence, robot or species amplitude envelopes, prescribed burst duration, exact vortex phase, full-body waveform, and task-specific route
policy_translation: multiply an anterior phase-space energy-deficit term by normalized low-closure and small body-frame redirect supports, and apply it as bounded velocity-aligned negative damping while retaining the existing posterior-lag follower
falsification: reject if startup closure does not improve, the support persists into the established gait, target alignment or coherent wake topology degrades, capture regresses, or saturation, joint-stop dwell, and load peaks grow

## Non-CFD implementation audit

- The deterministic schema scan resolves all 74 direct `params.FIELD`
  references in the returned 75-field parameter object. The configured
  lightweight Julia contract returns two finite bounded commands, and the
  solver boundary check permits only the candidate policy edit.
- Against an otherwise identical parameter object with the new recovery gain
  disabled, a recorded-like low-energy/low-closure state has normalized carrier
  radius `0.2995`, gate `1.0`, and exactly the declared `-pi rad/T^2` maximum
  velocity-aligned increment. The same joint state is command-exact when either
  redirect is fully active or closure is healthy, and an established-carrier
  state at radius `0.9182` is also command-exact. Approximate gate reconstruction
  on the parent trace confines nonzero support to the initial `0--3.40 T`; the
  coupled rollout must determine whether the added energy makes it release
  earlier. These checks establish bounded activation and structural
  noninterference only, not hydrodynamic improvement.
