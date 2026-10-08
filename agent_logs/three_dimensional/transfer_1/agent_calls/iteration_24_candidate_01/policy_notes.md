# Wake-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled solvers contain the same policy and byte-identical
  trajectory.  Each starts from direct uniform still water, shifts the storage
  window 239 times without imposed inflow, and captures at `18.2324905 T` with
  score `-0.12649962`, final distance `0.74990594 L`, total distance integral
  `2.0129834 L`, and observed integral `1.3998040 L`.  The repetitions support
  a stable controller outcome rather than an isolated terminal sample.
- The readable combined sheets show self-propulsion along a smooth
  target-directed arc: the top-down row develops a coherent alternating
  vortex street and the oblique row develops compact paired Lambda2 structures
  that remain attached to the traveling posterior wake through capture.  The
  body does not drift passively, execute a late route reversal, or visibly lose
  its carrier.  One sampled combined sheet has a black oblique row, but the
  other three have identical readable oblique sheets; this is a rendering
  failure, not a different trajectory or control failure.
- The reproduced v38 envelope is already useful: mean/max speed is about
  `0.703/0.952 L/T`, peak normalized force/moment is
  `0.03068/0.01579`, and acceleration-limit residence is about `41.54%`.
  The main remaining structural opportunity is therefore allocation of
  steering that is already requested but clipped, not more carrier amplitude,
  cadence, or hydrodynamic-sensor duty cycle.
- Inherited closed-loop comparisons show that ungated reverse recovery of
  posterior-rejected steering helped the slower whole-wave base
  (`18.9970 -> 18.8705 T`), but became mildly harmful after productive-closing
  cadence release (`18.7550 -> 18.7660 T`, with worse middle/late checkpoints
  and observed integral).  Frozen-state reconstruction placed every reverse-
  recovery event in strong positive closure.  The current sampled siblings
  also show that broadening the successful crossflow confidence with a
  high-duty-cycle lateral-load cue worsens route integral and speed.  These
  negative results rule out unconditional extra steering and unconditional
  sensor union.

## Single policy hypothesis

Preserve v38's oscillator, posterior lag, crossflow band-pass pose rejection,
route feedback, and head-to-tail spillover.  Add one reverse allocation path:
measure only native tail steering rejected after the posterior carrier takes
its componentwise acceleration headroom, transfer that signed residual into
the anterior joint's remaining headroom, and multiply it by one minus the
already normalized productive-closing response.  Thus stalled or reversing
closure can borrow otherwise discarded steering, while established closure
continuously releases the anterior joint back to its proven carrier.  No
carrier demand, head-to-tail spillover, force signal, route coordinate, or
hidden phase is transferred.

This is falsified if it loses capture, is farther away at the `4/8/12/16 T`
checkpoints, exceeds the v38 total/observed integrals
`2.0129834/1.3998040 L`, or materially exceeds its `0.952 L/T` maximum speed,
`41.54%` acceleration-limit residence, `0.03068/0.01579` peak normalized
force/moment envelope, or coherent two-view wake.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish rhythm modulation and biological burst redirects
source_mechanism: add bounded steering asymmetry to a propulsive rhythm, then release it when the observed maneuver response appears
transferable_invariant: preserve the rhythmic carrier and condition extra maneuver authority on measured task response rather than time or a memorized phase
nontransferable_details: published gains, oscillator timing, species-specific C-start kinematics, body envelopes, and exact vortex phases
policy_translation: transfer only acceleration-clipped tail steering into anterior headroom while normalized closing response is absent; retain the two-joint state-feedback oscillator and body-frame target geometry
falsification: reject the transfer if route-wide closure, capture, wake coherence, or the established speed, saturation, force, and moment envelope regresses
