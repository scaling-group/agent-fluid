# Terminal coherent-carrier damping candidate

## Visual diagnosis and completed evidence

- Every sampled and inherited rollout used direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Peak local flow is only about `0.03U` while the inherited course-feedback
  carrier reaches about `1.05U`, so its translation and wake are actively
  generated rather than supplied by ambient advection or window transport.
- Among the four solver examples, the `2.989L` response-released redirect is
  the strongest finite approach. Its top-down row shows a coherent alternating
  vorticity street and its oblique row shows persistent three-dimensional
  Lambda2 shedding, but the path still hooks into the upper boundary. The
  `4.859L` anterior stiffness-asymmetry case is the informative visual failure:
  it remains rhythmic, yet peak speed falls to `0.947U` and raw acceleration
  exceedance rises to about `54/65%`. This rejects another global anterior
  stiffness or half-cycle gain change.
- The inherited speed-gated target-ray/velocity-course controller is the
  evidenced broad-trajectory mechanism to preserve. With the zero-centered
  anterior oscillator and full posterior traveling carrier, both visual rows
  retain alternating wake structures, closest distance improves to `0.857L`,
  and the repeated upper hook becomes a left exit. At closest approach it is
  still moving at `0.845U` with about `-1.42 rad` wrapped course error, so the
  miss is an active, nearly tangent crossing rather than low-speed course
  noise or passive flow.
- The assigned-parent guidance records that smoothly raising posterior mean
  curvature from `12` toward `18 deg` improves that miss only marginally to
  about `0.832L`; the request is already saturated and posterior excursion is
  near `44.3 deg`. More scalar curvature is therefore unsupported.
- The newest completed inherited rollouts falsify posterior-only drive
  allocation. Course-gated posterior-carrier relief lowers speed at its
  `0.868L` closest point to `0.804U` and posterior raw acceleration exceedance
  to about `64%`, but it reaches the `45 deg` posterior hard limit and retains
  the left exit. Posterior counter-moment half-cycle relief similarly reaches
  only `0.867L` at `0.792U` with the same termination. Their top-down and
  oblique rows remain self-propelled and rhythmic, but the terminal path moves
  outward rather than into capture. Slowing or reallocating only the posterior
  target distorts the two-joint wave and is not useful terminal braking.

## Policy hypothesis written before the solver edit

Start from the inherited velocity-course controller and retain its bounded
full-quadrant target/course observation, zero-centered anterior oscillator,
distance-scheduled posterior mean curvature, complete posterior lag, and
posterior damping. Replace posterior-only terminal relief with one coherent
carrier-energy mechanism: inside the final `1.5L`, and only while the measured
velocity course is materially misaligned with the target ray, add mild
dissipation at the anterior oscillator that generates the traveling wave.
Let the posterior joint continue to track the complete lagged anterior state.

This differs from the failed posterior relief because the two joint motions
remain coupled as one traveling carrier while its source energy declines. The
gate is continuous, memoryless, normalized, and zero before the demonstrated
terminal regime; it preserves mean curvature and cannot select a world route
or clock phase. Expected evidence is the inherited broad sub-`1L` approach and
alternating wake followed by a modest coherent amplitude and crossing-speed
reduction, less posterior hard-limit contact, and capture rather than another
left exit. Falsify the mechanism if motion changes outside `1.5L`, the
alternating wake or sub-`1L` pass is lost, posterior angle/acceleration
occupancy rises, the fish coasts before capture, or termination does not
improve.

```text
bookshelf_consulted: true
source_domain: terminal capture control combined with sensor-modulated robotic-fish CPG direction tracking
source_mechanism: retain the slow steering bias and traveling-wave coupling while near-target misalignment continuously reduces carrier energy at its oscillator source
transferable_invariant: after broad target-directed propulsion works, gate a mild coherent reduction of propulsive drive by normalized proximity and target-ray versus measured-course error without weakening steering authority
nontransferable_details: published CPG gains, dimensional braking distances, robot linkage geometry, species-specific gait envelopes, clock phase, exact vortex phase, and task-specific routes
policy_translation: keep wrapped body-frame target_body_L versus velocity_body_U course feedback and bounded posterior mean curvature; inside a smooth distance-and-course-error gate add mild anterior joint-rate dissipation while the posterior joint tracks the full lagged anterior carrier
falsification: reject if pre-terminal motion changes, the alternating 3D wake or sub-1L approach is lost, the fish coasts, posterior limit occupancy rises, or capture/termination topology does not improve beyond the inherited 0.832--0.868L left-exit near misses
```
