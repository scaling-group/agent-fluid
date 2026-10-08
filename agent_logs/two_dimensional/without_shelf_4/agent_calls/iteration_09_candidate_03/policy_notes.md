# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held high and downstream/right of the target while the four staggered
  cylinder streets develop and overlap across the target corridor. This is a
  common initial condition and cannot rank policies.
- All four current released sheets and physical metrics are also identical,
  despite cosmetic source differences. The demonstrated `20.25 deg`,
  `0.67`-period, `0.25`-lead controller makes a broad correction with several
  alternating turns on the right, then enters the interacting central wake
  and closes nearly horizontally without collision, domain exit, instability,
  or rebound. It captures at `244.547`, with mean/final distance
  `6.452/0.750L`, maximum lateral target offset `4.293L`, and head travel
  `(-10.916,-4.187)L`.
- This route is wake-assisted but not passive advection. Mean head velocity x
  is `-0.04443` against mean local-flow x `-0.03649`, leaving `0.00793` of
  controller-relative upstream transport. Maximum anterior acceleration is
  already `31.055 rad/time^2` against the `31.2` policy guard and `31.416`
  episode cap; RMS relative crossflow, lateral force, and moment are
  `0.13437`, `18.263`, and `362.214`. Propulsion amplitude has no supported
  upward margin, while the visible opportunity is reversal timing before wake
  retention.
- No current sample is a hard failure. The assigned parent and inherited notes
  retain the physical boundary: a `14 deg`, `0.80`-period controller was
  advected downstream and exited at `16.747`, while a finite self-propelled
  `19 deg`, `0.67`-period controller missed at the horizon with a `5.812L`
  minimum. The current `20.25 deg` anchor is therefore a narrow demonstrated
  corridor-acquisition point rather than evidence for monotone gait increase.
- The inherited `0.20` bearing-rate-lead evaluation is the most informative
  failed control hypothesis with a packaged keyframe sheet. Relative to the
  otherwise identical `0.25` anchor, its path has wider, more jagged vertical
  reversals before later central-wake entry. It still captures, but at
  `258.621`; mean distance worsens to `8.041L`, RMS force rises to `18.629`,
  and controller-relative upstream transport falls to `0.00556`. Maximum
  offset (`4.293L`) and anterior acceleration (`31.055`) are unchanged, and
  the small moment reduction to `360.028` does not compensate for the longer,
  more loaded route. Thus the regression is steering timing, not lost drive,
  saturation, collision, or instability.
- The complementary inherited `0.30` constant lead also regressed: its tighter
  early loop developed extra reversals, captured at `270.446`, had mean
  distance `8.499L`, and raised RMS force to `18.958`. Along with the negative
  positive-closure bearing relief and `0.28` static-bearing-scale tests, this
  brackets `0.25` as the supported constant bearing/rate bundle and rules out
  another global gain or lead perturbation.

## Candidate hypothesis

Preserve the sampled `20.25 deg`, `0.67`-period oscillator, `0.65/0.80`
posterior lag/damping, `10 deg` steering limit, `0.30` bearing scale,
`0.30 rad/time` bearing-rate bound, and `31.2 rad/time^2` acceleration guard.
Replace the constant lead with one bounded asymmetric rate response. When
`bearing * bearing_rate <= 0`, the target-bearing error is stationary or
converging and the evaluated `0.25` lead is retained exactly. When the product
is positive, smoothly blend toward `0.20` using the product normalized by the
existing bearing and rate scales. This changes neither propulsion nor the
static bearing response, introduces no coordinate, clock, route, or remote
wake signal, and becomes the evaluated anchor again as soon as divergence
ends.

The two-sided constant-lead evidence motivates this separation: globally
reducing lead appears to delay useful unwind and widen the route, whereas
globally increasing it amplifies premature reversals. Selectively reducing
only the diverging-error rate term should avoid rate-driven growth without
changing the demonstrated converging-error timing. The next fixed-prewarm CFD
evaluation should retain capture and central-wake entry while reducing the
right-side reversal width, mean distance below `6.452L`, arrival below
`244.547`, or lateral load without guard contact. Falsify the mechanism if it
captures later, raises mean distance/load, loses controller-relative upstream
transport, creates switching near zero bearing/rate, or misses. If falsified,
restore constant `0.25` and treat bearing-scale, global lead, closing-speed
relief, and this sign-asymmetric lead as locally exhausted; a later worker
should test a separately evidenced bounded corridor observation.
