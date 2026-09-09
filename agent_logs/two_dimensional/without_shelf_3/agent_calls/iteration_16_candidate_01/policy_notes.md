# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The common prewarm sheet shows the held fish above and downstream of the
  target while four staggered-cylinder streets develop through the target
  corridor. In all released sheets the fish remains above and to the right of
  that corridor: it makes an actively propelled diagonal leftward leg, bends
  nose-up after closest approach, and exits the upper boundary without wake or
  capture-disk entry. This candidate therefore addresses far-field terminal
  course recovery, not wake exploitation.
- The assigned `behind_bearing_fraction=-0.15625` parent remains finite and
  actively moves upstream: mean head x velocity is about `-0.0741L/time`
  against mean local flow `-0.0505`, with head displacement
  `(-4.640,+1.794)L`. It improves progress, mean/final range, score, and load
  scale over the duplicated `-0.125` baseline, but shortens lifetime from
  `69.85` to `67.74`, worsens closest range from `6.609L` to `6.637L`, keeps
  anterior speed near the cap at about `258 deg/time`, and visibly repeats the
  upper exit. The inherited scalar rearward-authority bracket has therefore
  produced only a non-monotone approach tradeoff, not recovery.
- The sampled deep-rearward, dual-opening gate is the first terminal structure
  with a positive controlled gradient. Against its otherwise identical
  `-0.125` baseline, unloading only anterior steering allocation from `0.35`
  to `0.10` improves head-x travel from `-4.555L` to `-4.676L`, progress from
  `0.247` to `0.254`, mean/final range from `9.415/9.360L` to
  `9.342/9.266L`, score from `-11.241` to `-11.149`, and lifetime from `69.85`
  to `70.14`. It also moves anterior angle/speed from about
  `34.2 deg/260 deg/time` to `33.2 deg/251 deg/time` while holding RMS
  force/moment near `75.6/985`, below the baseline `75.9/1004`. The unchanged
  `6.609L` closest range and keyframe topology show that the gate stayed out of
  the useful closing leg and unloaded the intended joint, but its `0.10`
  terminal allocation was too weak to remove the nose-up return.
- Inherited logs rule out treating the same opening evidence as a global
  attenuation signal: an opening-gated bearing attenuation shortened the
  useful leg, while full/rearward-only bearing reversal, added turn damping,
  conditional speed damping, and full-circle bearing replacements also
  retained or worsened the exit. The supported distinction is the conjunction
  of deep-rearward geometry and two opening rates, applied locally to anterior
  curvature after the closing leg.

## Candidate hypothesis

Start from the evaluated gated candidate, including the demonstrated
`behind_bearing_fraction=-0.125` approach law and its `1L`-rearward plus dual
`0.02L/time` opening trigger. Strengthen exactly the gated terminal action by
changing `terminal_anterior_steering_fraction` from `0.10` to `0.0`: fully
remove, but do not reverse, anterior steering bias during confirmed deep
rearward opening. Keep posterior allocation fixed at `0.65`, and preserve the
oscillator, bearing gain, `12 deg` ceiling, fixed `0.04` turn damping, joint
guards, and soft acceleration limit.

This is a bounded continuation of the only sampled terminal mechanism that
preserved and modestly improved the approach while reducing the intended
anterior excursion. It should remain inactive through the `6.61L` closest
approach, then straighten the anterior joint more decisively without erasing
the posterior traveling bend. Support requires roughly `-4.6L` upstream head
travel, `6.7L` or better closest range, no increase beyond the sampled
`76/1005` RMS force/moment scale, and either a material lifetime/mean-range gain
or a visibly delayed upper return. It is falsified if the closing leg erodes,
anterior excursion or loads rise, or the same upper exit repeats without a
material navigation gain; later workers should then stop terminal-allocation
magnitude tuning and test a different late-mode control structure. The policy
uses only normalized body-frame target projection and range rates, joint state,
and recent turn rate. It contains no coordinate, clock, route, prescribed
inflow, remote probe, target-station signal, or omitted-shelf dependency. Its
CFD evaluation is deferred to EvE and is not claimed here.
