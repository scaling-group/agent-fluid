# Candidate wake-policy notes

## Evidence diagnosis before the edit

- All four sampled evaluations use direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), have no cylinders or prewarm snapshot, remain
  numerically stable, and terminate by leaving the virtual domain rather than
  by capture.
- The combined top-down and oblique sheets for the assigned prefill
  (`solver_882a60521f5f`) show self-propulsion with a coherent alternating
  caudal wake, but the fish translates up and left and exits the upper boundary
  at `11.20T`. Its distance falls monotonically only to `10.062L`; the wake is
  useful, but the signed anterior rectifier does not establish route control.
- The strongest finite sample (`solver_f6a7d17d24de`) separates anterior mean
  curvature from a zero-mean posterior carrier. Its top-down sheet shows a
  long southwest trajectory rather than the common upper hook, while its
  oblique Lambda2 row retains discrete alternating three-dimensional wake
  structures through `28.59T`. This is a semantic improvement, not passive
  advection: center position changes from `(21.0,14.0)L` to `(8.883,0.800)L`,
  and minimum distance improves to `5.033L` at `17.56T`.
- That sample then misses below the target and regresses to `9.084L`. Recomputed
  from the logged body transform, bearing grows from `0.155 rad` initially to
  `0.738 rad` at `14T`, `1.455 rad` near `18T`, and remains near `1 rad` through
  exit. The slip-corrected route request therefore remains strongly positive;
  this is not a sign reversal or loss of target observability.
- Two-second windows from `14--20T` show anterior mean angle increasing to
  about `0.143--0.158 rad`, posterior mean remaining near zero, and mean
  heading staying near `0.76--0.79 rad`. Rate-cap occupancy has fallen from its
  early peak rather than becoming a numerical instability. The controller is
  applying its intended bounded anterior bend, but full posterior propulsion
  continues carrying the fish along the miss trajectory faster than that bend
  can redirect it.
- The other sampled large-error handoffs (`solver_7253ddb84c32` and
  `solver_7da8178f3332`) retain the upper-exit topology and reach only
  `9.955L` and `9.402L`. Together with inherited first-step failures, they
  argue against another shared or tail-biased curvature equilibrium. The
  narrow surviving base is the assigned parent's anterior-only center and
  zero-mean tail; the missing mechanism is a temporary reallocation of tail
  authority when geometric bearing becomes large.

## Policy hypothesis

Start from the `5.033L` anterior-only mean-curvature policy. Preserve its
period, amplitude, slip-aware body-frame route request, bounded anterior
oscillator center, and zero-mean lagged tail. Add one continuous large-bearing
gait transition: as absolute body-frame bearing grows, smoothly reduce the
amplitude of the posterior lagged carrier while leaving the anterior steering
center active. Restoring the full posterior carrier automatically as bearing
falls makes observed alignment, rather than elapsed time or a hidden stage,
release the redirect.

This translates the burst-redirect invariant without imposing a prescribed
C-start, a global route, or a published gain. The expectation is that the
policy retains the assigned parent's early coherent wake and approach, then
trades some tail thrust for yaw authority before the `5L` miss instead of
continuing to the lower boundary. Falsify it if the alternating wake collapses
before a turn develops, minimum distance loses the `5.033L` benchmark, bearing
does not decrease after the relief gate becomes active, saturation or loads
worsen materially, or the same lower-exit topology remains.

bookshelf_consulted: true
source_domain: biological C-start redirection and robotic-fish target-feedback modulation of an undulatory gait
source_mechanism: large observed heading error temporarily reallocates rhythmic tail authority from cruise propulsion toward a bounded redirect, then alignment releases the maneuver back into propulsion
transferable_invariant: target-relative steering must be allowed to dominate posterior thrust during a large bearing error, and the propulsive traveling wave should recover continuously as that observed error falls
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat frequencies, exact vortex phases, robot linkage geometry, and task-specific routes
policy_translation: absolute normalized body-frame bearing smoothly scales down only the zero-mean posterior lagged carrier while slip-corrected bearing keeps the bounded anterior curvature center active; falling bearing restores the tail carrier
falsification: reject if the 3D alternating wake disappears before redirection, closest approach exceeds 5.033L, large bearing persists through the gate, actuator or load histories worsen, or the fish repeats the lower-domain exit
