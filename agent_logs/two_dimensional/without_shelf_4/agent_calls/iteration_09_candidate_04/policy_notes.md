# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four current shared-prewarm sheets are byte-identical. They show the
  fish held high and downstream/right of the target while the four staggered
  cylinder streets develop and merge across the target corridor. This is a
  common initial condition and cannot rank policies.
- The four current released sheets and physical metrics are also identical.
  The `20.25 deg`, `0.67`-period anchor makes a broad down/up correction on the
  right, then enters the interacting central wake and closes nearly
  horizontally on the target. It reaches `0.7498L` at `244.547`, with mean
  distance `6.452L`, head travel `(-10.916,-4.187)L`, and no collision, exit,
  rebound, or instability. Mean head velocity x `-0.04443` versus mean local
  flow x `-0.03649` leaves `0.00793` controller-relative upstream transport,
  so this is wake-assisted self-propulsion rather than passive advection.
- The most informative evaluated failed hypothesis is the isolated reduction
  in bearing-rate lookahead from `0.25` to `0.20`. Its keyframes remain farther
  right and add a wider reversal sequence before the final central-wake
  approach. It still captures, but `14.074` later at `258.621`; mean distance
  worsens by `1.589L` to `8.041L`, RMS lateral force rises from `18.263` to
  `18.629`, and controller-relative upstream transport falls from `0.00793` to
  `0.00556`. The gait extrema are unchanged (`31.055/23.4 rad/time^2` joint
  accelerations), so the regression is steering topology rather than weaker
  propulsion or cap contact.
- Inherited logs complete the local steering bracket. Increasing lookahead to
  `0.30` delayed capture to `270.446`, raised mean distance to `8.499L`, and
  raised RMS lateral force to `18.958`; changing static bearing scale from
  `0.30` to `0.28` also enlarged the detour, while closing-speed-gated relief
  toward scale `0.32` delayed capture to `256.663` and raised RMS force to
  `18.426`. Both directions around the `0.25` lookahead and both gain
  sharpening and relief are negative. Closing speed did not identify safe
  corridor retention.
- The anchor's anterior maximum acceleration is already `31.055 rad/time^2`
  against its `31.2` policy guard and the `31.416` episode cap. More amplitude
  is unsupported. Its RMS lateral force `18.263` corresponds to about `0.285`
  in the task's `force_body_L` observation, while mean lateral force is nearly
  zero. Across the evaluated steering regressions RMS force rises even when
  RMS moment or relative crossflow does not, making bounded body-frame lateral
  load the remaining evidence-scaled signal to test.

## Candidate hypothesis

Preserve the complete demonstrated anchor: `20.25 deg` oscillator shell,
`0.67` period, `0.65/0.80` posterior lag/damping, `10 deg` steering limit,
`0.30` bearing scale, `0.25` bearing-rate lookahead, and the `31.2 rad/time^2`
guard. Add one bounded lateral-load rejection term to the steering error. The
term subtracts the signed normalized body-frame lateral force using a `0.30`
force scale, chosen from the anchor's approximately `0.285` normalized RMS,
and is capped at `0.75 deg`. Positive lateral load therefore asks for the same
steering sign as a small target-bearing error on the opposite side.

The correction is zero at zero load, cannot change the propulsion oscillator,
and is small compared with the `10 deg` posterior steering bound. Because it
is placed inside the existing saturated bearing response, it should leave the
large-error release turn nearly unchanged and act mainly after alignment, when
the inherited evidence says preserving the wake corridor matters. The next CFD
rollout should retain target capture and the anchor's central-wake topology
while reducing route-integrated distance, arrival time, or RMS lateral force
without guard contact. Falsify the mechanism if it injects tailbeat-frequency
steering, widens the reversal sequence, raises crossflow/load, delays capture
beyond `244.547`, or loses the target. In that case restore the unmodified
anchor and avoid direct instantaneous force feedback; a later worker should
test a genuinely low-pass body-frame retention signal rather than retuning
bearing gain, rate lookahead, closing-speed relief, or gait amplitude.
