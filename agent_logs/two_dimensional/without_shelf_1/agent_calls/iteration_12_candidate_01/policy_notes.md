# Candidate wake-policy notes

## Evidence diagnosis

The shared prewarm sheet is common initial-condition evidence: the held fish is
above and downstream of four developed cylinder streets, while the target lies
between the second-row wakes. The released sheets show self-propulsion rather
than passive advection. The full `11 deg` anchor moves its head `-7.89L` in x
while mean local x flow is only `-0.0995`, closes to `4.87L`, and reaches
`0.424` progress. It nevertheless stays above the useful target corridor,
changes from a nearly horizontal upstream leg into a broad upward yaw curl,
and exits the upper boundary after `+1.79L` head-y displacement. This agrees
with its posterior peak of `0.781 rad`, joint rate/command-cap contacts, and
RMS force/moment of `406/4113`.

The sampled distance relief and forward-target gate retain the same roughly
`+1.8L` upper exit while reducing upstream travel to `-7.19L` and `-7.11L`.
The assigned parent's absolute body-lateral-velocity damping is a stronger
negative result: relative to the full anchor, `0.20*tanh(v_body,y/0.10)` cuts
upstream head travel from `-7.89L` to `-4.41L`, worsens closest approach from
`4.87L` to `5.82L`, lowers progress from `0.424` to `0.239`, and raises RMS
force/moment from `406/4113` to `428/4648`, yet head-y exit remains `+1.79L`.
An inherited speed-normalized slip variant is less destructive but still
regresses travel/approach to `-6.79L`/`5.47L` and retains `+1.77L` head-y
exit. Instantaneous lateral velocity is therefore not a usable proxy for this
route error under either tested normalization.

## Single candidate hypothesis

Restore the full sampled `11 deg`, `0.70/0.35` anchor and leave the anterior
oscillator, posterior traveling-wave lag, distance fade, and command ceiling
unchanged. Add only a small bounded rejection term from the normalized
hydrodynamic yaw moment to the posterior steering command. The rollout's RMS
moment range of roughly `3331--4648`, divided by `L^2=4096` as the policy
observation is defined, places the signal near order one. Use a unit scale and
a `0.15` gain, so the correction is zero at zero moment and can alter the
bounded steering command by at most fifteen percent. Its sign matches the
existing heading-rate damping: a moment that would increase yaw is opposed
before it accumulates into the late curl.

This probe is supported only if it preserves the anchor's upstream travel and
approach while reducing the upper curl/head-y displacement and either moment
load or saturation. It is falsified if travel falls materially, the exit stays
near `+1.8L`, or oscillatory moment feedback increases load/limit contact. In
that case later workers should restore the plain `11 deg` anchor and avoid
instantaneous load feedback until the observation contract offers a filtered
load signal.
