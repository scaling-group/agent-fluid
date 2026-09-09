# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held above and downstream of the target while four developed cylinder wakes
  overlap around the second-row corridor. Every released sheet inspected stays
  above and to the right of that corridor. The immediate failure is therefore
  far-field course recovery, not wake exploitation or tight-radius capture.
- The best sampled finite result is the fore/aft-gated policy that retains the
  demonstrated target-ahead law and applies a `-0.25` fraction of the existing
  bearing term once the target is behind. Its sheet shows a sustained leftward
  swimming leg followed by the familiar nose-up turn and upper-domain exit.
  The metrics confirm both active propulsion and a modest terminal benefit:
  mean x velocity/local flow are `-0.0627/-0.0454`, head travel is
  `(-4.44,+1.78)L`, minimum/mean/final range is `6.63/9.45/9.43L`, progress is
  `0.241`, and release lifetime is `74.48`. RMS force/moment are finite but rise
  to `76.8/1030`; anterior speed peaks near `254 deg/time`, below the hard cap.
- The matched zero-bearing terminal policy is the clean control. It has the
  same gait, guards, `0.5L` fore/aft gate, and fixed `0.04` recent-turn damping,
  but after abeam it removes bearing instead of reversing a fraction. The
  `-0.25` policy improves its head-x travel (`-4.44` versus `-4.36L`), minimum
  range (`6.63` versus `6.64L`), progress (`0.241` versus `0.235`), mean/final
  range (`9.45/9.43` versus `9.54/9.50L`), and lifetime (`74.48` versus
  `69.37`), while also moving anterior speed off the `260 deg/time` cap. The
  load increase from `68.8/947` bounds how far this continuation should move.
- The assigned rearward-damping parent and its inherited notes show why the
  next test should not add another factor. Combining zero rearward bearing
  with a `0.02` rearward-only damping boost still exits upward after `67.24`
  time with `(-4.15,+1.80)L` head travel, despite reaching `6.57L`. Earlier
  inherited range-opening and always-active motion corrections damaged the
  useful approach. The signed fore/aft selector remains the only supported
  place to change terminal authority.
- The inherited full-circle `atan(target_body_L)` reconstruction is a strong
  negative result, not a competing direction: its sheet loses the useful
  leftward leg and turns upward almost immediately. It moves only `-0.57L` in
  x, reaches just `9.27L`, has negative progress, and raises RMS force/moment
  to `77.4/1157`. Thus a geometrically plausible replacement angle did not
  preserve the runtime bearing convention. Continue scaling the demonstrated
  bearing only after the signed gate; do not reconstruct its sign or quadrant.

## Candidate hypothesis

Start from the best sampled `-0.25` fore/aft policy and change exactly one
controller parameter: increase the behind-target bearing fraction to `-0.50`.
The oscillator, joint guards, `0.60` bearing gain, `12 deg` steering ceiling,
`0.35/0.65` curvature allocation, fixed `0.04` recent-turn damping, and `0.5L`
transition remain unchanged. Far ahead, the gate retains full demonstrated
bearing authority; only around and behind the beam does the bounded existing
bearing contribution reverse more strongly. This is a one-dimensional
continuation of the only sampled terminal change that improved progress and
lifetime, while the steering saturation limits its magnitude.

The hypothesis is supported only if the rollout remains finite, retains about
`-4.3L` upstream head travel and a `6.7L` or better approach, then materially
delays or removes the visible upper return while improving progress or
mean/final range. It is falsified if the transition damages the closing leg,
the same upper exit persists without material metric gain, a lower full return
appears, anterior speed returns to the hard cap, or loads rise materially above
the sampled `77/1030` scale. The candidate uses only normalized body-frame
target geometry and existing measured turn rate; it contains no coordinate,
clock, route, prescribed inflow, wake probe, target-station signal, or omitted
research-shelf dependency. Its CFD result is deferred to EvE and is not
claimed as current evidence.
