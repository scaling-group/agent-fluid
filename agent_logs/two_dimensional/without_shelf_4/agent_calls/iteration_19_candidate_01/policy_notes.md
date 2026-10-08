# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared-prewarm sheet shows the fish fixed at the common upper-right
  release pose while the four staggered-cylinder streets develop into an
  overlapping wake through the target corridor. This is common
  initial-condition evidence only and does not rank policies.
- All four current solver samples reproduce the finite `0.015 L/time` pure
  rolling-closing-speed anchor and its outcome exactly. The released sheet
  shows an actively oscillating fish making a broad release turn, crossing
  several wake bands, and finally entering the target nearly horizontally
  without collision, instability, rebound, or exit. Each run captures at
  `210.370`, scores `-3.528`, and has `5.519L` mean distance and `4.293L`
  maximum lateral offset.
- The anchor is self-propelled through the developed wake rather than merely
  advected: mean upstream head speed is `0.05223L/time` while mean local-flow
  magnitude in x is `0.03551`, leaving `0.01672` controller-relative upstream
  transport. Its maximum anterior acceleration remains `31.055 rad/time^2`
  under the `31.2` policy guard; RMS relative crossflow/force/moment are
  `0.13289/18.426/363.057`, and total effort is `147846.5`.
- The inherited symmetric `0.0125 L/time` probe is the most informative
  failure. Its sheet follows the broad early acquisition loop and remains
  actively propelled, but after approaching to `1.580L` it turns sharply
  upward and leaves the top boundary. Diagnostics agree with the visible
  corridor loss: lateral excursion grows from the anchor's `4.293L` to
  `5.829L`, final head displacement changes from `-3.872L` downward to
  `+1.534L` upward, relative crossflow rises to `0.14073`, and effort rises to
  `172081.8`. An unchanged `31.055` anterior-acceleration maximum and positive
  `0.00941` upstream margin rule out lost propulsion or a new drive limit; the
  failure is selector timing and recovery, not insufficient thrust.
- The inherited sign-split comparator kept `0.015` while closing but softened
  the receding side to `0.020`. Its sheet remains finite and captures `3.899`
  time units earlier, with lower effort (`142752.2`) and force/moment
  (`18.368/356.178`), but the large-error route is broader: mean distance
  worsens to `5.943L`, score to `-3.956`, and upstream margin to `0.01215`.
  Thus receding-side sharpness materially selects the acquisition corridor;
  softening it does not preserve the anchor's route quality. Together with the
  inherited failed progress/drift blend, this supports retaining pure rolling
  progress and the anchor's receding response.

## Single candidate hypothesis

Preserve the replicated `20.25 deg`, `0.67`-period propulsion shell, posterior
lag/damping, `10 deg` steering bound, `0.30` bearing scale, `0.25`
bearing-rate lead, target-away lateral gate, `0.07--0.08` lookahead envelope,
`0.10` lateral-velocity clamp, and `31.2` acceleration guard. Keep rolling
closing speed as the only selector input. Split its scale by sign in the
opposite direction from the inherited comparator: use `0.0125 L/time` only
for positive closing speed and retain the replicated-safe `0.015 L/time` for
zero or negative closing speed.

This is the mirror isolation needed to interpret the symmetric `0.0125`
failure. It tests whether sharper endpoint selection is useful while the fish
is already progressing, while the anchor's receding response remains
available immediately after a stall or rebound to prevent the observed upward
escape. The selector stays continuous at zero and bounded inside the fully
evaluated `0.07--0.08` lookahead interval. It adds no coordinate, route,
clock, prescribed inflow, remote wake probe, new observation, or steering
authority.

The fixed-prewarm expectation is retained capture with score above `-3.528`
or mean distance below `5.519L`, without arrival later than `210.370`,
excursion beyond `4.293L`, loss of positive upstream margin, guard contact, or
material growth beyond the anchor's crossflow, force/moment, and effort. A
near-entry rebound, upward corridor escape, wider far-field loop, worse
distance integral, later or lost capture, visible switching, or load growth
falsifies closing-side sharpening and means later workers should restore the
symmetric `0.015` anchor rather than narrow either side further. No same-worker
CFD outcome is claimed.
