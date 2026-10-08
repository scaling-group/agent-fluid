# Terminal course-stabilization candidate

## Visual and quantitative diagnosis before the policy edit

- All sampled and inherited evaluations used direct uniform still water with
  `U_infinity=(0,0,0)`, no prewarm snapshot, and no cylinders. Every current
  sample captured, so the weaker inherited mechanisms are informative control
  failures rather than semantic domain-exit failures.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the strongest posterior-priority controller, the sampled line-of-sight
  controller, and the assigned parent's rate-headroom allocation failure. The
  posterior-priority top-down row shows self-propelled motion along a much
  faster closing curve with a coherent alternating wake through capture; its
  oblique row retains compact three-dimensional posterior structures. The
  allocation failure also retains both wake signatures, so its regression is
  a route/actuation result rather than wake collapse, passive advection,
  collision, or numerical instability.
- The posterior-priority phase-plane envelope is the decisive sampled
  improvement. Relative to the signed-curvature rate governor, it advances
  capture from `23.3640T` to `17.8585T`, lowers mean score-distance from
  `2.409486L` to `1.980025L`, shortens center path from `13.3177L` to
  `12.8148L`, and improves score from `-0.51274776` to `-0.09355786`. It does
  so with a higher mean speed (`0.7178U` versus `0.5701U`) while retaining the
  coherent posterior wake. The cost is higher RMS yaw (`2.0285` versus
  `1.5537 rad/T`), RMS force coefficient (`0.01557` versus `0.01234`), RMS
  moment (`0.00807` versus `0.00643`), and tail acceleration-ceiling residence
  (`65.17%` versus `50.68%`). Those loads remain finite and the rollout is
  stable, so this evidence supports preserving the carrier rather than
  attenuating it.
- The assigned parent's rate-headroom steering allocator is a concrete
  negative result. It reduced tail residence above `96%` joint rate from
  `3.58%` to `2.88%` and slightly reduced path and RMS yaw, but delayed capture
  to `23.5180T`, worsened mean score-distance to `2.414585L`, and scored
  `-0.51701546` versus its `-0.51274776` parent. Redistributing a fixed common
  steering residual from instantaneous signed-rate headroom therefore did not
  turn complementary kinematic headroom into useful target authority.
- The sampled line-of-sight residual is a small positive result on the slower
  carrier (`23.1715T`, `2.390366L` mean score-distance, score `-0.49332402`),
  but it is not the missing mechanism on the faster rollout: outside `2.1L`,
  the latter's reconstructed co-windowed line-of-sight drift has only
  `0.0005 rad/T` mean and `0.0332 rad/T` RMS. Applying another far-route
  residual would not be evidence-led.
- The faster rollout instead exposes a terminal course defect. Inside `2.1L`,
  mean target-course alignment is `0.8703`, and by capture it falls to
  `0.3742`: radial closing speed is only `0.3366U` while target-relative
  lateral speed is `0.8343U`, total speed is `0.8997U`, and yaw rate is
  `-3.0781 rad/T`. The slower rate-governed parent crosses at `0.8260`
  alignment with `0.3842U` lateral speed. Thus the fast policy earns capture
  through a shallow, high-slip crossing after its distance-only approach law
  has already weakened steering.

## One candidate mechanism

Preserve the demonstrated posterior-priority phase-plane envelope, posterior
lag and emphasis, cadence, odd body-frame curvature map, half-cycle steering,
and direction-selective rate governor. Add one bounded terminal course
residual: form the signed sine of the angle from the body-frame target vector
to body-frame velocity, suppress it at low speed, and apply its opposite sign
only as the fish enters the existing `2.1L` approach corridor. Add the residual
after the distance-only steering attenuation so that approach scheduling does
not withdraw the correction precisely when measured course misalignment is
large. The carrier, cadence, and far-route feedback remain unchanged.

Expected result: retain the fast coherent wake and capture while converting
some late lateral velocity into radial closure, producing a deeper crossing
with better terminal alignment and no material arrival or distance-integral
loss. Reject the mechanism if capture or reflected polarity is lost; if
arrival, mean distance, path, loads, actuator-limit residence, or steering
switching worsens materially; or if either visual row loses its coordinated
posterior traveling-wake topology.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal target approach
source_mechanism: retain a coordinated rhythmic carrier while adding a bounded sensor-driven course residual near capture
transferable_invariant: correct signed target-relative lateral course error continuously without weakening the propulsive traveling wave
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, prescribed phases, exact vortex timing, and task-specific routes
policy_translation: compute a reflection-odd normalized cross product of body-frame target and velocity, gate it by observed speed and normalized target distance, and feed the bounded opposite-sign residual through the existing two-joint steering path after distance-only attenuation
falsification: reject if capture, reflected steering polarity, terminal alignment, radial closure, distance integral, arrival, path, loads, limits, switching, or top-down and oblique wake coherence worsen materially
