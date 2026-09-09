# Multi-Wake Target-Policy Candidate Notes

## Evidence and visual diagnosis before the edit

- The shared prewarm sheet shows the common upper-right held pose and four
  developed, interacting cylinder streets across the target. It is identical
  initial-condition evidence, not policy credit.
- The prefilled bearing-to-mean-curvature policy is the informative unstable
  failure. It produces a tightly curled body and large paired vortices almost
  immediately, terminates as `unstable_dynamics` after `9.372`, and has force/
  moment RMS `23111/397906`; it cannot be used as a steering scaffold.
- Posterior-only half-cycle asymmetry remains finite and self-propelled, but
  `solver_785c44ad57e0` follows the seed-like monotone lower escape: head
  displacement `(-4.557,-13.291)L`, minimum distance `8.203L`, lower exit at
  `54.896`, and both joint velocity and acceleration caps reached. This does
  not support more posterior-asymmetry authority.
- Distributed anterior/posterior acceleration asymmetry is the reusable
  propulsion improvement. `solver_928f830d4c45` traverses upstream
  `-9.726L`, survives `91.245`, and reaches `4.621L`; its keyframes nevertheless
  show the path crossing below the target and continuing to the same lower
  boundary. Its joint-1 excursion reaches `0.732 rad`, both velocity limits
  are contacted, and force/moment RMS rise to `314/3430`, so increasing the
  asymmetry is not a safe answer.
- The assigned parent's heading-response release candidate
  `solver_a84fba8bf04f` is the best geometric near miss. Its released sheet
  shows the same active upstream traverse but bends through the target's lower
  side before exiting; minimum distance improves materially to `1.646L` and
  mean distance to `8.719L`. It still loses `13.233L` laterally, exits after
  `75.086`, contacts both velocity caps, and raises force/moment RMS further
  to `487/4680`. Thus observed response release helps target approach but the
  body-heading-rate proxy does not release the terminal turn reliably.
- Inherited `solver_78b1ea3edfcb` adds predicted bearing and posterior mean
  curvature to the distributed scaffold, but it is advected `+2.194L`
  downstream, never beats the initial `12.424L` distance, and exits after
  `18.227`. This extends the negative equilibrium evidence to posterior mean
  curvature; the next candidate must retain acceleration-level asymmetry.

## Candidate hypothesis

Keep the assigned parent's zero-centered traveling-bend oscillator, posterior
lag, distributed acceleration half-cycle asymmetry, and smooth acceleration
limit. Replace its body-heading-rate proxy with the measured windowed rate of
body-frame target bearing. A closing bearing trend must reduce the turn request
while a growing miss strengthens it. Continuously increase that prediction
horizon only inside a normalized approach region, so the same feedback releases
earlier near the tight capture circle without weakening far-field propulsion or
introducing a mean-curvature equilibrium, clock, route, or wake-phase command.

Expected evidence is retention of active negative-x travel, a closest approach
better than `1.646L` or target capture, and less continuation into the repeated
lower-boundary arc. Falsify the mechanism if upstream displacement collapses,
the closest approach regresses, the line-of-sight trend amplifies an already
closing turn, or the same lower exit and cap/load symptoms persist without a
materially better distance history.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and wake-adaptive capture with observation history
source_mechanism: release rhythmic turning as measured target-error response closes, with earlier response damping during terminal approach
transferable_invariant: persistent normalized body-frame direction error selects half-cycle steering, while its measured trend and normalized target distance distinguish a growing miss from an already-correcting near-target turn
nontransferable_details: published gains, recurrent-network state, robot or species kinematics, dimensional beat frequencies, exact vortex phases, fixed routes, and source-task target geometry
policy_translation: preserve the evaluated two-joint traveling bend and distributed acceleration asymmetry; forecast body-frame bearing with its bounded windowed rate and continuously lengthen only that forecast inside the approach region
falsification: reject if upstream propulsion or closest approach regresses, target-error trend has the wrong release sign, or lower exit, joint-cap contact, and high loads persist without semantic improvement
