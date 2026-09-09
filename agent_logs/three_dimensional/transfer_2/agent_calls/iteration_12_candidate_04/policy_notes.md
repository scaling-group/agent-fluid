# Joint-rate-headroom target-policy candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen evidence contract: direct
  uniform initialization, `U_infinity=(0,0,0)`, no cylinders or prewarm,
  stable finite dynamics, and `capture` termination. They capture from
  `12.328L` in `19.706--19.987T`, with distance integrals
  `2.10594--2.11652L` and scores `-0.21598--0.22648`. There is no semantic
  failure in this batch, so `solver_c25cd0071858` is only the most informative
  regression-side comparator.
- Both rows of every combined keyframe sheet were inspected. In particular,
  the best sample (`solver_1b6df3d71b19`) and regression-side sample
  (`solver_c25cd0071858`) both self-propel from quiescent water: their
  top-down rows form coherent alternating posterior vortices behind a small
  beat-scale path oscillation, then a bounded terminal C-bend into the capture
  circle. Their oblique rows retain compact three-dimensional Lambda2
  structures along the route. Neither shows advection, wake collapse,
  collision, domain exit, or numerical instability before capture. The
  visually similar wakes and only `0.281T` arrival spread do not support a
  carrier-frequency, amplitude, or morphology change.
- Metrics expose an actuator-side limitation shared by all four policies:
  both joints reach exactly `4.5379 rad/T`, the `260 deg/T` rate limit. Peak
  planar force and yaw-moment coefficients stay tightly bounded at about
  `0.0244--0.0246` and `0.0129--0.0132`, and joint angles remain below
  `0.60 rad`, but `32.7--36.1%` of commands exceed 90% of the smooth
  `31 rad/T^2` command bound. Thus wake and geometric authority are adequate
  while substantial command is spent at a velocity boundary that cannot
  produce additional joint speed.
- The two best-scaffold samples are a direct repeat control: the candidate
  sources for `solver_1b6df3d71b19` and `solver_48e2d2ec80b2` differ only in
  comments and the logged version string, yet span `19.706--19.888T`,
  `2.10594--2.11324L`, and scores `-0.21598--0.22270`. Any claimed improvement
  smaller than this observed repeat spread needs support from effort, load,
  joint-margin, trajectory, or wake diagnostics rather than rank alone.
- Inherited completed logs discourage another terminal steering gate. Full
  redirect response release captured at `19.850T/-0.22093`, LOS-coherence
  gating captured at `19.987T/-0.22648`, and anterior-only response release
  later captured at `-0.22325`; these remain inside or below the repeat band.
  Course-gated carrier relief and posterior redirect phase allocation also
  regressed. The current candidate therefore does not reuse course error,
  yaw response, or LOS agreement to allocate another steering term.

## One-candidate hypothesis

Preserve the sampled traveling-bend carrier, posterior lag, fore/aft-aware
body-frame target map, distance/positive-closing relief, half-cycle route
steering, velocity-course redirect, and line-of-sight lead. Add one bounded
joint-state headroom mechanism after those two raw accelerations are formed:
as measured absolute joint rate enters the final fraction of the configured
rate reference, remove only the component of acceleration aligned with that
joint velocity. Leave opposing acceleration unchanged so return strokes,
turn reversal, and the established posterior traveling wave remain available.
The mechanism uses neither time nor route memory and applies symmetrically to
both joints.

Expected signature: retain capture, the `19.7--19.9T` arrival class, the
coherent top-down/oblique wake class, and the approximately `0.025/0.013`
load envelope while materially reducing residence above 90% of the command
bound without increasing joint-rate-limit residence. Falsify the transfer if
capture timing or distance integral regresses beyond the measured repeat
spread, the terminal arc turns outward, propulsion/wake coherence weakens,
joint-rate residence increases, or command/load metrics fail to improve.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded rhythmic actuation
source_mechanism: use measured actuator state to stop driving farther into a saturated stroke while preserving the traveling-wave return stroke
transferable_invariant: retain the rhythmic carrier and target feedback, but smoothly withdraw only actuation that has no velocity headroom
nontransferable_details: published CPG gains, species-specific kinematics, dimensional cadence, exact vortex phase, world-frame routes, and actuator models from other robots
policy_translation: normalize each observed joint rate by a policy-owned rate reference and attenuate only same-sign raw joint acceleration near that reference before the existing soft command limit
falsification: reject if capture or distance integral leaves the repeat band, command or rate-limit residence does not fall, loads increase, or either wake view loses coherence
