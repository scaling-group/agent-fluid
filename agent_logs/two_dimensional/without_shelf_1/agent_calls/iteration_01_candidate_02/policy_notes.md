# Wake-policy candidate diagnosis

## Evidence read before policy changes

- The assigned parent and sole sampled solver is the deliberately naive
  state-only oscillator in `solver_8f63ea428aae`; there are no inherited
  optimizer logs in this workspace. Its finite score is `-14.294201`, with
  `left_domain` termination after only `50.13` released time units.
- The shared prewarm sheet shows the fish held above and downstream of the
  four-cylinder array while a developed, vertically broad multi-street wake
  passes through the target region. This is common initial-condition evidence,
  not a parent-policy effect.
- In the released keyframes the fish does not first establish a diagonal line
  toward the target/wake corridor. It rotates into a steep descent near the
  right side, is carried through strong crossflow while continuing a large
  tailbeat, and exits after passing well below the target. The metrics agree:
  head displacement is `(-3.55, -13.30)L`, minimum distance improves to
  `8.61L` but final distance returns to `12.12L`, and net progress is only
  `0.024`.
- Motion is predominantly advective rather than useful self-propulsion in
  this failed segment: mean world velocity `(-0.073, -0.263)` nearly follows
  mean local flow `(-0.041, -0.241)`, while RMS relative crossflow is `0.175`.
  The `32.83` tailbeat/shedding-frequency ratio, acceleration saturation at
  `31.42`, velocity saturation at `4.54`, command-energy mean `1496`, and RMS
  moment `541.7` show that vigorous actuation did not provide directional
  authority.

## Single candidate hypothesis

Retain a state-encoded two-joint traveling bend, but slow and reduce it so the
joint targets stay away from persistent rate/acceleration saturation. Add a
bounded target-bearing curvature bias to the posterior-joint target. The bias
uses only body-frame task error and reverses continuously with bearing; it does
not encode coordinates, route, wake phase, or elapsed time. In this convention
positive bearing places the target on the positive body-y side while forward is
negative body-x, so the tail-tangent bias has the opposite sign.

The next CFD evaluation should falsify or support the hypothesis by checking
whether the fish remains in-domain beyond `50.13`, makes substantially more
than `3.55L` upstream displacement before comparable descent, and lowers joint
saturation and moment load while reducing mean/final target distance. A mere
longer survival with no distance progress would disprove useful propulsion;
sign-reversed early departure from the target would disprove the steering
convention. No benefit from the unevaluated candidate is claimed here.
