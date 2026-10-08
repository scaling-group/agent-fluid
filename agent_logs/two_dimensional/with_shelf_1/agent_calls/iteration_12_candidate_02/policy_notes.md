# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The common prewarm sheet shows the released fish above and downstream of
  four fully developed, interacting cylinder wakes, while the target lies in
  their merged second-row wake. All four sampled release sheets then show the
  same useful topology: an immediate targetward redirect, a self-propelled
  upstream traverse with a coherent fish-generated trail, and direct entry
  into the `0.75L` capture circle. None of the current samples is a failure;
  the inherited failure boundary is the predictive-bearing child that put a
  trend cue into persistent route steering and exited after `18.304` with
  negative progress, plus the slower-carrier replacement that became unstable
  with force/moment RMS `16749.8/290421`.
- The duplicated ungated response-burst policy is the arrival baseline:
  `34.8205` release time, `1.6270L` mean distance, `47151` total command
  energy, and force/moment RMS `77.09/1142.74`. The assigned parent's
  half-strength assisting-moment relief reaches in `34.8535` with `1.6285L`
  mean distance and `47158` total energy while reducing force/moment to
  `73.63/1098.03`. Full assisting-moment relief trades more arrival time
  (`34.9415`) and energy (`47298`) for lower load (`71.86/1064.16`).
- Joint-phase qualification does not preserve that load benefit. Its released
  route remains visually indistinguishable and reaches in `34.8535`, but
  force/moment rise to `82.35/1231.74`, above even the ungated policy, while
  both acceleration commands still touch `30.0` and both joint speeds still
  touch `4.5379`. Thus the reusable evidence is to keep fast environmental
  response independent of motor phase and to attenuate only optional burst
  authority; it does not support another moment-scale or gait-gain edit.

## Single candidate hypothesis

Preserve the successful oscillator, course-slip correction, raw-bearing
reserve, base half-cycle asymmetry, and mean route residual. Add one response
mechanism inside the existing extra-burst scheduler: normalize body-frame
`heading_rate` as rotation accumulated in one control period relative to the
same angular scale used by steering, and credit only the sign that turns
toward raw bearing. Combine this direct yaw response with existing recent
bearing closure so either observed target-relative closure or observed body
rotation can continuously release only the extra burst. The carrier, mean
steering, base asymmetry, reserve, and opposing-turn authority are unchanged.

Expected evidence: retain target capture and the visible redirect/upstream
topology while reducing force/moment below the ungated `77.09/1142.74`
baseline without the phase-qualified child's load increase. Falsify this
mechanism if capture is lost, the route ceases to progress monotonically into
the target region, arrival becomes worse than the `34.9415` full signed-moment
child, or either force or moment fails to improve on the ungated baseline. A
changed wake phase is still required before claiming robustness.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction control
source_mechanism: release a bounded redirect burst when measured heading response appears while retaining the underlying propulsive rhythm
transferable_invariant: separate persistent body-frame route error from fast observed yaw response, and remove only surplus maneuver authority when yaw already assists the requested turn
nontransferable_details: species-specific C-start kinematics, published CPG gains, dimensional turn timing, exact vortex phase, and any fixed cylinder-relative route
policy_translation: soft-sign raw bearing classifies heading_rate; rotation per control period is normalized by steering bearing scale and attenuates only response-scheduled extra half-cycle asymmetry
falsification: reject if target capture or route topology is lost, arrival exceeds the full signed-moment child, or force/moment do not fall below the ungated response-burst baseline
