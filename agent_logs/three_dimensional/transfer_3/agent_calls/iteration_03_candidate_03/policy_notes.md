# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- All four sampled rollouts report direct uniform still-water initialization,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion is
  self-propelled. The combined top-down rows show organized alternating wakes,
  and the oblique rows show coherent three-dimensional Lambda2 structures, so
  none of the useful motion or failures is attributable to imposed advection.
- The assigned parent's damped terminal curvature reallocation is now evaluated
  as `solver_a1253ad45bc8`. It preserves the inherited coherent approach,
  captures at `25.2615T`, and has the best sampled score (`-0.53065`) and mean
  distance (`2.4318L`). Inside `4L`, command-cap incidence falls from
  `26.32%/17.32%` for the prefilled near-miss `solver_cc8652ccb895` to
  `0.195%/0%`; neither joint dwells near the `45 deg` stop, and maximum
  force/yaw-moment coefficient magnitudes fall from about `0.252/0.119` to
  `0.0159/0.00834`. From roughly `2.7L` inward its joint rates settle near zero
  around a shared mean bend while inertial closure continues into capture.
- This outcome supports actuator reallocation, not merely extra curvature or
  lower effort. `solver_638c08139575` shrinks carrier amplitude and boosts the
  same curvature under terminal miss risk, but still misses at `1.1076L`,
  reaches terminal force/moment magnitudes of about `0.269/0.128`, and exits
  the virtual boundary. `solver_e7a7bd0d3fe2` uses closing-gated cadence relief
  and joint damping; it eventually captures, but only at `51.6450T` after the
  top-down and oblique paths show a large loop. The successful distinction is
  damped tracking of a two-joint curvature equilibrium in place of the
  oscillatory carrier, with a small carrier floor.
- The winning rollout remains steadily closing until capture, so it does not
  evaluate recovery if terminal reallocation is entered but the range begins
  increasing. The inherited closing-gated approach-hold capture shows that
  measured range trend can continuously release a terminal intervention. A
  recession-release branch can therefore improve recovery semantics without
  replacing target geometry at release or low speed, which prior inherited
  logs show is unsafe.

## Policy hypothesis

Start from the evaluated `solver_a1253ad45bc8` policy, including its exact
far-field geometry redirect and its distance-and-angle-gated terminal
carrier-to-curvature reallocation. Add one smooth closure-support factor to the
terminal blend: positive normalized closing speed leaves the validated damped
mean-curvature hold active, while loss of closure continuously restores the
posterior-lag state-feedback carrier. This is an escape path for a stale
terminal bend, not a velocity-course steering command; target-relative body
geometry still owns the turn sign and curvature equilibrium.

Expected evidence is the same compact self-propelled approach and capture as
`solver_a1253ad45bc8`, with negligible change while closure is strong. If a
perturbation or coupled response reverses closure, the carrier should recover
without a long low-drive orbit. Reject the addition if it delays or loses the
`0.75L` capture, reintroduces inside-`4L` command or angle saturation, raises
terminal loads materially, or produces a receding loop despite releasing the
hold.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish gait modulation and biological burst-redirect turning
source_mechanism: target-conditioned actuator reallocation into bounded mean curvature with sensor-conditioned release back to rhythmic propulsion
transferable_invariant: when propulsion and steering share limited joints, temporarily replace the gait with a damped curvature equilibrium during a closing terminal redirect, but restore the propulsive rhythm when the observed response stops closing range
nontransferable_details: published gains, dimensional cadence, species-specific C-start shapes, full-body waveforms, exact vortex phases, and prescribed target routes
policy_translation: existing normalized distance and body-frame target angles set the two-joint terminal curvature blend; a bounded factor from normalized closing speed can only release that blend and cannot choose the steering sign
falsification: reject if the established fast capture changes adversely, terminal saturation or loads return, or loss of closure still leaves the swimmer in a low-drive receding loop

## Non-CFD implementation audit

The candidate differs from the evaluated fast-capture policy only by the
closure-support factor and its declared parameter. Reconstructing the episode's
eight-sample range window from the completed trace gives closing speeds from
`0.384` to `0.685 L/T` for every one of the `1026` samples inside `4L`, all
above the `0.16 L/T` full-support threshold. The added factor is therefore
exactly one on every recorded state where terminal reallocation can activate,
so replayed commands along that trajectory are unchanged; it becomes exactly
zero at nonpositive closure and releases smoothly in between. This is a
contract/activation audit, not new coupled-CFD evidence.
