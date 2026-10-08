# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled solvers report direct uniform still-water initialization,
  capture at `16.043510T`, minimum/final distance `0.746962L`, score
  `-0.058311`, and 228 moving-window shifts. Their combined keyframe sheets
  are byte-identical even though three policy source hashes are represented.
  The inherited step-9 through step-11 optimizer logs likewise contain the
  same best capture; the only different inherited log is another capture at
  `0.748557L` and score `-0.059985`.
- In the combined sheet's top-down row, the fish begins in quiescent fluid,
  develops a coherent alternating vorticity street by `4T`, retains a strong
  posterior traveling bend through `12T`, and turns into the capture circle by
  `16T`. The oblique row confirms a compact alternating three-dimensional
  Lambda2 wake rather than passive advection or a planar rendering artifact.
  The trajectory and diagnostics agree: background velocity is zero, forward
  body speed is about `1.05U` at capture, and distance decreases monotonically
  over the final approach.
- The current sampled set contains no informative failure visualization to
  compare against the finite best: all four wake sheets and rollout metrics
  are identical. Earlier upper exits, broad U-turns, and near misses are
  available only through the assigned parent's distilled numeric evidence, so
  no new visual cause is asserted for those failures.
- Offline replay of the recorded body-frame observations exposes a control
  conflict at the final crossing. At the first `0.8L` sample, the proximity
  and closing gate is about `0.984` while the high-authority redirect gate is
  about `0.933`; the old law therefore damps the anterior oscillator and
  reduces the posterior wave to roughly its `0.70` floor at the same instant
  that a large target-versus-course mismatch requests the strong redirect.
  At capture the corresponding gates remain about `0.983` and `0.929`.
- The exact velocity-boundary anti-windup is a useful command cleanup but not
  a physical trajectory change here: its code-distinct sampled policy has the
  same arrival, score, distance history, and keyframes as the unprojected
  carrier-phase-residual controller. Another infeasible-command wrapper would
  not test a new hydrodynamic mechanism.

## Policy hypothesis

Retain the captured carrier, residual-selected posterior redirect, raw-error
turn direction, closing-conditioned redirect onset, acceleration allocation,
and exact velocity-limit projection. Split the existing near-target gate into
two roles: proximity plus closing may continue to lower the redirect onset,
but anterior damping and posterior-wave reduction become a settle-only action
that vanishes continuously as either raw or residual high-authority redirect
duty opens. This is a response-conditioned release, not a scalar gain change.
It should preserve full rhythmic authority through the large terminal course
mismatch, then restore the inherited `0.70` wave floor and damping only after
the course response aligns. Falsify it if capture is lost or delayed, the
coherent wake breaks down, the upper-exit topology returns, or acceleration
residence and loads grow without earlier distance milestones.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and terminal fish capture
source_mechanism: sensor feedback schedules rhythmic authority across approach and redirect regimes
transferable_invariant: reduce drive near a target only when measured response no longer calls for corrective steering
nontransferable_details: published CPG gains, species-specific kinematics, dimensional timing, exact wake phase, and source-task routes
policy_translation: multiply the existing proximity-plus-closing relief by one minus the bounded maximum of raw and phase-residual redirect duty, using only normalized body-frame target, velocity, and joint state
falsification: reject if terminal capture or earlier milestones regress, wake coherence is lost, or extra feasible wave authority raises limiting and loads without useful route correction
