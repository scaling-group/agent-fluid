# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The four sampled shared-prewarm sheets are byte-identical. They show the
  fish held at the common upper-right pose while the four staggered cylinder
  streets develop, merge, and cross the target region. This is the certified
  common initial condition, not policy-specific evidence.
- All four sampled released rollouts reach the target; no collision, domain
  exit, instability, or horizon miss is available as a current visual failure.
  The most informative adverse finite comparator is therefore the isolated
  `1675 deg/time^2` posterior-cap regression. Its sheet and the best `1600`
  sheet both show an initial target-facing turn, dense alternating propulsive
  wake, active left/down traverse, late entry into the merged cylinder wake,
  and safe first crossing of the `0.75L` target ring. At corresponding middle
  frames the `1600` fish is visibly farther along the same route; neither sheet
  suggests passive advection or wasteful lateral escape.
- The CSV and embedded wake diagnostics agree with the pictures. The two exact
  `1650` samples replicate at score `0.189303`, arrival `33.027`, mean distance
  `1.6831L`, energy/power `42310/3183`, mean velocity
  `(-0.3289,-0.1367)`, crossflow `0.2358`, and force/moment RMS
  `63.93/859.31`. Changing only the cap to `1600` improves score to `0.217528`,
  arrival to `32.202`, mean distance to `1.6541L`, energy/power to
  `40126/3010`, and mean velocity to `(-0.3380,-0.1396)`. It also reduces
  crossflow to `0.2321` and joint excursions to `0.492/0.474` rad. Force and
  moment rise only slightly to `64.77/860.25`, well inside the inherited
  `75/1000` rejection boundary, while the commanded posterior maximum is the
  active `27.925 rad/time^2` ceiling.
- The `1675` comparator regresses to score `0.177318`, arrival `33.605`, mean
  distance `1.6954L`, and energy/power `43589/3272`; its lower
  `57.87/797.09` force/moment loads are bought by slower target progress. The
  current evidence therefore preserves the inherited conclusion that this cap
  is a navigation/effort axis rather than an unloading knob. Inherited notes
  also show that weaker amplitude fell behind, gain/allocation/lag/damping
  continuations were non-monotonic, and mixed auxiliary feedback became
  unstable at `2.807`; none of those axes or observations should be combined
  with this candidate.

## Single-candidate hypothesis

Materialize the exact sampled `1600 deg/time^2` posterior acceleration limit,
leaving period, amplitude, oscillator drive, lag, damping, bounded body-frame
bearing law, steering allocation, and observations unchanged. This is a
replication of the best finite policy in the assigned evidence, not an
extrapolation below `1600` or a claim that tighter caps are generally better.

The later CFD evaluation supports the candidate only if it preserves the
visible safe, self-propelled turn-then-diagonal capture and materially matches
the sampled `1600` navigation/effort envelope: arrival near `32.202`, mean
distance near `1.6541L`, and energy/power near `40126/3010`. Loss of capture or
route, collision, exit, instability, regression beyond the replicated `1650`
anchor, relative crossflow above `0.25`, force RMS above `75`, or moment RMS
above `1000` falsifies the candidate. Even an exact repeat establishes only
certified-wake/start-pose repeatability, not held-out wake-phase or geometry
robustness.
