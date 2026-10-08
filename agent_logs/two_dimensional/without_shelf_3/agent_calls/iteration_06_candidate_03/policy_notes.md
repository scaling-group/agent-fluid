# Wake-Policy Candidate Notes

## Visual and quantitative diagnosis

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets. This is common initial-condition
  evidence; no candidate-specific benefit is attributed to it.
- The current prefill is the strongest sampled finite controller. Its released
  keyframes show an initial turn toward the target and sustained leftward
  self-propulsion across the far wake, followed by a broad upward turn and top
  domain exit before useful wake entry. The metrics agree: head displacement
  was `(-4.08,+1.80)L`, compared with mean local flow
  `(-0.0457,+0.0024)`, and it reached `6.71L` minimum range with `0.217`
  progress. It remained finite, with RMS force/moment `66.5/958`, although its
  anterior rate guard was active (`4.36 rad/time`, near the hard rate cap) and
  its acceleration demand approached the policy soft limit.
- The sampled range-gated damping variant preserved the same gait, guards,
  `12 deg` steering ceiling, and fixed `0.04` turn damping, but added up to
  `0.02` damping inside roughly `8L`. Its keyframes show the same upward-loop
  topology beginning earlier. It exited after `53.97` rather than `65.47`
  released time, moved only `-2.48L` upstream, and never came closer than
  `8.59L`; its nearly unchanged joint extrema and RMS force/moment
  `78.2/1119` do not indicate that the extra damping relieved actuator stress.
  The inherited uniform `0.10` damping result was also worse (`-0.73L` head x,
  `9.90L` minimum range). Thus increasing derivative damping is not supported
  as the remedy for the visible loop.
- The target-blind seed is an informative opposite failure: it was mostly
  advected downward with the local crossflow (mean velocity/local-flow y
  `-0.263/-0.241`) and exited after a `-13.30L` lateral displacement. The
  target-feedback candidates avoid that immediate advection, so their bounded
  bearing sign and demonstrated angle-only gait should be preserved.
- The inherited bearing-only guarded result is not a clean reason to remove
  turn damping: it also used a larger `16 deg` ceiling, higher steering gain,
  different posterior damping, and different guards, and it produced much
  larger RMS force/moment (`350/5007`). This candidate therefore avoids a
  compound or derivative-feedback change.

## Candidate hypothesis

Keep the current oscillator, gait phasing, fixed `0.04` turn damping, joint
guards, and acceleration bound, and change only the policy-owned saturated
steering ceiling from `12 deg` to `10 deg`. At the small initial bearing the
proportional command should remain close to the demonstrated upstream course,
while large late bearing errors receive less sustained mean curvature. The
falsifiable expectation is to retain meaningful negative head-x displacement
and finite loads while delaying or eliminating the upward loop, improving on
the `6.71L` minimum range or at least the `65.47` release lifetime. Reject the
hypothesis if upstream displacement collapses toward the gated-damping result,
if minimum range worsens materially, or if joint/load excursions grow despite
the lower steering ceiling. Formal CFD evidence will be produced only after
this worker exits.
