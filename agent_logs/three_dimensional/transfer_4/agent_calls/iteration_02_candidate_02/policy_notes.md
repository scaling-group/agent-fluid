# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the Phase-2 initialization contract:
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot. Their combined sheets contain both the top-down vorticity
  row and the oblique body/Lambda2 row.
- The signed-curvature candidate is the only sampled semantic success. Its
  top-down sequence shows a coherent alternating wake while the body first
  translates left and then turns down toward the target; the oblique sequence
  confirms persistent three-dimensional caudal structures rather than passive
  advection or wake collapse. It captures at `23.353T`, with minimum/final
  distance `0.7497L`, mean distance `2.4147L`, and score `-0.51791`.
- The inherited optimizer logs explain the four changes made from the same
  transferred seed. The steering-reserve allocator exits the upper boundary
  at `17.578T` with minimum distance `6.2764L`; the velocity-course redirect
  reaches `4.0215L` but then exits the upper boundary at `29.673T`; and the
  large-error geometry redirect reaches only `5.7746L` before returning to the
  lower boundary at `30.019T`, ending `13.0563L` away. Their visual wakes remain
  propulsive, so these are added-branch course failures rather than evidence
  that the carrier must be replaced.
- The outcome isolates the useful mechanism: the successful candidate removes
  direction-specific recovery curvature and maps the bounded body-frame turn
  request to posterior mean curvature with one odd map of matching sign. That
  is a materially stronger result than the assigned prefill's gated redirect,
  which preserved the original inverse-polarity branches and failed.
- The successful trace reports raw policy requests beyond the fixed
  `1800 deg/T^2` limit in about `70.0%` of joint-1 samples and `51.8%` of
  joint-2 samples, although the episode integrator clamps those requests before
  updating joint state. Joint angles remain within approximately `27.6/37.2`
  degrees and the measured wake remains coherent. An explicit final clamp at
  that same fixed envelope is therefore a behavior-preserving contract guard,
  not a new allocator or a claim that lower acceleration is already validated.

## One candidate hypothesis

Use the sampled capture controller as the candidate architecture: preserve its
state-feedback traveling bend, posterior lag, normalized target geometry, yaw-
rate feedback, distance-conditioned approach relief, and the single signed odd
posterior-curvature map. Do not combine it with the three failed reserve/course/
geometry branches. Add only an explicit output clamp, owned by
`target_policy_params`, at the same acceleration envelope already applied by
the fixed episode integrator. Because `clamp(clamp(x,l),l) == clamp(x,l)`, this
guard should leave the sampled physical joint evolution unchanged while making
the policy's public command bounded.

Expected result: reproduce the coherent capture topology near `23.35T` and
avoid both upper- and lower-boundary departures. Falsify the transfer if the
body-frame bearing fails to contract, if the alternating wake loses coherence,
or if the candidate does not capture despite the dynamically equivalent output
clamp. A faster score is not claimed from this unevaluated candidate.

bookshelf_consulted: true
source_domain: robotic-fish turning and averaging models
source_mechanism: bounded target-directed mean-curvature bias superposed on a propulsive oscillator
transferable_invariant: preserve the traveling propulsive bend while mapping signed body-frame route error through one bounded reflection-equivariant average-curvature command
nontransferable_details: published gains, robot geometry, species-specific kinematics, dimensional beat settings, exact vortex phases, and prescribed routes
policy_translation: retain the normalized target-and-yaw feedback and map its bounded turn request to a same-sign posterior tangent setpoint in the two-joint state-feedback oscillator, with only a fixed-envelope output guard
falsification: reject if the prior capture topology is lost, target-bearing contraction fails, or wake coherence and bounded joint motion deteriorate
