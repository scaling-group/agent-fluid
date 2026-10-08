# Evidence-selected phase-resolved collision-course candidate

## Visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen rollout contract: direct
  uniform still water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the
  L64 inertial moving window. Three v40 predicted-miss-corridor samples are
  byte-identical and capture at `24.662014T`, minimum/final distance
  `0.748606L`, scored mean distance `2.348173L`, and score `-0.448570730`.
  The distinct v41 phase-selective sample captures at `24.640015T`,
  `0.748356L`, `2.347937L`, and `-0.448328283`.
- Both rows of the combined v40 and v41 sheets were inspected from release
  through capture. Their top-down rows begin wake-free, then show
  self-propelled diagonal progress, a coherent alternating mid-plane vortex
  street, and the same compact transverse hook into the target. Their oblique
  rows show compact three-dimensional Lambda2 structures around and behind the
  swimmer through the redirect, with no out-of-plane escape or wake breakup.
  The sheets are visibly almost indistinguishable, so v41 is a local allocation
  improvement rather than a new wake or trajectory class.
- The v41 edit allocates the existing collision-course residual only on the
  observed lagged tail-wave half-cycle aligned with the signed turn request.
  Relative to v40 it advances capture by `0.021999T`, lowers scored mean
  distance by `0.000236L`, improves score by `0.00024245`, and improves final
  constant-velocity projected miss from `0.637713L` to `0.631929L`. Peak
  absolute planar force/yaw-moment coefficients remain in the same low class
  (`0.02303/0.03170/0.01560` versus `0.02292/0.03176/0.01569`), sampled raw
  acceleration exposure remains about `73.6%`, and exact-rate occupancy does
  not materially improve. Thus the result supports phase-resolved steering
  allocation, not a saturation or load-reduction claim.
- No termination failure is present in the current sampled keyframes. The
  informative negative boundary comes from inherited audited evidence only:
  synthesized posterior reference-velocity feedforward changed the far route
  by `8T`, missed at `0.993183L`, and exited left at `37.1470T` and `6.9973L`
  despite a coherent wake and lower rate-limit occupancy. The current visual
  comparison therefore treats replicated v40 as the mechanism-level negative:
  magnitude-corridor release alone produced no semantic change across three
  completed local iterations.

## Policy hypothesis

Use the completed v41 controller as this workspace's exactly one candidate.
Preserve the v40 anterior state-feedback oscillator, lagged posterior traveling
wave, far route, course-preview interception, predicted-miss corridor,
steering-priority envelope, posterior braking reserve, and coast guard. Keep
the terminal collision-course residual separate from route-scale mean
curvature and admit it only through an observed-joint phase gate formed from
the lagged tail-wave side and signed body-frame course request. This transfers
half-cycle turning as one compact actuator mechanism; it does not alter any
scalar gait gain or add a clock, stored phase, world direction, target identity,
or memorized route.

Expected post-exit evidence is deterministic reproduction of the sampled v41
capture near `24.640T`, the established coherent three-dimensional route, zero
posterior hard-stop occupancy, and the inherited low-load class. Falsify the
candidate if capture or its small arrival/distance advantage fails to
replicate, the far route changes, the wake loses coherence, posterior hard-stop
contact returns, or command, rate, force, or moment behavior leaves the v40
class. Because the nominal gain is small and nonsemantic, reflected or
perturbed evaluation must reject the mechanism if phase selection suppresses
needed steering or merely adds within-beat noise. The new CFD result occurs
only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: asymmetric fish turning and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: bounded half-cycle asymmetry steers by allocating correction within a stable anterior-to-posterior traveling bend rather than replacing the rhythm with static curvature
transferable_invariant: preserve the anterior phase anchor and posterior lag, infer phase from observed joint state, and spend a bounded target-derived steering residual only on the half-cycle aligned with the requested turn
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: select the evaluated v41 mechanism that removes the terminal course residual from mean-curvature drive and applies it through a mirror-equivariant gate made from normalized body-frame course prediction and the observed lagged tail-wave side
falsification: reject if capture, far-route noninterference, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if reflected or perturbed evidence shows that phase selection suppresses necessary steering
