# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the fish held above and downstream of the
  target while the four staggered cylinder streets develop through the target
  corridor. Every released sheet inspected stays above and to the right of
  that corridor. The fish is not merely advected: in the strongest sample its
  mean x velocity is `-0.0627` versus local flow `-0.0454`. It nevertheless
  turns nose-up after the closing leg and exits the upper domain without
  entering the useful wake region, so the unresolved regime is far-field
  course retention rather than wake exploitation or tight capture.
- The four current samples form a matched rearward-control bracket and share
  that visible upper-return topology. The fixed-`0.04` damping,
  `behind_bearing_fraction=-0.25` policy is the strongest by score and
  lifetime: score `-11.286`, release time `74.48`, head travel
  `(-4.44,+1.78)L`, mean/final/minimum range `9.45/9.43/6.63L`, and progress
  `0.241`. Its finite RMS force/moment are `76.8/1030`, and its anterior speed
  still reaches about `254 deg/time`, so it is an approach anchor rather than
  a demonstrated recovery or low-load solution.
- The current coupled prefill removes bearing and adds `0.02` turn damping
  after abeam. It obtains a slightly smaller transient minimum range (`6.57L`)
  but exits sooner (`67.24`), moves less far upstream (`-4.15L`), and worsens
  mean/final range to `9.68/9.67L`, progress to `0.222`, and score to
  `-11.566`. The two remaining current samples likewise retain the upper exit;
  zero rearward bearing alone reaches `6.64L`, while rearward damping with the
  aliased bearing left active reaches `6.71L`.
- The assigned parent's conditional speed-guard test falsifies the previous
  next-step hypothesis. Raising overspeed damping from `6` to `18` after abeam
  lowers the anterior peak only from roughly `254` to `250 deg/time`, retains
  the nose-up exit, cuts upstream travel to `-3.71L`, worsens mean/final range
  to `9.94/10.01L`, and lowers progress to `0.194`. Lower RMS moment (`925`) is
  not a navigation recovery.
- The other inherited terminal continuation is negative too. Extending the
  behind-target bearing fraction from `-0.25` to `-0.50` visibly repeats the
  same upper turn, moves only `-3.49L` upstream, reaches `6.76L`, worsens
  mean/final range to `10.12/10.18L`, and lowers progress to `0.180`. Together
  with the sampled full, zero, and `-0.25` variants, this closes further local
  interpolation of rearward bearing, added turn damping, and conditional
  overspeed damping.

## Candidate hypothesis

Replace the inferior coupled prefill with exactly the strongest evaluated
finite anchor: retain the oscillator, guards, `0.60` bearing gain, `12 deg`
steering ceiling, `0.35/0.65` curvature allocation, and fixed `0.04` recent-turn
damping; use the evaluated signed fore/aft gate with
`behind_bearing_fraction=-0.25` and no rearward damping or speed-guard boost.
This is an evidence-based exploitation candidate after both adjacent terminal
continuations failed, not a claim that the known upper-exit topology has been
solved.

The candidate is supported for this common prewarm if reevaluation reproduces
roughly `-4.4L` upstream head travel, a `6.6L` closest approach, `0.24`
progress, and a longer lifetime and better mean/final range than the current
coupled prefill. It remains falsified as a complete task policy by the sampled
upper exit, lack of wake entry, `9.43L` final range, and higher loads. Later
structural tests should preserve this target-ahead leg and avoid treating
conditional speed clipping or stronger rearward bearing as a recovery
mechanism. The controller uses only normalized body-frame target geometry,
joint state, and measured recent turn rate; it contains no coordinate, clock,
route, prescribed inflow, remote probe, target-station signal, or omitted-shelf
dependency.
