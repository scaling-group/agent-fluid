# Turn-priority posterior allocation candidate notes

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and finite dynamics. Every
  sample nevertheless terminates at the upper virtual boundary
  (`center_y` approximately `15.200L`), so capture and a better termination
  class remain unproven.
- Both visual rows establish self-propulsion. The top-down sheets grow an
  alternating red/blue wake from quiescent water, while the oblique sheets show
  coherent three-dimensional caudal structures rather than passive advection.
  The three half-cycle, phase-authority, and relative-crossflow variants curl
  sharply upward and exit by `8.800--10.411T`, reaching only
  `11.448L`, `11.778L`, and `10.883L` minimum distance. These results reject
  another phase gate or instantaneous crossflow residual as the next change.
- The assigned course-error parent is the only sampled semantic improvement.
  It preserves the alternating wake, moves `(-9.183,+1.201)L`, reduces minimum
  distance to `6.218L` at `16.225T`, and delays exit to `16.879T`; the next-best
  sample reaches only `10.883L`. The inherited hypothesis that body-frame
  inertial course exposes harmful lateral momentum earlier than bearing alone
  therefore survives this rollout.
- The parent's remaining failure is not weak drive. From about `9T` onward its
  target-versus-course error is strongly negative, yet positive body-frame
  lateral velocity persists during most of that high-error interval and the
  fish continues toward the upper boundary. The posterior acceleration is
  clamped in `60.8%` of samples, versus `49.9%` for the unchanged anterior
  carrier, even though posterior joint angle itself never reaches its hard
  limit. Thus adding an unallocated mean tangent to the full posterior wave
  leaves the corrective request competing with a saturated carrier.

## Policy hypothesis

Preserve the parent's evidenced body-frame bearing-versus-course signal and
the complete anterior state-feedback oscillator. Replace posterior summation
followed by whole-target clipping with one continuous turn-priority allocator.
The bounded course request sets posterior mean curvature first; the remaining
joint-angle envelope symmetrically bounds the lagged propulsive wave around
that mean. As course error grows, authority shifts smoothly from cruise wave
to redirecting curvature; as alignment returns, the full posterior traveling
wave is restored without a clock, stage variable, or route.

This is intended to retain the parent's long leftward trajectory while making
its already-correct negative request effective before the upper exit. The
downstream rollout should beat `6.218L`, survive beyond `16.879T`, or improve
the termination class while retaining a coherent 3D wake and reducing
posterior acceleration-limit residence. Reject the mechanism if posterior
wave relief collapses thrust, creates a large opposite-side overshoot, repeats
the upper exit without improved distance/survival, or trades acceleration
clipping for persistent joint-angle or joint-rate limiting. The candidate has
no same-worker CFD result.

bookshelf_consulted: true
source_domain: biological C-start or burst redirection and sensor-modulated robotic-fish mean-curvature control
source_mechanism: observed-error-gated reallocation from a cruise tail beat to bounded redirecting curvature
transferable_invariant: large target-course mismatch should temporarily prioritize a bounded body turn, then continuously restore the propulsive rhythm as the measured course aligns
nontransferable_details: species-specific C-start shapes, published gains and duty ratios, clocked phase, dimensional speeds, exact vortex phases, and task-specific routes
policy_translation: map normalized body-frame bearing minus body-velocity course to bounded posterior mean curvature, then place the state-derived lagged wave symmetrically inside the joint-angle authority remaining around that mean
falsification: reject if the alternating wake or leftward progress collapses, minimum distance does not beat `6.218L`, upper-boundary survival does not exceed `16.879T`, or posterior limiting is not reduced without new angle/rate saturation
