# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The shared prewarm sheet shows the held fish at the common upper-right
  release pose while the four developed cylinder streets overlap around the
  target. All sampled released sheets remain to the right of that useful wake
  region, so the evidence supports a far-field course/propulsion decision but
  not a claim about wake capture.
- The target-blind seed first moves upstream, then becomes nearly vertical and
  is swept through the lower boundary. Its head displacement is
  `(-3.55,-13.30)L`; mean y velocity `-0.263` nearly matches local-flow y
  `-0.241`, both joint-rate and acceleration caps are touched, and its `8.61L`
  minimum rebounds to `12.12L`. A visible body wave without target-relative
  yaw control is therefore not a controlled approach.
- Localized guards make the angle-only `0.75`-period gait finite. The guarded
  gain-`0.75` result exits upward after head displacement `(-2.45,+1.73)L`
  with RMS force/moment `350/5007`; the strongest guarded result adds `0.04`
  opposing recent-turn-rate feedback and improves head x to `-4.08L`, minimum
  range to `6.71L`, and loads to `66.5/958`. Its keyframes nevertheless show
  the horizontal upstream leg bending into a broad upper U-turn and top exit,
  with range rebounding to `9.73L`.
- Two evaluated descendants rule out the inherited gain and range-gating
  proposals. Reducing bearing gain from `0.60` to `0.45` leaves nearly the
  same upward head displacement (`+1.79L`) but cuts upstream displacement to
  `-0.73L` and worsens minimum range to `9.90L`. The current rollout keeps
  gain `0.60` but raises turn damping from `0.04` toward `0.06` below an
  `8L` range gate; it also exits upward, moves only `-2.48L`, and reaches just
  `8.59L`. Neither mechanism improves on the ungated `0.04` anchor.
- The inherited exact single-axis `0.06` turn-damping continuation exposes a
  useful opposite boundary. Its sheet shows a closer, orderly upstream pass
  followed by a broad descent and downstream return: minimum range improves
  to `5.41L` and finite duration to `81.91`, but head displacement becomes
  `(+2.62,-7.92)L`, final range `14.73L`, and score `-16.27`. Thus damping in
  `[0.04,0.06]` strongly changes course; `0.06` is not a safe setting even
  though its transient minimum is better.

## One candidate hypothesis

Restore the strongest finite controller exactly, except set uniform opposing
recent-turn-rate gain to the midpoint `0.05`. This removes the current
distance gate, whose early transition degraded approach, while making the
smallest evidence-backed interpolation between the `0.04` upper-U-turn result
and the exact `0.06` downstream/lower-return result. Keep bearing gain `0.60`,
the `12 deg` steering bound, the demonstrated angle-only propulsion rhythm,
posterior lag, local guards, and smooth `1600 deg/time^2` demand bound
unchanged. Every active constant remains in `target_policy_params`; the law
uses only body-frame bearing, recent turn rate, and joint state.

The next CFD rollout supports this candidate only if it retains negative head
x and finite low-load motion while shifting net y below the `+1.8L` upper-exit
regime and improving on the current rollout's `8.59L` minimum. Strong support
would improve on the `6.71L` minimum without the `0.06` controller's downstream
reversal. It is falsified if it suppresses upstream propulsion, repeats either
boundary exit, touches hard joint/action caps, or grows force/moment loads. No
outcome is claimed for this unevaluated candidate.
