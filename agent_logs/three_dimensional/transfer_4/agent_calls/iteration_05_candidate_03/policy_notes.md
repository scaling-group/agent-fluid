# Phase-space carrier-energy candidate

## Evidence diagnosis

- All four sampled rollouts are valid direct-uniform still-water runs and end in
  capture. Three independent examples use the prefilled rate-governed policy
  and reproduce the same `23.3640T`, `0.74995L`, `-0.51274776` outcome. The
  unclamped/cadence-envelope contrast captures one step earlier but scores
  worse at `-0.51527750`.
- Both combined sheets show self-propulsion, not passive advection: a compact
  wake appears behind the tail by `4T`, develops into a coherent alternating
  posterior street through `12--20T`, and bends with the fish toward the
  target. The oblique Lambda2 row confirms that the alternating structures are
  three-dimensional and remain attached to the same useful traveling-bend
  topology through terminal approach. Neither sheet shows a prewarm wake.
- The rate governor improves the useful secondary metrics without changing
  that topology: center path falls from `13.4189L` to `13.3177L`, RMS yaw rate
  from `1.5749` to `1.5537 rad/T`, peak joint angles from `27.61/37.19 deg` to
  `27.48/36.75 deg`, and exact `99.9%` rate-limit residence from
  `9.09/1.62%` to zero. It also lowers terminal speed from `0.7076U` to
  `0.6817U` while retaining capture.
- The remaining informative defect is upstream of the rate clamp. Applied
  acceleration still resides at the episode ceiling for `69.61/50.68%` of
  the rollout, only slightly below the contrast's `70.03/52.15%`. In the
  anterior joint, more than 90% of samples below `0.8` normalized joint rate
  are acceleration-clipped, whereas the final rate governor makes clipping
  vanish above its `0.96` onset. Thus another output clamp or scalar cadence
  adjustment would not test the inherited guidance's remaining hypothesis.

## Policy hypothesis

Preserve the captured controller and add a normalized phase-space load gate to
the carrier only. Measure the largest joint angle/rate utilization, smoothly
activate near the envelope, and attenuate only carrier acceleration whose
product with the matching joint rate is positive. Carrier acceleration that
brakes or reverses a joint, all target-derived steering, the posterior lag, and
the final direction-selective rate governor retain full authority. This should
reduce repeated acceleration-ceiling residence and rate buildup without
changing target polarity or erasing the coherent traveling wake.

Falsify the candidate if it loses capture, lengthens integrated distance or
center path materially, increases angle/rate residence, increases force or yaw
loads, or changes the top-down/oblique wake from a posteriorly lagged traveling
street into a weak standing wiggle. A matched or reflected rollout should also
retain the odd course response.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and reactive traveling-wave propulsion
source_mechanism: sensor-modulated oscillator energy with anterior-to-posterior phase lag
transferable_invariant: retain the observed traveling bend and modulate only state-dependent energy injection before actuator saturation
nontransferable_details: published CPG gains, dimensional cadence, species kinematics, exact vortex phase, and task-specific routes
policy_translation: use normalized joint angle and rate envelope proximity to smoothly reduce only positive-power carrier acceleration while leaving reversal, posterior lag, and body-frame target steering intact
falsification: reject if capture or reflected polarity fails, acceleration residence and loads do not fall, path or distance integral worsens materially, or either visual view loses the coherent posterior wake
