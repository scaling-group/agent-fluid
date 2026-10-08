# Multi-wake candidate diagnosis and hypothesis

## Evidence diagnosis

- The shared prewarm sheet shows the common release far downstream and above
  the target, with four mature, interacting vortex streets between the fish
  and the second-row station. Candidate differences therefore begin after the
  same held-fish flow state.
- The target-blind seed is visibly self-propelled but not target controlled: it
  turns into a steep lower-domain trajectory instead of entering the useful
  wake corridor. Its `-3.55L` head-x displacement is overwhelmed by
  `-13.30L` head-y displacement; the `8.61L` transient minimum becomes a
  `12.12L` final range and left-domain termination at `50.13` released time.
- The positive-bearing, angle-only oscillator is the only sampled policy with
  substantial upstream progress (`-3.59L` head x, `0.259` progress, `9.01L`
  minimum range). Its keyframes show an initially productive targetward turn
  followed immediately by severe body folding. The numerical cross-check is
  decisive: it terminates unstable at `33.06`, with RMS force/moment
  `20023.6/314391`, rather than reaching the wake station.
- The assigned parent keeps the same angle-only architecture but slows the
  period from `0.75` to `0.80`, reduces the steering bound from 16 to 12
  degrees, and adds joint guards plus a 1600-degree smooth acceleration bound.
  It remains finite for `63.55`, and its keyframes show a much less folded
  body, but after initially approaching it makes a broad turn away from the
  target and exits with head displacement `(+0.43,+1.80)L`, `-0.090` progress,
  and a final range (`13.54L`) worse than its `10.35L` minimum. RMS
  force/moment fall to `102.6/1600`, so stabilization survived but sustained
  upstream bearing did not.
- The two phase-radius-regulated examples are also finite and low-load, but
  their `+2.24L` and `+2.27L` streamwise head displacements and negative
  progress agree with the visuals: they are largely advected and never enter
  the useful wake region. The inherited parent log adds a sharper warning:
  another candidate with low mean command effort (`150.0`) exits after only
  `10.02`, with `+2.79L` downstream motion, `0.827` RMS relative crossflow,
  and RMS force/moment `4188/48543`. Low command effort alone is not evidence
  of a gentle or effective interaction with the developed wake.

## Single candidate hypothesis

Retain the assigned parent's bounded angle-only oscillator and local
angle/speed guards, because those changes removed the sampled folded-body
instability. Restore the demonstrated `0.75` control period to recover the
upstream authority lost by the `0.80` parent, but keep a policy-owned smooth
acceleration envelope below the hard cap. Add only bounded body-frame
recent-turn damping to the positive bearing request: this should oppose the
large looping reorientation visible in the parent without replacing its
route-free target signal or regulating away the oscillator's phase energy.

The candidate is supported only if the next CFD rollout remains finite beyond
`50.13` time while combining negative head-x displacement with target-directed
lateral motion and improving both minimum and final distance. It is falsified
if it reproduces the parent's broad loop/advection, touches persistent hard
caps or folded high-load dynamics, or merely delays a domain exit without
sustained distance progress.
