# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet is common initial-condition evidence: the held fish is
above and downstream of the target while the four developed cylinder streets
interact across the route. The four current sampled released sheets are exact
functional reproductions of the same controller, not an independent parameter
bracket. Each uses the `0.50` phase-opposition boost and the additive
`0.18*tanh(target_body_L[2]/2L)` request, reaches the `0.75L` target circle in
`88.13` release units, and reports identical score and diagnostics.

The successful sheet shows active diagonal self-propulsion: mean head velocity
x is `-0.124` while mean local flow x is `-0.092`, and the head moves
`(-10.92,-4.44)L`. The fish descends into the wake corridor, makes a broad but
bounded midcourse return toward the upper wake, and then turns downward through
the capture circle. Metrics corroborate the visible route: final/minimum
distance is `0.747L`, mean distance is `2.736L`, and progress is `0.940`, with
RMS relative crossflow `0.289` and RMS force/moment `445/4597`. This is route
correction evidence, not actuator desaturation: the posterior joint reaches
`45 deg`, and both joint rates and acceleration commands reach their caps.

The assigned parent's isolated `0.20` cross-track-gain result is the most
informative failure contrast. It actively swims upstream and initially passes
closer (`1.123L` versus capture at `0.747L`), but then curls nearly vertical and
exits the upper boundary at `76.17` release units. Its head displacement becomes
`(-11.03,+1.78)L`, mean distance regresses to `6.365L`, and RMS force/moment
rise to `490/4800`; the same angle, rate, and command caps remain active. The
released sheet makes clear that the `11%` authority increase restored the old
upper-hook topology rather than producing a terminal recovery. Inherited logs
likewise rule out bearing replacement, further phase-headroom, receding or
fore-aft gates, bearing-rate lead, lateral-speed/slip damping, yaw-moment
rejection, clipping, and broad distance relief as repairs for that hook.

## Single candidate hypothesis

Keep the complete reproducibly successful controller and decrease only
`cross_track_gain` from `0.18` to `0.17`. This is the first clean lower-side
bracket of the only route-changing signal. It preserves its sign, `2L`
normalization, bearing feedback, direct body-rate damping, phase allocation,
final distance fade, propulsion oscillator, posterior traveling wave, and
command ceiling. The hypothesis is that slightly less additive authority will
retain the demonstrated diagonal capture while reducing the broad midcourse
return and the associated load, without entering the upper-hook branch exposed
by `0.20`.

Support requires semantic capture and no loss of the demonstrated upstream
self-propulsion, with release time below `88.13`, mean distance below `2.736L`,
or a material reduction below `445/4597` RMS force/moment accompanied by a
comparably direct route. Loss of capture, a return to approximately `+1.8L`
terminal head-y displacement, or weaker approach without load benefit
falsifies the lower bracket and should restore the exact `0.18`, `2L` anchor.
The new CFD outcome is deliberately not claimed here; it is evidence for a
later worker after evaluation.
