# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion is
  therefore self-propelled rather than background advection.
- The combined top-down and oblique sheets show a coherent, alternating
  posterior wake from release through exit for the phase-selective prefill and
  for the bearing-relief parent. The prefill does not visibly destroy the 3D
  vortex train, but it follows the same long lower-going miss and lower-domain
  exit rather than bending onto the target.
- Phase-selective posterior authority is a narrow positive result: relative to
  plain bearing-gated tail relief, closest approach improves from `4.233L` to
  `3.909L`. It does not improve the termination class, final distance worsens
  from `9.176L` to `9.261L`, and pooled rate/acceleration-cap occupancy remains
  similar at about `7.7/49.6%` versus `7.7/47.5%`.
- At the prefill's closest approach (`19.938T`), target bearing is still about
  `+1.287 rad`, body lateral speed is `+0.210 U`, and yaw rate is
  `+2.203 rad/T`. For this body convention a positive bearing requests negative
  yaw, so the instantaneous response is strongly away from the target. Over
  `14--20T`, mean yaw is only `+0.021 rad/T` despite mean bearing `+0.881 rad`;
  over `20--26T`, mean yaw is only `-0.037 rad/T` at mean bearing `+1.262 rad`.
  The useful and cancelling half-strokes still nearly balance.
- The sampled phase-speed anterior residual without tail relief reaches only
  `4.859L`, retains the lower exit, and keeps a coherent but route-misaligned
  wake while pooled acceleration saturation stays near `68.3%`. Inherited
  evidence also records that feeding recent yaw into the oscillator center can
  quench both joints and the wake. These results rule out more scalar relief,
  slip, or drive tuning and rule out moving the oscillator equilibrium with a
  yaw term.

## One-candidate hypothesis

Retain the prefill's anterior/tail mean separation and phase-selective
posterior relief. Add one counter-yaw braking primitive to the anterior
acceleration: large geometric bearing enables it, observed yaw moving in the
wrong direction opens it, joint speed makes it vanish at stroke reversal, and
correct-sign yaw closes it. Because the residual is additive and disappears at
zero stroke speed, the original Van der Pol limit cycle remains the only
oscillator equilibrium. The expected effect is to brake the cancelling return
stroke without suppressing the correcting stroke, producing negative net yaw
for positive bearing while retaining the alternating wake.

Falsify this candidate if it quenches the joint cycle or wake, materially
raises saturation/load burden, fails to beat the `3.909L` closest approach,
leaves large bearing and near-zero mean corrective yaw through `14--26T`, or
retains the same lower-exit topology.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological burst redirect
source_mechanism: response-released half-cycle steering / C-start-like redirect
transferable_invariant: apply bounded extra authority only while observed geometry is large and measured turn response is wrong, then release it when the response aligns
nontransferable_details: published gains, duty ratios, species kinematics, exact vortex phase, dimensional maneuver timing, and task-specific routes
policy_translation: use body-frame bearing, normalized observed joint speed, and measured heading rate to gate a reflection-equivariant anterior acceleration pulse; preserve the centered posterior traveling-wave carrier
falsification: reject if the coherent wake or limit cycle collapses, saturation rises materially, corrective mean yaw does not emerge, closest approach exceeds 3.909L, or the lower-domain exit persists
