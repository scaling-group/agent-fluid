# Multi-wake candidate diagnosis and hypothesis

## Visual diagnosis

- The shared prewarm sheet is a common initial condition: at release the fish
  is above and downstream of the target, and four mature interacting vortex
  streets occupy the route to the second-row station. Candidate differences
  therefore begin after the same held-fish flow state.
- The target-blind seed sustains a visible body wave and moves its head
  `-3.55L` upstream, but its path bends almost straight out of the lower domain
  (`-13.30L` lateral displacement). Both acceleration and joint-rate caps are
  reached; its `8.61L` transient minimum becomes a `12.12L` final range.
  Propulsion without target-relative course regulation is not enough.
- The unguarded positive-bearing angle-only oscillator is the clearest active
  approach: its first four frames move predominantly upstream, agreeing with
  `-3.59L` head-x displacement, only `+0.15L` head-y displacement, and `0.259`
  progress. Its terminal sheet instead shows a tightly folded fish. Both
  acceleration commands reach `31.416 rad/time^2`, and RMS force/moment rise to
  `20023.6/314391` before `unstable_dynamics` at `33.06`.
- The assigned parent keeps the same angle-only propulsion architecture and
  adds local guards, but has no turn-rate damping. It remains finite for
  `47.35` time and moves `-2.45L` upstream, yet its keyframes show a broad turn
  toward the upper boundary. Final/minimum range `11.00/10.35L`, RMS
  force/moment `349.6/5007`, and left-domain termination show that guarding
  alone neither arrests the course error nor keeps loads low.
- The best finite sampled policy adds recent-turn damping `0.04`, lowers the
  steering bound, and uses gentler guards. It extends survival to `65.47`,
  improves minimum range to `6.71L`, moves `-4.08L` upstream, and reduces RMS
  force/moment to `66.5/958`. The keyframes nevertheless show the initially
  useful leftward path curling upward and exiting before wake entry; its final
  range rebounds to `9.73L` and head-y displacement is `+1.80L`.
- The inherited `0.10` turn-damping rollout supplies the complementary
  boundary with the otherwise same gait and guards. Its keyframes turn sharply
  downward, then curl downstream and leave the lower/right side. Metrics agree:
  head displacement is `(+2.88,-8.58)L`, progress is `-0.220`, and minimum
  range `11.31L`. Uniformly increasing recent-turn damping therefore suppresses
  the useful upstream mode rather than curing the best rollout's late loop.
  The inherited low-effort candidate also exits downstream after only `10.02`
  time with RMS force/moment `4188/48543`, so command effort is not a safe proxy
  for wake-load stability.

## Single candidate hypothesis

Start from the best finite `0.04` recent-turn-damped policy, preserving its
demonstrated upstream gait, steering bound, local guards, and smooth action
envelope. Add one bounded state-dependent mechanism: retain damping `0.04`
through the far-field leg, then smoothly add at most `0.02` as normalized
target range crosses below `8L`. This uses the supplied scale-normalized target
distance without coordinates, elapsed time, or a prescribed route. Unlike the
failed uniform `0.10`, the scheduled gain remains below `0.06` and should be
negligible during the productive initial approach, becoming material only in
the neighborhood of the sampled `6.71L` closest approach where the visible
upper-domain loop develops.

The next CFD rollout supports the mechanism only if it preserves negative
head-x displacement and finite low-load behavior while converting the late
distance rebound into target-directed lateral progress, improving final range
without losing the `6.71L` minimum. It is falsified if the range-scheduled gain
reproduces the inherited stronger-damping downstream/lower topology, merely
delays an upper exit, or restores joint-cap contact or folded-body loads. The
`8L` transition is an evidence-local target-relative scale, not established as
universal; it must be retested when the release range changes. No same-worker
rollout or target capture is claimed.
