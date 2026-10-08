# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The assigned parent proposed a `0.80`-period, `22 deg` angle-only oscillator
  with reduced `12 deg` positive-bearing steering, joint guards at `34 deg`
  and `200 deg/time`, and a `1600 deg/time^2` smooth action bound. Its now
  available rollout falsifies the expected preservation of upstream motion:
  the released keyframes show the fish remaining far to the right of the wake
  corridor, turning through a broad upward loop, and leaving the upper domain
  without useful wake entry. Head displacement is `(+0.43,+1.80)L`, progress
  is `-0.0897`, and mean velocity x (`+0.00174`) is close to local-flow x
  (`+0.00926`). The controller stayed finite for `63.55` released time, but
  finite flow-following is not target control.
- The parent protection was not wholly inactive on the realized trajectory.
  Joint-one speed reached `3.965 rad/time` (`227.2 deg/time`), above its
  `200 deg/time` guard, and joint-one command reached `27.175 rad/time^2`
  (`1557 deg/time^2`), close enough to engage the `1600 deg/time^2` smooth
  bound. Joint-one angle stopped just below the `34 deg` angle guard. Because
  period, posterior damping, steering gain/limit, guards, and action shaping
  all changed together, the longer finite episode cannot identify which term
  erased propulsion; it does show that the bundle did not leave the useful
  orbit unchanged.
- The common prewarm sheet shows the held fish at the upper-right release pose
  while four interacting cylinder streets develop through the target region.
  This is shared initial-condition evidence, not a controller effect. None of
  the released examples enters the useful wake corridor, so the present
  decision is still a far-field propulsion-and-stability decision.
- The positive-bearing `0.75`-period, `22 deg`, `16 deg`-limit angle-only
  policy remains the only sampled controller with active upstream approach.
  Its keyframes show a sustained leftward body wave through the first four
  samples and a sharply folded terminal turn in the last. Metrics corroborate
  both parts: head displacement `(-3.59,+0.15)L`, progress `0.259`, and mean
  velocity x `-0.149` versus local flow x `-0.0774`, followed by joint-one
  angle `38.12 deg`, joint-one speed at the `260 deg/time` cap, both commands
  at `1800 deg/time^2`, and RMS force/moment `20024/314391` before
  `unstable_dynamics` at `33.06` time.
- The target-blind seed is the informative finite failure: after a transient
  `8.61L` minimum it is swept `-13.30L` laterally out of domain, with mean y
  velocity `-0.263` nearly matching local flow `-0.241`. Two radial-regulated
  positive-bearing descendants also remain low-load but move about `+2.25L`
  downstream. Inherited optimizer logs add two more boundaries: broadly
  reduced angle-only gaits with `10 deg` steering/action shoulders exit in
  `10--13` time, and turn-rate or bearing-rate augmentation either produces
  large loads or near-immediate instability. These results do not support
  another global gait reduction, full-orbit radial regulator, or derivative
  feedback term.

## One candidate hypothesis

Restore every propulsion and steering parameter of the sole upstream-progress
policy (`0.75` period, `22 deg` amplitude, `0.5` excitation, `0.55` posterior
lag, `0.9` posterior damping, `0.75` positive-bearing gain, `16 deg` limit,
and `35/65` steering split). This makes the next result interpretable: the
nominal oscillator and bearing law are no longer confounded with the safety
change.

Add only terminal joint-state protection. A `36 deg` angle guard lies above
the `27.6 deg` nominal anterior excursion (`22 + 0.35*16`) and the sampled
posterior maximum of `32.06 deg`, but inside the observed `38.12 deg`
joint-one terminal excursion. A `225 deg/time` speed guard lies above the
approximately `184 deg/time` nominal anterior harmonic speed but below the
observed `260 deg/time` cap. Apply the same symmetric guards to both joints,
then use a high-order `1700 deg/time^2` smooth bound. The high-order bound
changes the nominal `1545 deg/time^2` harmonic demand by only about one percent
while preventing renewed hard-cap contact. All active thresholds and gains
remain in `target_policy_params`; the feedback uses only joint state and
normalized body-frame bearing, without a clock, coordinates, route, target
identity, prescribed inflow, or unavailable wake probes.

The next CFD rollout supports this hypothesis only if it preserves negative
head displacement and negative relative-flow x through the useful early leg,
remains finite beyond `33.06` released time, and avoids the terminal folded
shape, hard cap contact, and force/moment explosion. It is falsified if late
guards still erase upstream propulsion, merely delay the same fold, or retain
the nearly horizontal course without developing target-directed lateral
travel. No outcome for this candidate is claimed in this worker.
