# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common held-fish prewarm sheet shows four developed, overlapping
  cylinder wakes through the second-row target corridor while the fish starts
  above and downstream of it. All four current released sheets remain above
  and to the right of that corridor: the fish makes a self-propelled diagonal
  leftward leg, turns sharply nose-up after closest approach, and exits the
  upper boundary without wake entry. The unresolved regime is far-field
  course recovery, not wake exploitation or `0.75L` capture.
- The assigned `behind_bearing_fraction=-0.125` parent is actively propelled:
  mean head x velocity/local flow are `-0.07086/-0.04813`, and head travel is
  `(-4.555,+1.801)L`. It reaches `6.609L`, then exits after `69.85` released
  time with mean/final range `9.415/9.360L` and progress `0.2466`. Its anterior
  joint reaches `34.24 deg` and `259.90 deg/time`, essentially the hard speed
  cap, while RMS force/moment are `75.9/1004`.
- The sampled terminal-allocation gate is the strongest finite result. It
  leaves the `-0.125` approach law unchanged, then only when the target is
  more than `1L` rearward and both instantaneous and windowed range rates show
  opening faster than `0.02L/time`, unloads the anterior steering fraction
  from `0.35` to `0.10` while keeping the posterior fraction at `0.65`.
  Relative to the assigned parent it improves score from `-11.2406` to
  `-11.1487`, head-x travel from `-4.555` to `-4.676L`, progress from `0.2466`
  to `0.2542`, mean/final range from `9.415/9.360` to `9.342/9.266L`, and
  lifetime from `69.85` to `70.14`. It also lowers anterior angle/speed to
  `33.23 deg`/`251.35 deg/time` and RMS force/moment to `75.6/985`. Mean head
  x velocity `-0.07075` remains more upstream than local flow `-0.04945`, so
  the gain is not passive advection. The `6.609L` closest approach is unchanged
  and the keyframe sheet still shows the same upper exit, so this is a positive
  terminal-control gradient, not a recovered route.
- The simple rearward-bearing continuation to `-0.15625` also retains the
  upper-exit topology. It improves score/progress over the parent to
  `-11.1967`/`0.2522`, but reaches only `6.637L`, exits sooner at `67.74`, and
  is weaker than the allocation gate on score, upstream travel, progress,
  mean/final range, and lifetime. Together with inherited negative wider
  rearward-bearing, damping, range-only attenuation, and full-circle bearing
  tests, this favors refining the gated anterior allocation rather than adding
  another target-bearing or damping factor.

## Candidate hypothesis

Start from the strongest sampled terminal-allocation policy and change exactly
one active parameter: set `terminal_anterior_steering_fraction=0.00` instead of
`0.10`. The approach oscillator, `-0.125` behind-target bearing fraction,
`12 deg` steering ceiling, fixed `0.04` recent-turn damping, joint guards,
acceleration limiter, three-factor terminal trigger, and posterior steering
fraction remain unchanged. Under a fully active trigger this modestly reduces
the total mean steering allocation from `0.75` to `0.65` of the bounded steering
command without reversing anterior curvature; before deep rearward, sustained
opening it is exactly the evaluated closing controller.

The hypothesis is supported if the rollout remains finite, retains at least
about `-4.65L` upstream head travel and a `6.65L` or better closest approach,
and further improves progress or mean/final range while keeping anterior speed
below the hard cap and RMS force/moment near or below `76/1005`. It is falsified
if the useful leg is shortened, either boundary-return topology persists
without a material navigation gain, anterior speed rises, or loads increase.
The policy uses only normalized body-frame target projection, normalized range
rates, joint state, and measured recent turn. It contains no coordinate, clock,
route, prescribed inflow, remote wake probe, target-station signal, or omitted
research-shelf dependency. Formal CFD is deferred to EvE; no outcome for this
candidate is claimed here.
