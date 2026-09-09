# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held high and downstream/right of the target while the four staggered
  cylinder streets develop and merge through the target corridor. The sheets
  are byte-identical across the sampled solvers, so they establish the wake
  state but cannot rank policies.
- The inherited `14 deg`, `0.80`-period target-aware controller is the clearest
  finite failure. Its released sheet shows an almost straight fish swept toward
  the downstream/right boundary without entering the useful merged wake. It
  exits after `16.747` with head displacement `(2.172,-0.814)L`, negative
  progress `-0.148`, mean local-flow x `+0.147`, and only `0.692` mean command
  energy. Its small relative crossflow (`0.0343`) and finite force/moment
  (`15.87/269.98`) agree that this is passive advection from insufficient gait,
  not collision or numerical instability.
- Inherited optimizer logs supply the matched progression that repairs this
  failure. Within the `0.67`-period, `0.65/0.80` posterior lag/damping family,
  `19 deg` self-propels upstream but misses at the horizon (`-5.846L` head-x,
  `5.812L` final/minimum distance), while `20 deg` enters the central corridor
  and captures at `266.255`. Stronger posterior lag/damping changes lost
  upstream travel, and a coupled `21 deg`, `0.69`-period variant rebounded from
  `3.246L` to a `3.610L` miss; those are boundaries against changing phasing or
  adding more drive.
- All four current sampled solvers are executable-equivalent `20.25 deg`,
  `0.67` controllers and reproduce the same keyframe sheet and physical
  metrics. The fish makes a broad down/up/down correction on the right, then
  straightens into the interacting wake and reaches the target from the right
  at `244.547`, with `6.452L` mean distance and head displacement
  `(-10.916,-4.187)L`. Mean velocity x `-0.04443` is more upstream than mean
  local-flow x `-0.03649`, so capture is not passive advection alone, although
  the small mean relative-flow x (`0.00793`) shows that retaining the favorable
  corridor is central to the result.
- The incumbent is already at the supported propulsion boundary: its measured
  anterior acceleration maximum is `31.055 rad/time^2`, below the `31.2` local
  guard but close to the `31.416` episode cap. RMS relative crossflow, lateral
  force, and moment remain finite at `0.1344`, `18.26`, and `362.21`. Further
  amplitude is therefore unsupported. An inherited isolated sharpening of the
  bearing scale from `0.30` to `0.28` made the visible detour larger, worsened
  mean distance from `7.218L` to `8.112L`, and raised lateral force, so stronger
  proportional bearing response is also negative local evidence.

## Candidate hypothesis

Preserve the demonstrated `20.25 deg`, `0.67` phase-shell oscillator, `0.30`
bearing scale, `10 deg` posterior bias limit, `0.65/0.80` lag/damping, and
`31.2 rad/time^2` guard. Change only the bounded bearing-rate lookahead from
`0.25` to `0.35`. For a bearing error already moving toward zero, the existing
signed rate term reduces the predicted error; the modest increase should
unwind posterior curvature earlier and reduce the visible release S-turn
without sharpening the proportional response or increasing its bounded
magnitude. At the configured `0.30 rad/time` rate clamp, the added anticipation
is at most `0.03 rad` beyond the incumbent, while propulsion and the anterior
acceleration margin are unchanged.

The next CFD rollout should preserve finite central-corridor capture while
reducing the down/up/down detour, mean distance below `6.452L`, and preferably
arrival below `244.547`, without increasing lateral force/moment or touching
the policy guard. This is a new one-axis hypothesis, not a same-worker result.
Falsify it if capture is later or lost, the fish remains farther right for more
of the route, correction switching or loads increase, or the trajectory
rebounds after approach; in that case restore the demonstrated `0.25`
lookahead and test a separately bounded corridor-retention observation rather
than more amplitude, sharper bearing scale, or stronger posterior lag.
