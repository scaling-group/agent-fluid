# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish above/right of the target and
  four fully developed, interacting cylinder streets crossing the target
  region. The released sheets start from that same flow state, so differences
  in their far-field paths are controller effects. None of the sampled fish
  reaches the target-centered wake corridor; the immediate problem remains
  course recovery after a productive upstream leg, not wake exploitation.
- The current prefill is the strongest sampled finite result. Its sheet shows
  active, nearly horizontal leftward swimming followed by a nose-up turn and
  upper-domain exit. This is self-propulsion rather than passive advection:
  mean x velocity/local flow are `-0.0678/-0.0477`, while head travel is
  `(-4.36,+1.80)L`. It reaches `6.64L`, has progress `0.235`, and keeps RMS
  force/moment finite at `68.8/947`, but finishes back at `9.50L`. Its sharp
  `0.5L` fore/aft gate removes the supplied aliased-bearing term behind the
  body-frame beam, so the evaluation establishes that bearing removal alone
  preserves the useful leg but does not turn the fish back toward the target.
- The assigned parent's broader cosine-like ahead gate is a concrete negative
  result. Its sheet turns upward before any useful leftward leg, moves the head
  only `(+0.01,+1.78)L`, reaches just `9.63L`, has progress `-0.059`, and exits
  after `51.78` released time. Mean x velocity/local flow are
  `-0.0090/+0.0119`, so this variant neither generates the sampled prefill's
  upstream travel nor approaches by flow advection. Although RMS force/moment
  stay finite at `70.8/1004`, joint one touches the `260 deg/time` speed cap.
  A gate based on forward projection divided by total range therefore changes
  authority too early as heading rotates and must not be treated as equivalent
  to the late `0.5L` fore/aft transition.
- The other sampled failures reinforce that the target-ahead law should remain
  fixed. Adding rearward turn damping retains a similar approach (`-4.23L`
  head x, `6.71L` minimum range) but still produces the upper exit. Range-gated
  damping and always-active body-lateral-velocity subtraction shorten upstream
  travel to `-2.48L` and `-2.72L`, worsen minimum range to `8.59L` and `8.20L`,
  and raise RMS loads. Inherited logs likewise reject adjacent fixed damping,
  steering-ceiling, bearing-gain, range-opening, absolute-bearing-rolloff, and
  static steering-allocation changes.

## Candidate hypothesis

Preserve the current prefill's oscillator, guards, curvature allocation,
`12 deg` steering ceiling, `0.60` gain, and fixed `0.04` recent-turn damping.
Change only the angular target signal. The testbed's compact `state.bearing`
uses `abs(forward_distance)`, which aliases a target ahead and behind. Compute
an unaliased pursuit angle as `atan(lateral_target_L, forward_target_L)` from
the exposed normalized body-frame target vector. While the target is more than
`0.25L` ahead this is exactly the same angle as `state.bearing`, so the
demonstrated approach is unchanged. At and behind the beam it retains a
bounded, correctly large turn request instead of reducing target authority to
zero and leaving an upward heading to persist. Existing steering saturation
still limits the curvature request to `12 deg`.

This isolated observation fix is supported only if the rollout remains finite,
retains roughly `-4.2L` upstream head travel and a closest range no worse than
`6.7L`, then delays or removes the upper exit without materially exceeding the
sampled `69/947` force/moment scale. It is falsified if unaliased rear-target
authority triggers an earlier loop, repeats either boundary exit, chatters as
the lateral target component changes sign, worsens the approach, or increases
joint/load extrema. The policy uses only normalized body-frame target geometry
and contains no coordinates, target identity, clock, route, prescribed inflow,
remote wake probe, station-flow signal, or omitted-shelf dependency. Its CFD
outcome will be produced only after this worker exits and is not claimed here.
