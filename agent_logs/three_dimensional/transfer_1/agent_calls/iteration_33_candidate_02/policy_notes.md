# Step 33 target-policy diagnosis

## Evidence read before the edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and capture at
  `0.7480--0.7495L` after `18.199--18.749T`. The combined sheets show a
  self-propelled fish, an alternating top-down vorticity street, bilateral
  oblique Lambda2 structures, and continued undulation at capture. There is no
  sampled visual failure, wake collapse, collision, or instability; the
  informative failures are inherited lower exits rather than newly observed
  keyframes.
- Two samples are exact speed-reserve bytes and capture at `18.4525T` and
  `18.6010T`. The other two are a posterior wave-shape pulse and fixed unsafe-
  terminal steering transfer. Their wake topology is visually indistinguishable
  from the baseline, while their head/tail action clipping remains
  `68.2--68.8%/70.6--71.0%`, exact speed-limit residence remains
  `10.4--10.7%/11.3--11.6%`, and peak planar force/yaw-moment magnitudes remain
  about `0.030/0.017`. Inherited exact repeats already falsify the pulse and
  transfer as robust mechanisms, so neither is retained or scalar-tuned.
- The new exact baseline restoration is a capture, extending the inherited
  exact-policy record from `3/5` to `4/6`, but the two coherent-wake lower exits
  at `1.6463L` and `1.4642L` still prevent a robustness claim. The assigned
  parent's later outer-bearing rescue and burden-conditioned allocator also
  preserved propulsion yet exited below after `1.5629L` and `1.8544L` passes.
  This lineage therefore lacks a recovery behavior after a missed first pass,
  not propulsion or another fixed steering allocation.
- Recomputed from each sampled trajectory using the episode's eight-row history,
  `window_closing_speed_L` stays positive throughout the sub-`4L` approach.
  Its minimum is `0.340`, `0.217`, `0.644`, and `0.202L/T` for the four samples.
  A gate that begins only below `+0.10L/T` is therefore exactly inactive on all
  recorded capture paths, while any inherited closest-pass failure must cross
  zero before opening its distance and joining the lower exit.

## Candidate hypothesis

Restore the exact intercept-guarded speed-reserve carrier and add one bounded
progress-loss redirect. Outside the terminal response region, or while the
history-window distance is still closing faster than `0.10L/T`, the candidate
is the baseline exactly. When terminal closing progress fades through zero,
smoothly replace the ordinary additive steering residual with a same-signed
two-joint mean-curvature servo driven by the existing body-frame turn command.
The differential traveling-bend carrier is never attenuated. When positive
closing resumes, the redirect releases continuously back to the baseline.

This tests a second-approach capability instead of modifying the successful
first approach. Falsify it if a repeat-backed capture is lost, a missed pass
still joins the lower exit, the redirect stalls or collapses either wake, it
creates persistent static curvature, or clipping, speed residence, force, or
moment leaves the sampled speed-reserve envelope. A single capture is only a
compatibility result; useful evidence requires either an exact repeat or a
meaningfully different recovery trajectory after an initial miss.

```text
bookshelf_consulted: true
source_domain: biological C-start reorientation and sensor-modulated robotic-fish turning
source_mechanism: trigger a bounded nonsteady curvature redirect from observed route failure and release it when the desired response appears
transferable_invariant: reorientation should be gated and released by normalized geometry and measured response rather than elapsed time, while the traveling propulsive bend remains active
nontransferable_details: species-specific C-start shape, published gains, dimensional duration, exact joint phases, robot morphology, and task-specific routes
policy_translation: below the existing terminal distance gate, use normalized history-window closing speed to blend the two-joint additive steering into a bounded body-frame target-signed mean-curvature servo; preserve the state-feedback carrier and resume baseline steering when closing recovers
falsification: reject if exact-repeat capture is lost, the same lower exit survives, the active top-down or oblique wake weakens, persistent curvature or coasting appears, or actuator and load metrics leave the baseline envelope
```

## Dry checks after the edit

- Replay of the episode's eight-row closing-speed calculation gives sub-`4L`
  minima of `0.202--0.644L/T` across the four sampled captures, so the new
  progress-loss gate is identically zero on every recorded capture row.
- The deterministic static schema check finds all `48` direct `params.FIELD`
  references among the `50` returned fields, with no missing reference.
- A Julia probe is bit-identical to the exact baseline at the evidenced minimum
  positive closure, activates the redirect for a synthetic opening pass,
  returns finite commands, and produces exactly sign-mirrored commands under
  reflection of target, velocity, joints, actions, and yaw rate.
- No CFD was run; the candidate's closed-loop recovery outcome remains future
  evidence.
