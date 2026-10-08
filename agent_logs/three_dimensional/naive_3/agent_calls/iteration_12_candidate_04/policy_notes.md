# Wake-policy candidate notes

## Evidence and visual diagnosis

- All sampled and inherited evaluations are valid direct-uniform still-water
  releases with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In both
  top-down and oblique sheets, motion follows active alternating vorticity and
  three-dimensional Lambda2 structures rather than passive advection: sampled
  peak swimming speeds are `0.947--1.038U` while peak head-local flow is only
  `0.027--0.034U`.
- The closest sampled full-quadrant redirect reaches `2.989L`; the anterior
  half-cycle stiffness variant reaches only `4.859L`. Their top-down rows keep
  an alternating wake through the approach but bend into the same high/left
  escape, and their oblique rows retain discrete three-dimensional structures.
  Anterior stiffness shaping therefore changes effort and speed, not the
  missing trajectory topology: its raw acceleration-envelope exceedance rises
  to about `53/64%`, versus about `34/45%` for the closest sampled redirect.
- The assigned-parent guidance identifies the body-frame target-versus-course
  angle as the only demonstrated broad-approach semantic improvement: it
  reached `0.857L`, only `0.107L` outside capture, and changed termination from
  the repeated upper hook to a left exit while remaining self-propelled. At
  closest approach the head was roughly `0.84L` high and still translating
  left/down, so the remaining defect is excess through-speed/turn radius in a
  narrow terminal interval rather than loss of broad target direction.
- The assigned parent's completed predicted-miss counterstroke-relief rollout
  is a concrete negative result. It preserved the broad course-controlled
  wake, but closest distance regressed to `0.903L`, final distance grew to
  `9.034L`, raw acceleration exceedance remained about `58/66%`, and the fish
  still left the left boundary. Its terminal trace stayed near `0.77--0.84U`
  and oscillatory while the absolute constant-course miss remained about
  `0.7--1.0L`; merely weakening one posterior half-cycle neither braked the
  pass nor supplied capture authority.

## Policy hypothesis

Restore the evidenced full-quadrant course-angle controller for broad
approach. Inside a compact capture funnel, use normalized body-frame target and
velocity to compute constant-course miss distance. When proximity and miss
geometry agree, taper the complete oscillatory posterior carrier on both beat
halves while preserving the zero-centered anterior oscillator and the full
posterior mean-curvature request. This is a terminal thrust-allocation test:
lower surge should tighten the course-controlled turn per unit distance without
the fixed joints of a hold or the biased yaw impulse of counterstroke relief.

The gate is analytically zero outside `1.8L`, so sampled broad approach and
wake production should be unchanged. Falsify the candidate if it changes the
trajectory before that boundary, loses the alternating wake, increases raw
limit occupancy, repeats a minimum distance at or above `0.857L`, or coasts
through the capture neighborhood without crossing `0.75L`.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal target capture
source_mechanism: sensor-gated separation of rhythmic propulsion authority from low-frequency steering authority
transferable_invariant: preserve the established traveling-wave controller far from the target, then reduce excess propulsive authority near a predicted miss without removing the steering bend
nontransferable_details: published gains, dimensional switch distances, duty ratios, species-specific kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target and velocity to gate a symmetric posterior-carrier taper while retaining the zero-centered anterior oscillator and bounded course-driven posterior curvature
falsification: reject if broad approach changes, the wake collapses, actuator occupancy rises, or the candidate fails to improve on the `0.857L` course-controlled near miss and cross the `0.75L` capture radius

## Pre-evaluation checks

- A deterministic replay of the candidate gate on the assigned-parent trace
  confirms no intervention at or beyond `1.8L`. It first activates at about
  `17.29T`, reaches the bounded `0.45` carrier floor near `0.98L`, and remains
  a continuous state-feedback schedule rather than a clocked stage.
- The guidance-difference and solver-boundary checks pass. All 16 direct
  `params.FIELD` references are declared, and the candidate contains no time,
  route, cylinder, random, file-I/O, or mutable-global dependency. The local
  Julia dynamic-load check is unavailable because this container has no Julia
  executable; no CFD evaluation was run or inferred.
