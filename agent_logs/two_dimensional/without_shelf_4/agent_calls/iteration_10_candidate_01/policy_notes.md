# Multi-wake candidate diagnosis

## Evidence scope

- The shared prewarm sheet shows the fish held above and downstream of four
  cylinders while their asymmetric vortex streets develop across the target
  region. Because every sample loads this same snapshot, the developed street
  is an initial condition rather than evidence for any candidate.
- All four sampled solver sheets terminate at the target; this workspace has no
  sampled failure keyframe. The informative visual comparison is therefore the
  three exactly replicated `20.25 deg` captures against the slower assigned-
  parent `20 deg` capture. The assigned parent's inherited scalar logs provide
  a separate horizon-miss boundary, but not a local keyframe sheet or stored
  policy source from which to infer that branch's control mechanism.

## Visual and metric diagnosis

- Both released sheets show a self-propelled fish, not passive advection. It
  makes a broad initial turn, crosses alternating wake bands with several
  lateral reversals, then turns into the target without collision, domain exit,
  or visible loss of joint stability. The oscillatory route is not straight,
  but it is productive because the fish enters the developed wake and continues
  upstream until capture.
- The `20.25 deg` sheet reaches the same route endpoint with 28 rendered frames
  versus 30 for `20 deg`. Metrics confirm the visual difference: release time
  improves from `266.255` to `244.547`, mean distance from `7.218L` to `6.452L`,
  and mean upstream velocity from `-0.04144` to `-0.04443`. Its magnitude
  exceeds mean local-flow x by `0.00793`, compared with only `0.00254` for the
  parent, so the gain is controller-relative upstream transport rather than a
  stronger favorable mean current.
- The gain has a bounded cost. RMS lateral force is effectively unchanged
  (`18.262` to `18.263`), while RMS moment rises from `353.206` to `362.214`
  and mean command energy rises from `667.60` to `695.75`. Total command energy
  nevertheless falls from `177752.5` to `170142.5` because capture occurs
  sooner. Maximum anterior acceleration is `31.055`, below the sampled
  candidate's `31.2` guard and the episode hard limit of about `31.416`.
- The three `20.25 deg` samples reproduce trajectory metrics exactly under the
  common prewarm. By contrast, inherited alternatives captured at `256.663`
  with `7.394L` mean distance and at `258.621` with `8.041L`, while another
  branch missed the horizon at `3.632L` final distance despite lower RMS force.
  Sampled optimizer guidance maps the degraded captures to closing-speed relief
  and constant bearing-rate-lead changes, so the broad release turn alone is
  not evidence that the retained scalar steering bundle should be retuned.

## Single candidate hypothesis

Adopt the exactly replicated `20.25 deg`, `0.67`-period propulsion shell and
raise only its local acceleration guard from `30.8` to `31.2`; preserve the
posterior `0.30` bearing scale, `0.25` rate lookahead, lag, and damping. This is
one candidate, not a parameter sweep. It should reproduce target capture near
`244.55`, mean distance near `6.45L`, positive controller-relative upstream
transport, and no failure while leaving the guard inactive. Falsify the
hypothesis on lost or materially later capture, guard contact, a corridor
rebound, or material force/moment growth; those outcomes would make a newly
observed bounded corridor-retention signal a better next test than more
propulsion amplitude or another global scalar bearing change.
