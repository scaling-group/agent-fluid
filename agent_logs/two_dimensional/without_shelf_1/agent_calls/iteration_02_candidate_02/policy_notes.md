# Multi-wake candidate diagnosis and hypothesis

## Evidence diagnosis

- The common prewarm sheet shows developed, overlapping vortex streets already
  reaching the held fish at release; the candidate must tolerate an unsteady
  initial load rather than relying on a quiescent startup.
- The strongest finite sample (`-12.758`) used a `0.90`-period anterior
  oscillator and posterior-only positive target-bearing bias. It visibly swam
  upstream into the wake region and reached `6.34L` minimum distance, while
  surviving `73.39` release units. Its mean x velocity (`-0.0447`) exceeded the
  upstream component of local flow (`-0.0293`), so the motion was not pure
  advection. It then curled upward into a broad loop and exited, consistent
  with its `+1.75L` head-y displacement even though the target lay below the
  release pose. Both joint rates reached the hard cap, joint 2 reached `45
  deg`, and RMS force/moment rose to `196/2014`, so copying its full gait and
  `10 deg` bias unchanged is too aggressive.
- The negative-bearing-sign sample visibly pitched downward, but its
  `1.10`-period, `11 deg` gait moved `+2.45L` downstream and produced negative
  progress before exiting at `17.26`; its low RMS force/moment (`12.5/309`)
  shows that steering sign alone cannot compensate for insufficient upstream
  propulsion.
- The assigned parent shifts the anterior oscillator equilibrium as well as
  the posterior tangent. It visibly folds into a tight C-shape immediately and
  terminates unstable at `3.39`, with relative crossflow `1.31` and RMS
  force/moment `56162/580120`. Steering must therefore be isolated from the
  anterior propulsion oscillator in this candidate.
- The target-blind seed mainly follows local crossflow downward (`-13.30L` y;
  mean velocity/local-flow y `-0.263/-0.241`) and saturates both rates and
  accelerations. It is useful only as evidence that a target-relative term is
  necessary, not as a gait to retain unchanged.

## Candidate hypothesis

Use an unshifted phase-plane oscillator on joint 1 so its radius is explicitly
regulated below the joint envelope. Retain enough amplitude and a `0.95`
period to test upstream authority, but reduce posterior lag and cap commands so
the nominal traveling bend fits below the documented rate, angle, and
acceleration limits. Apply target steering only through the mean posterior
tangent, with the sign reversed from the strongest finite sample and a `6 deg`
limit; fade it within the final `1.5L` as in that sample.

The hypothesis is supported if the fish preserves self-propelled upstream
motion while correcting downward without a tight curl, extends finite survival
beyond the parent's `3.39`, and avoids persistent joint/load saturation. It is
falsified if upstream progress disappears (gait too weak), bearing/lateral
escape grows (steering sign or authority wrong), or the anterior joint again
approaches its hard limits despite removing steering from its oscillator.
