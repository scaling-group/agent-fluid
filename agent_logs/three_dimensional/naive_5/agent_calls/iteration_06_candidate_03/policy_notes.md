# Route-authority reallocation candidate

## Visual and quantitative diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm). Their motion is
  therefore self-propulsion, not imposed advection. The top-down rows show
  coherent alternating caudal vorticity, and the oblique rows independently
  show persistent three-dimensional Lambda2 structures behind the moving fish.
- The prefilled sign-corrected course policy is the strongest geometric near
  miss. It sustains the wake to `38.484T`, reaches `4.516L` near
  `(9.117,14.056)L`, and keeps `y=13.722--14.171L`; it then overshoots the
  target longitudinally and exits left at `9.695L`. The target remains about
  `4.5L` below the nearly horizontal wake at closest approach, so this is a
  failure of cross-track authority rather than propulsion or stability.
- The other response-gated long carriers sharpen the same conclusion. The
  bearing-only parent reaches `4.676L` near `y=14.226L`, while adding course
  error inside its yaw-residual loop reaches only `5.016L` near `y=14.540L`.
  The rate-closed positive-selector variant instead bends upward and exits at
  `(12.027,15.200)L` after `20.790T` with a `6.268L` minimum. These trajectories
  preserve the inherited steering-side calibration: negative anterior
  half-cycle allocation lowers the corridor, while positive allocation raises
  it, but none creates enough downward displacement to capture.
- The current policy already drives its reconstructed sign-correct route
  selector between roughly `-0.45` and `-0.97` through the useful `12--28T`
  interval. Increasing that scalar request is therefore uninformative. It also
  has at least one joint at the speed cap for about `56%` of samples and at an
  acceleration clamp for about `59%`; the three other samples have essentially
  the same limit residence. The additive half-cycle term is competing with an
  already clipped symmetric phase pump, so command magnitude is not equivalent
  to delivered slow steering authority.

## Policy hypothesis

Preserve the only evidenced long-range structure: the `0.90T/18 deg`
state-feedback carrier, lagged posterior follower, anterior soft-angle gate,
and the sign-corrected body-frame blend of bearing and velocity/target course
error. Replace the additive half-cycle acceleration with an energy-reallocating
duty-ratio mechanism: the target-selected half-cycle may retain the existing
symmetric pump magnitude while the opposite half-cycle is continuously
suppressed. Normalize the redistribution so it never makes the phase-pump term
larger than its existing magnitude. This converts a saturated additive request
into beat-level authority allocation without adding propulsion gain or a fixed
world-frame route.

The expected signature is the same coherent leftward wake with a materially
downward-curving centerline before the `x=9L` station, less or equal actuator
limit residence, and a closest approach below `4.516L`. Falsify the mechanism
if it returns to the early upper curl, loses the long propulsive trajectory,
stays in the `y≈14L` corridor, selects the wrong cross-track side, or increases
speed/acceleration clipping despite the normalized pump allocation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and asymmetric flapping
source_mechanism: route-error-driven half-cycle amplitude or duty-ratio allocation around a persistent propulsive rhythm
transferable_invariant: retain the evidenced traveling rhythm while persistent body-frame route error redistributes bounded effort toward the turn-useful half-cycle
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species kinematics, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: infer phase from normalized anterior joint velocity, keep the sampled sign-correct bearing/course selector, and normalize route-conditioned phase-pump allocation so the selected half-cycle never exceeds the existing pump magnitude
falsification: reject if cross-track progress does not beat the 4.516L near miss, the coherent long wake collapses, the correction side reverses, or actuator-limit residence increases
